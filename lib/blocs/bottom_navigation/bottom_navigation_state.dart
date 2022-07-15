part of 'bottom_navigation_cubit.dart';

class BottomNavigationState extends Equatable {
  const BottomNavigationState({required this.index});
  factory BottomNavigationState.initial() =>
      const BottomNavigationState(index: 0);
  final int index;

  @override
  List<Object?> get props => [index];

  BottomNavigationState copyWith({
    int? index,
  }) {
    return BottomNavigationState(
      index: index ?? this.index,
    );
  }

  @override
  String toString() => 'BottomnavigationState(index: $index)';
}
