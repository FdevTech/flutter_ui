import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(MyLocalState(currentLocal: MySupportedLanguage.english));


  changeTheLanguage(Locale locale)
  {
    emit(MyLocalState(currentLocal: locale));
  }
}
