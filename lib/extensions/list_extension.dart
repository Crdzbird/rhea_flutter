extension ListExtension on List<String> {
  List<String> get removeLast {
    if (isEmpty) return this;
    return sublist(0, length - 1);
  }
}
