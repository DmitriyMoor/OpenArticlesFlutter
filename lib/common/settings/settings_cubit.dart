import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_articles_flutter/common/settings/settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  void toggleTheme() {
    emit(
      state.copyWith(
        themeMode: state.isDark ? ThemeMode.light : ThemeMode.dark,
      ),
    );
  }

  void toggleLocale() {
    final next = state.locale.languageCode == 'ru' ? 'en' : 'ru';
    emit(state.copyWith(locale: Locale(next)));
  }
}
