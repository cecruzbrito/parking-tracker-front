import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/home/home_page/page/home_client_page.dart';
import 'presentation/home/home_page/store/home_client_page_store.dart';

class ClientModule extends Module {
  @override
  List<Bind<Object>> get binds => [Bind((i) => HomeClientPageStore(i(), i(), i(), i()))];

  @override
  List<ModularRoute> get routes => [ChildRoute("/", child: (context, __) => HomeClientPage(store: context.read()))];
}
