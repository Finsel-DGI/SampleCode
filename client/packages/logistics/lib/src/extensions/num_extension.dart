extension Nim on int {
    DateTime get convertUnixNumberToDateTime =>
      DateTime.fromMillisecondsSinceEpoch(this * 1000);
}