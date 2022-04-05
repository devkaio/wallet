import 'package:flutter_modular/flutter_modular.dart';
import 'package:wallet/modules/home/features/start/start_page.dart';
import 'package:wallet/modules/home/features/start/start_store.dart';
import 'package:wallet/modules/home/repositories/home_repository_impl.dart';

import 'repositories/home_repository.dart';

class HomeModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.lazySingleton(
          (i) => StartStore(
            repository: i<HomeRepository>(),
          ),
        ),
        Bind.lazySingleton(
          (i) => HomeRepositoryImpl(),
        ),
      ];
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const StartPage(),
        ),
      ];
}
