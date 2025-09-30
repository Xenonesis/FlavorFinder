import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum BiometricType {
  none,
  fingerprint,
  face,
  iris,
}

enum AuthenticationStatus {
  unknown,
  authenticated,
  failed,
  cancelled,
  notAvailable,
  notEnrolled,
}

class BiometricAuthService {
  static final BiometricAuthService _instance = BiometricAuthService._internal();
  factory BiometricAuthService() => _instance;
  BiometricAuthService._internal();

  final LocalAuthentication _localAuth = LocalAuthentication();
  
  static const String _biometricEnabledKey = 'biometric_enabled';
  static const String _lastAuthTimeKey = 'last_auth_time';
  static const String _authAttemptsKey = 'auth_attempts';
  static const int _maxAuthAttempts = 3;
  static const int _lockoutDurationMinutes = 5;

  Future<bool> isBiometricAvailable() async {
    try {
      final isAvailable = await _localAuth.canCheckBiometrics;
      final isDeviceSupported = await _localAuth.isDeviceSupported();
      return isAvailable && isDeviceSupported;
    } catch (e) {
      return false;
    }
  }

  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      final availableBiometrics = await _localAuth.getAvailableBiometrics();
      return availableBiometrics.map((biometric) {
        switch (biometric) {
          case BiometricType.fingerprint:
            return BiometricType.fingerprint;
          case BiometricType.face:
            return BiometricType.face;
          case BiometricType.iris:
            return BiometricType.iris;
          default:
            return BiometricType.none;
        }
      }).toList();
    } catch (e) {
      return [];
    }
  }

  Future<AuthenticationStatus> authenticateWithBiometrics({
    String reason = 'Please authenticate to continue',
    bool useErrorDialogs = true,
    bool stickyAuth = true,
  }) async {
    try {
      // Check if biometric is available
      if (!await isBiometricAvailable()) {
        return AuthenticationStatus.notAvailable;
      }

      // Check if user has enrolled biometrics
      final availableBiometrics = await getAvailableBiometrics();
      if (availableBiometrics.isEmpty) {
        return AuthenticationStatus.notEnrolled;
      }

      // Check if user is locked out due to too many failed attempts
      if (await _isLockedOut()) {
        return AuthenticationStatus.failed;
      }

      // Perform authentication
      final isAuthenticated = await _localAuth.authenticate(
        localizedFallbackTitle: 'Use PIN',
        authMessages: [
          AndroidAuthMessages(
            signInTitle: 'Biometric Authentication',
            biometricHint: 'Touch the fingerprint sensor',
            biometricNotRecognized: 'Biometric not recognized, try again',
            biometricRequiredTitle: 'Biometric Required',
            biometricSuccess: 'Biometric authentication successful',
            cancelButton: 'Cancel',
            deviceCredentialsRequiredTitle: 'Device Credentials Required',
            deviceCredentialsSetupDescription: 'Please set up device credentials',
            goToSettingsButton: 'Go to Settings',
            goToSettingsDescription: 'Please set up biometric authentication',
          ),
          IOSAuthMessages(
            cancelButton: 'Cancel',
            goToSettingsButton: 'Go to Settings',
            goToSettingsDescription: 'Please set up biometric authentication',
            lockOut: 'Please re-enable biometric authentication',
          ),
        ],
        options: AuthenticationOptions(
          useErrorDialogs: useErrorDialogs,
          stickyAuth: stickyAuth,
          biometricOnly: false,
        ),
      );

      if (isAuthenticated) {
        await _recordSuccessfulAuth();
        return AuthenticationStatus.authenticated;
      } else {
        await _recordFailedAuth();
        return AuthenticationStatus.failed;
      }
    } catch (e) {
      await _recordFailedAuth();
      return AuthenticationStatus.failed;
    }
  }

  Future<bool> isBiometricEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_biometricEnabledKey) ?? false;
  }

  Future<void> setBiometricEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_biometricEnabledKey, enabled);
  }

  Future<bool> authenticateForPayment({
    required double amount,
    String? merchantName,
  }) async {
    final reason = merchantName != null
        ? 'Authenticate to pay \$${amount.toStringAsFixed(2)} to $merchantName'
        : 'Authenticate to complete payment of \$${amount.toStringAsFixed(2)}';

    final result = await authenticateWithBiometrics(
      reason: reason,
      useErrorDialogs: true,
      stickyAuth: true,
    );

    return result == AuthenticationStatus.authenticated;
  }

  Future<bool> authenticateForOrderAccess() async {
    final result = await authenticateWithBiometrics(
      reason: 'Authenticate to view your orders',
      useErrorDialogs: true,
      stickyAuth: false,
    );

    return result == AuthenticationStatus.authenticated;
  }

  Future<bool> authenticateForProfileAccess() async {
    final result = await authenticateWithBiometrics(
      reason: 'Authenticate to access your profile',
      useErrorDialogs: true,
      stickyAuth: false,
    );

    return result == AuthenticationStatus.authenticated;
  }

  Future<bool> _isLockedOut() async {
    final prefs = await SharedPreferences.getInstance();
    final attempts = prefs.getInt(_authAttemptsKey) ?? 0;
    final lastAuthTime = prefs.getInt(_lastAuthTimeKey) ?? 0;
    
    if (attempts >= _maxAuthAttempts) {
      final lockoutEndTime = lastAuthTime + (_lockoutDurationMinutes * 60 * 1000);
      final currentTime = DateTime.now().millisecondsSinceEpoch;
      
      if (currentTime < lockoutEndTime) {
        return true;
      } else {
        // Lockout period has ended, reset attempts
        await prefs.setInt(_authAttemptsKey, 0);
        return false;
      }
    }
    
    return false;
  }

  Future<void> _recordSuccessfulAuth() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_authAttemptsKey, 0);
    await prefs.setInt(_lastAuthTimeKey, DateTime.now().millisecondsSinceEpoch);
  }

  Future<void> _recordFailedAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final currentAttempts = prefs.getInt(_authAttemptsKey) ?? 0;
    await prefs.setInt(_authAttemptsKey, currentAttempts + 1);
    await prefs.setInt(_lastAuthTimeKey, DateTime.now().millisecondsSinceEpoch);
  }

  Future<int> getRemainingLockoutTime() async {
    final prefs = await SharedPreferences.getInstance();
    final attempts = prefs.getInt(_authAttemptsKey) ?? 0;
    final lastAuthTime = prefs.getInt(_lastAuthTimeKey) ?? 0;
    
    if (attempts >= _maxAuthAttempts) {
      final lockoutEndTime = lastAuthTime + (_lockoutDurationMinutes * 60 * 1000);
      final currentTime = DateTime.now().millisecondsSinceEpoch;
      final remainingTime = lockoutEndTime - currentTime;
      
      return remainingTime > 0 ? remainingTime : 0;
    }
    
    return 0;
  }

  Future<String> getBiometricTypeString() async {
    final availableBiometrics = await getAvailableBiometrics();
    
    if (availableBiometrics.contains(BiometricType.face)) {
      return 'Face ID';
    } else if (availableBiometrics.contains(BiometricType.fingerprint)) {
      return 'Fingerprint';
    } else if (availableBiometrics.contains(BiometricType.iris)) {
      return 'Iris';
    } else {
      return 'Biometric';
    }
  }

  Future<Map<String, dynamic>> getBiometricInfo() async {
    final isAvailable = await isBiometricAvailable();
    final availableBiometrics = await getAvailableBiometrics();
    final isEnabled = await isBiometricEnabled();
    final biometricType = await getBiometricTypeString();
    final isLockedOut = await _isLockedOut();
    final remainingLockoutTime = await getRemainingLockoutTime();

    return {
      'isAvailable': isAvailable,
      'availableBiometrics': availableBiometrics,
      'isEnabled': isEnabled,
      'biometricType': biometricType,
      'isLockedOut': isLockedOut,
      'remainingLockoutTime': remainingLockoutTime,
    };
  }

  Future<void> resetAuthAttempts() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_authAttemptsKey, 0);
  }

  Future<bool> shouldPromptForBiometricSetup() async {
    final isAvailable = await isBiometricAvailable();
    final isEnabled = await isBiometricEnabled();
    final availableBiometrics = await getAvailableBiometrics();
    
    return isAvailable && !isEnabled && availableBiometrics.isNotEmpty;
  }
}
