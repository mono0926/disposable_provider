/// An interface for objects that require resource cleanup when disposed.
abstract class Disposable() {
  /// Releases resources held by this object.
  void dispose();
}
