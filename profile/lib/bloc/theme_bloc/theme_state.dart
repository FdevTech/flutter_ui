part of 'theme_cubit.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();
}

class MyThemeState extends ThemeState {
  final bool dark;
  const MyThemeState({this.dark=false});
  @override
  List<Object> get props => [dark];
}
