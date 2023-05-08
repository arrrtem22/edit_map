extension ListExtensions<E> on List<E> {
  E? elementAtOrNull(int index) => index < length ? elementAt(index) : null;

  E? firstWhereOrNull(bool Function(E element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }

  E? get firstOrNull => isEmpty ? null : first;

  E? get lastOrNull => isEmpty ? null : last;
}
