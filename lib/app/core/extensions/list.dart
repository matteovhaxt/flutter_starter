extension SeparatedList<T> on List {
  List<T> separated<T>(T separator) => List<T>.generate(
        length * 2 - 1,
        (index) => index % 2 == 0 ? this[index ~/ 2] : separator,
      );
}
