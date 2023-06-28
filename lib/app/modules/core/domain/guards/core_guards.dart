import 'dart:async';

import 'package:estacionamento_rotativo/app/modules/core/domain/repositories/core_repository/core_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

class UserAuthGuard extends RouteGuard {
  @override
  FutureOr<bool> canActivate(String path, ParallelRoute route) async {
    final repository = Modular.get<CoreRepository>();

    if (repository.getUserAuth() == null) return false;

    if (repository.getUserEntity() == null) return false;
    return true;
  }
}
