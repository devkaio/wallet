import 'package:flutter_modular/flutter_modular.dart';
import 'package:wallet/app_controller.dart';
import 'package:wallet/modules/home/home_module.dart';

import 'modules/authentication/authentication_module.dart';

class AppModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.lazySingleton((i) => AppController()),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute(
          '/',
          module: AuthenticationModule(),
        ),
        ModuleRoute(
          '/home/',
          module: HomeModule(),
        ),
      ];
}
