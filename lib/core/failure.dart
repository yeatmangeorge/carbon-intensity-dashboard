/// Classes to handle errors. By handling exceptions close to their source and
/// converting into [Failure], we can ensure that we remember to deal with these
/// correctly
sealed class Failure {
  factory Failure.networkConnection() => NetworkConnectionFailure();

  factory Failure.http(int restCode) => HttpFailure(restCode);
}

class NetworkConnectionFailure implements Failure {}

class HttpFailure implements Failure {
  final int restCode;

  HttpFailure(this.restCode);
}
