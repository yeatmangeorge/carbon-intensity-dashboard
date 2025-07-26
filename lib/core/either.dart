/// Simple implementation of either. Useful to make sure errors are handled.
/// I believe that there is a pub library for this, but it was quick to implement for now
sealed class Either<L, R> {
  T fold<T>({
    required Function(L left) onLeft,
    required Function(R right) onRight,
  });

  factory Either.left(L value) {
    return Left(value);
  }

  factory Either.right(R value) {
    return Right(value);
  }
}

class Left<L, R> implements Either<L, R> {
  final L value;

  Left(this.value);

  @override
  T fold<T>({
    required Function(L left) onLeft,
    required Function(R right) onRight,
  }) {
    return onLeft(value);
  }
}

class Right<L, R> implements Either<L, R> {
  final R value;

  Right(this.value);

  @override
  T fold<T>({
    required Function(L left) onLeft,
    required Function(R right) onRight,
  }) {
    return onRight(value);
  }
}
