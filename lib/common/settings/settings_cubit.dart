import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  void toggleTheme() {
    emit(state.copyWith(
      themeMode: state.themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light,
    ));
  }

  void toggleLocale() {
    emit(state.copyWith(
      locale: state.locale == const Locale('ru') ? const Locale('en') : const Locale('ru'),
    ));
  }
}