import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class LoadTheme extends ThemeEvent {}

class ToggleTheme extends ThemeEvent {}

class SetTheme extends ThemeEvent {
  final bool isDarkMode;

  const SetTheme(this.isDarkMode);

  @override
  List<Object> get props => [isDarkMode];
}

// States
class ThemeState extends Equatable {
  final bool isDarkMode;
  final bool isLoading;

  const ThemeState({
    this.isDarkMode = false,
    this.isLoading = false,
  });

  ThemeState copyWith({
    bool? isDarkMode,
    bool? isLoading,
  }) {
    return ThemeState(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [isDarkMode, isLoading];
}

// Bloc
class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  static const String _themeKey = 'theme_mode';

  ThemeBloc() : super(const ThemeState()) {
    on<LoadTheme>(_onLoadTheme);
    on<ToggleTheme>(_onToggleTheme);
    on<SetTheme>(_onSetTheme);
  }

  Future<void> _onLoadTheme(LoadTheme event, Emitter<ThemeState> emit) async {
    emit(state.copyWith(isLoading: true));
    
    try {
      final prefs = await SharedPreferences.getInstance();
      final isDarkMode = prefs.getBool(_themeKey) ?? false;
      
      emit(state.copyWith(
        isDarkMode: isDarkMode,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<void> _onToggleTheme(ToggleTheme event, Emitter<ThemeState> emit) async {
    final newThemeMode = !state.isDarkMode;
    
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_themeKey, newThemeMode);
      
      emit(state.copyWith(isDarkMode: newThemeMode));
    } catch (e) {
      // Handle error silently or emit error state if needed
    }
  }

  Future<void> _onSetTheme(SetTheme event, Emitter<ThemeState> emit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_themeKey, event.isDarkMode);
      
      emit(state.copyWith(isDarkMode: event.isDarkMode));
    } catch (e) {
      // Handle error silently or emit error state if needed
    }
  }
}
