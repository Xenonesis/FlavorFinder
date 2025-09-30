import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Events
abstract class ThemeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadTheme extends ThemeEvent {}

class ToggleTheme extends ThemeEvent {}

class SetThemeMode extends ThemeEvent {
  final ThemeMode themeMode;
  
  SetThemeMode(this.themeMode);
  
  @override
  List<Object?> get props => [themeMode];
}

// States
class ThemeState extends Equatable {
  final ThemeMode themeMode;
  final bool isDarkMode;
  
  const ThemeState({
    required this.themeMode,
    required this.isDarkMode,
  });
  
  @override
  List<Object?> get props => [themeMode, isDarkMode];
  
  ThemeState copyWith({
    ThemeMode? themeMode,
    bool? isDarkMode,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }
}

// BLoC
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  static const String _themeKey = 'theme_mode';
  
  ThemeBloc() : super(const ThemeState(
    themeMode: ThemeMode.system,
    isDarkMode: false,
  )) {
    on<LoadTheme>(_onLoadTheme);
    on<ToggleTheme>(_onToggleTheme);
    on<SetThemeMode>(_onSetThemeMode);
  }
  
  Future<void> _onLoadTheme(LoadTheme event, Emitter<ThemeState> emit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeModeIndex = prefs.getInt(_themeKey) ?? 0;
      final themeMode = ThemeMode.values[themeModeIndex];
      
      final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
      final isDarkMode = themeMode == ThemeMode.dark || 
          (themeMode == ThemeMode.system && brightness == Brightness.dark);
      
      emit(ThemeState(
        themeMode: themeMode,
        isDarkMode: isDarkMode,
      ));
    } catch (e) {
      emit(const ThemeState(
        themeMode: ThemeMode.system,
        isDarkMode: false,
      ));
    }
  }
  
  Future<void> _onToggleTheme(ToggleTheme event, Emitter<ThemeState> emit) async {
    try {
      final newThemeMode = state.isDarkMode ? ThemeMode.light : ThemeMode.dark;
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_themeKey, newThemeMode.index);
      
      emit(ThemeState(
        themeMode: newThemeMode,
        isDarkMode: newThemeMode == ThemeMode.dark,
      ));
    } catch (e) {
      // Handle error silently
    }
  }
  
  Future<void> _onSetThemeMode(SetThemeMode event, Emitter<ThemeState> emit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_themeKey, event.themeMode.index);
      
      final brightness = WidgetsBinding.instance.platformDispatcher.platformBrightness;
      final isDarkMode = event.themeMode == ThemeMode.dark || 
          (event.themeMode == ThemeMode.system && brightness == Brightness.dark);
      
      emit(ThemeState(
        themeMode: event.themeMode,
        isDarkMode: isDarkMode,
      ));
    } catch (e) {
      // Handle error silently
    }
  }
}
