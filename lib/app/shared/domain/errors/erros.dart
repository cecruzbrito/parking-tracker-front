abstract class AppFailure implements Exception {
  String get message;
}

class GenericFailure implements AppFailure {
  final String _message;
  const GenericFailure(this._message);

  @override
  String get message => _message;
}

class DomainFailure implements AppFailure {
  final String _message;
  const DomainFailure(this._message);

  @override
  String get message => _message;
}

class TimeOutFailure implements AppFailure {
  final String _message;
  const TimeOutFailure(this._message);

  @override
  String get message => _message;
}
