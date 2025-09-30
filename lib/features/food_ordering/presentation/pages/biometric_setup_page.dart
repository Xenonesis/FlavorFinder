import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../data/services/biometric_auth_service.dart';

class BiometricSetupPage extends StatefulWidget {
  final bool isInitialSetup;

  const BiometricSetupPage({
    Key? key,
    this.isInitialSetup = false,
  }) : super(key: key);

  @override
  State<BiometricSetupPage> createState() => _BiometricSetupPageState();
}

class _BiometricSetupPageState extends State<BiometricSetupPage>
    with TickerProviderStateMixin {
  final BiometricAuthService _biometricService = BiometricAuthService();
  
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  bool _isLoading = true;
  bool _isBiometricAvailable = false;
  bool _isBiometricEnabled = false;
  List<BiometricType> _availableBiometrics = [];
  String _biometricType = '';
  bool _isAuthenticating = false;

  @override
  void initState() {
    super.initState();
    
    _fadeController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    
    _scaleController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _initializeBiometricInfo();
  }

  Future<void> _initializeBiometricInfo() async {
    try {
      final info = await _biometricService.getBiometricInfo();
      
      setState(() {
        _isBiometricAvailable = info['isAvailable'];
        _isBiometricEnabled = info['isEnabled'];
        _availableBiometrics = List<BiometricType>.from(info['availableBiometrics']);
        _biometricType = info['biometricType'];
        _isLoading = false;
      });

      _fadeController.forward();
      await Future.delayed(Duration(milliseconds: 200));
      _scaleController.forward();
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biometric Security'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: _isLoading ? _buildLoadingView() : _buildContent(),
    );
  }

  Widget _buildLoadingView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/animations/fingerprint_scan.json',
            width: 150,
            height: 150,
          ),
          SizedBox(height: 24),
          Text(
            'Checking biometric availability...',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    if (!_isBiometricAvailable) {
      return _buildNotAvailableView();
    }

    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: AnimationLimiter(
            child: Column(
              children: AnimationConfiguration.toStaggeredList(
                duration: Duration(milliseconds: 600),
                childAnimationBuilder: (widget) => SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(child: widget),
                ),
                children: [
                  _buildHeaderSection(),
                  SizedBox(height: 32),
                  _buildBiometricIcon(),
                  SizedBox(height: 32),
                  _buildFeaturesList(),
                  SizedBox(height: 40),
                  _buildActionButtons(),
                  if (widget.isInitialSetup) ...[
                    SizedBox(height: 24),
                    _buildSkipButton(),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotAvailableView() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.security,
              size: 80,
              color: Colors.grey[400],
            ),
            SizedBox(height: 24),
            Text(
              'Biometric Authentication Not Available',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              'Your device doesn\'t support biometric authentication or no biometrics are enrolled.',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Column(
      children: [
        Text(
          _isBiometricEnabled ? 'Biometric Security Enabled' : 'Secure Your Account',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12),
        Text(
          _isBiometricEnabled
              ? 'Your account is protected with $_biometricType authentication'
              : 'Use $_biometricType to quickly and securely access your account',
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildBiometricIcon() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: _isBiometricEnabled
              ? [Colors.green.shade400, Colors.green.shade600]
              : [Colors.orange.shade400, Colors.orange.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: (_isBiometricEnabled ? Colors.green : Colors.orange)
                .withOpacity(0.3),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Icon(
        _getBiometricIcon(),
        size: 60,
        color: Colors.white,
      ),
    );
  }

  Widget _buildFeaturesList() {
    final features = [
      {
        'icon': Icons.speed,
        'title': 'Quick Access',
        'description': 'Instantly access your account without typing passwords',
      },
      {
        'icon': Icons.security,
        'title': 'Enhanced Security',
        'description': 'Your biometric data is stored securely on your device',
      },
      {
        'icon': Icons.payment,
        'title': 'Secure Payments',
        'description': 'Authorize payments with just a touch or glance',
      },
      {
        'icon': Icons.privacy_tip,
        'title': 'Privacy Protection',
        'description': 'Your biometric data never leaves your device',
      },
    ];

    return Column(
      children: features.map((feature) {
        return Container(
          margin: EdgeInsets.only(bottom: 16),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  feature['icon'] as IconData,
                  color: Colors.orange,
                  size: 24,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      feature['title'] as String,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      feature['description'] as String,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildActionButtons() {
    if (_isBiometricEnabled) {
      return Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: _isAuthenticating ? null : _testBiometric,
              icon: _isAuthenticating
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Icon(Icons.fingerprint),
              label: Text(_isAuthenticating ? 'Authenticating...' : 'Test $_biometricType'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: OutlinedButton.icon(
              onPressed: _disableBiometric,
              icon: Icon(Icons.security_outlined),
              label: Text('Disable $_biometricType'),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton.icon(
          onPressed: _isAuthenticating ? null : _enableBiometric,
          icon: _isAuthenticating
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Icon(_getBiometricIcon()),
          label: Text(_isAuthenticating ? 'Setting up...' : 'Enable $_biometricType'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      );
    }
  }

  Widget _buildSkipButton() {
    return TextButton(
      onPressed: () => Navigator.pop(context),
      child: Text(
        'Skip for now',
        style: TextStyle(
          color: Colors.grey[600],
          fontSize: 16,
        ),
      ),
    );
  }

  IconData _getBiometricIcon() {
    if (_availableBiometrics.contains(BiometricType.face)) {
      return Icons.face;
    } else if (_availableBiometrics.contains(BiometricType.fingerprint)) {
      return Icons.fingerprint;
    } else {
      return Icons.security;
    }
  }

  Future<void> _enableBiometric() async {
    setState(() {
      _isAuthenticating = true;
    });

    try {
      final result = await _biometricService.authenticateWithBiometrics(
        reason: 'Authenticate to enable $_biometricType for your account',
      );

      if (result == AuthenticationStatus.authenticated) {
        await _biometricService.setBiometricEnabled(true);
        
        setState(() {
          _isBiometricEnabled = true;
          _isAuthenticating = false;
        });

        HapticFeedback.lightImpact();
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$_biometricType authentication enabled successfully!'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        setState(() {
          _isAuthenticating = false;
        });
        
        _showErrorDialog('Failed to enable $_biometricType authentication');
      }
    } catch (e) {
      setState(() {
        _isAuthenticating = false;
      });
      
      _showErrorDialog('An error occurred while setting up biometric authentication');
    }
  }

  Future<void> _disableBiometric() async {
    final confirmed = await _showConfirmationDialog(
      'Disable $_biometricType',
      'Are you sure you want to disable $_biometricType authentication? You\'ll need to use your password to access your account.',
    );

    if (confirmed) {
      await _biometricService.setBiometricEnabled(false);
      
      setState(() {
        _isBiometricEnabled = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$_biometricType authentication disabled'),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  Future<void> _testBiometric() async {
    setState(() {
      _isAuthenticating = true;
    });

    try {
      final result = await _biometricService.authenticateWithBiometrics(
        reason: 'Test your $_biometricType authentication',
      );

      setState(() {
        _isAuthenticating = false;
      });

      if (result == AuthenticationStatus.authenticated) {
        HapticFeedback.lightImpact();
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$_biometricType authentication successful!'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
          ),
        );
      } else {
        _showErrorDialog('$_biometricType authentication failed');
      }
    } catch (e) {
      setState(() {
        _isAuthenticating = false;
      });
      
      _showErrorDialog('An error occurred during authentication');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Authentication Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<bool> _showConfirmationDialog(String title, String message) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text('Confirm'),
          ),
        ],
      ),
    );
    
    return result ?? false;
  }
}
