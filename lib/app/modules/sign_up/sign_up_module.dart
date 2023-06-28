import 'package:estacionamento_rotativo/app/modules/sign_up/domain/usecases/sing_up_usecase_sing_up/sing_up_usecase_sing_up_imp.dart';
import 'package:estacionamento_rotativo/app/modules/sign_up/external/datasources/sign_up_datasource_remote.dart';
import 'package:estacionamento_rotativo/app/modules/sign_up/infra/repositories/sing_up_repository/sing_up_repository_imp.dart';
import 'package:estacionamento_rotativo/app/modules/sign_up/presentation/add_vehicle/store/sign_up_add_vehicle_page_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../login/domain/entity/user_credential_entity.dart';
import 'domain/entities/vehicle_view_entity.dart';
import 'presentation/add_vehicle/page/sign_up_add_vehicle_page.dart';
import 'presentation/home/page/sign_up_page.dart';
import 'presentation/home/store/sign_up_page_store.dart';

class SignUpModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind((i) => SingUpPageStore(i())),
        Bind((i) => SingUpAddVehiclePageStore()),
        Bind((i) => SignUpRepositoryImp(i())),
        Bind((i) => SignUpDatasourceRemote(i())),
        Bind((i) => SingUpUsecaseSignUpImp(i()))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute("/",
            child: (context, args) => SignUpPage(
                  store: context.read(),
                  user: args.data as UserCredentialEntity?,
                )),
        ChildRoute("/add_vehicle",
            child: (context, args) =>
                SingUpAddVehiclePage(store: context.read(), vehicle: args.data as VehicleViewEntity?))
      ];
}
