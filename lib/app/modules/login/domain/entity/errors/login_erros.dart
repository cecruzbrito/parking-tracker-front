import '../../../../../shared/domain/errors/erros.dart';

class UserNotFound implements AppFailure {
  final String _message;
  UserNotFound(this._message);
  @override
  String get message => _message;
}
