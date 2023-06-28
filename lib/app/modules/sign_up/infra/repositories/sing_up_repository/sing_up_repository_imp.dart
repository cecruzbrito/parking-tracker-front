import 'package:dartz/dartz.dart';
import 'package:estacionamento_rotativo/app/modules/sign_up/domain/entities/user_request_create_entity.dart';
import 'package:estacionamento_rotativo/app/shared/domain/errors/erros.dart';

import '../../../domain/repositories/sing_up_repository/sing_up_repository.dart';
import '../../datasources/sing_up_datasource/sing_up_datasource.dart';

class SignUpRepositoryImp implements SignUpRepository {
  final SingUpDatasource _datasource;
  SignUpRepositoryImp(this._datasource);
  @override
  Future<Either<AppFailure, void>> singUp(UserRequestCreateEntity request) async {
    try {
      return Right(await _datasource.singUp(request));
    } on AppFailure catch (e) {
      return Left(e);
    }
  }
}
