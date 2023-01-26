part of 'language_cubit.dart';

abstract class LanguageState extends Equatable {
  const LanguageState();
}

class MyLocalState extends LanguageState {
  final Locale currentLocal;

  const MyLocalState({required this.currentLocal});
  @override
  List<Object> get props => [currentLocal];
}

class MySupportedLanguage{
  MySupportedLanguage._();
  static Locale french =const Locale("fr");
  static Locale english =const Locale("en");
  static final languages =[french,english];
}