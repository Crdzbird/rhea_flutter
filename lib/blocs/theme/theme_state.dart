part of 'theme_cubit.dart';

class ThemeState extends Equatable {
  const ThemeState({required this.theme});

  factory ThemeState.fromMap(Map<String, dynamic> map) {
    return ThemeState(
      theme: map['theme'] == 'system'
          ? ThemeMode.system
          : ThemeMode.values.firstWhere(
              (element) => element.toString() == 'ThemeMode.${map['theme']}',
            ),
    );
  }

  factory ThemeState.initial() => const ThemeState(theme: ThemeMode.system);
  final ThemeMode theme;

  @override
  List<Object?> get props => [theme];

  ThemeState copyWith() => ThemeState(theme: theme);

  @override
  String toString() => 'ThemeState(theme: $theme)';

  String enumToString() =>
      theme.toString().split('.').last.split(')').first.toUpperCase();

  Map<String, String> get toMap => {'theme': theme.name};
}
