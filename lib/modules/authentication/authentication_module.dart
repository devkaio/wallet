import 'package:flutter_modular/flutter_modular.dart';
import 'package:wallet/modules/authentication/features/create_account/create_account_page.dart';
import 'package:wallet/modules/authentication/features/create_account/create_account_store.dart';
import 'package:wallet/modules/authentication/features/initial/initial_page.dart';
import 'package:wallet/modules/authentication/features/initial/initial_store.dart';
import 'package:wallet/modules/authentication/features/login/login_page.dart';
import 'package:wallet/modules/authentication/features/login/login_store.dart';
import 'package:wallet/modules/authentication/features/splash/splash_store.dart';
import 'package:wallet/modules/authentication/repositories/authentication_repository_impl.dart';
import 'package:wallet/shared/services/local_secure_storage/auth_data_storage_impl.dart';

import 'features/splash/splash_page.dart';
import 'repositories/authentication_repository.dart';

class AuthenticationModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.lazySingleton(
          (i) => LoginStore(
            repository: i<AuthenticationRepository>(),
          ),
        ),
        Bind.lazySingleton(
          (i) => CreateAccountStore(
            repository: i<AuthenticationRepository>(),
          ),
        ),
        Bind.lazySingleton(
          (i) => SplashStore(
            repository: i<AuthenticationRepository>(),
          ),
        ),
        Bind.lazySingleton(
          (i) => InitialStore(
            repository: i<AuthenticationRepository>(),
          ),
        ),
        Bind.lazySingleton(
          (i) => AuthenticationRepositoryImpl(),
        ),
        Bind.lazySingleton((i) => AuthDataStorageImpl()),
      ];
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const SplashPage(),
        ),
        ChildRoute(
          '/initial',
          child: (context, args) => const InitialPage(),
        ),
        ChildRoute(
          '/create_account',
          child: (context, args) => const CreateAccountPage(),
        ),
        ChildRoute(
          '/login',
          child: (context, args) => const LoginPage(),
        )
      ];
}
