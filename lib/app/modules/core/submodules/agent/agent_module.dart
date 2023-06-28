import 'package:estacionamento_rotativo/app/modules/core/submodules/agent/presentation/home/home_page/page/agent_home_page.dart';
import 'package:estacionamento_rotativo/app/modules/core/submodules/agent/presentation/home/home_page/store/agente_home_page_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AgentModule extends Module {
  @override
  List<Bind<Object>> get binds => [Bind((i) => AgentHomePageStore(i(), i(), i(), i(), i(), i()))];

  @override
  List<ModularRoute> get routes => [ChildRoute("/", child: (context, __) => AgentHomePage(store: context.read()))];
}
