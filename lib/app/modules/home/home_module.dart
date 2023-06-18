import 'package:estacionamento_rotativo/app/modules/home/presentation/home/page/home_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'presentation/home/store/home_page_store.dart';

class HomeModule extends Module {
  @override
  List<Bind<Object>> get binds => [Bind((i) => HomePageStore())];

  @override
  List<ModularRoute> get routes => [ChildRoute("/", child: (context, args) => HomePage(store: context.read()))];
}
