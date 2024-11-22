class Failure {
  final String message;
  final int statusCode;

  const Failure({required this.message, required this. statusCode});

}

class APIFailure extends Failure {
  const APIFailure({required super.message, required super.statusCode});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message, required super.statusCode});
}

class GeneralFailure extends Failure {
  const GeneralFailure({required super.message, required super.statusCode});
}