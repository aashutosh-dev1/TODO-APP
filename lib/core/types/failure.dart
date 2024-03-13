///
abstract class Failure {
  ///
  const Failure({
    required this.message,
  });

  ///
  final String message;
}

///
class Failed extends Failure {
  ///
  Failed({required super.message});
}
