/// Mixin to be added to Notifier subclasses
/// Use this mixin if you need to check if the Notifier is mounted before
/// setting the state (usually, following an asynchronous operation).
///
/// Example usage:
///
/// ```dart
/// @riverpod
/// class SomeNotifier extends _$SomeNotifier with NotifierMounted {
///   @override
///   FutureOr<void> build() {
///     ref.onDispose(setUnmounted);
///   }
///   Future<void> doAsyncWork() {
///     state = const AsyncLoading();
///     final newState = await AsyncValue.guard(someFuture);
///     if (mounted) {
///       state = newState;
///     }
///   }
/// }
///
mixin NotifierMounted {
  bool _mounted = true;

  // Set the notifier as unmounted
  void setUnmounted() => _mounted = false;

  // Whether the notifier is currently mounted
  bool get mounted => _mounted;
}
