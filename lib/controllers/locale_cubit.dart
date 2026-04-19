import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce/hive.dart';
import 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(const LocaleInitial(Locale('en'))) {
    _loadLocale();
  }

  void _loadLocale() {
    final box = Hive.box('settingsBox');
    final String? languageCode = box.get('languageCode');
    if (languageCode != null) {
      emit(LocaleInitial(Locale(languageCode)));
    }
  }

  Future<void> changeLanguage(String languageCode) async {
    final box = Hive.box('settingsBox');
    await box.put('languageCode', languageCode);
    emit(LocaleChanged(Locale(languageCode)));
  }
}
