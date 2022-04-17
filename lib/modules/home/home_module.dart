import 'package:flutter_modular/flutter_modular.dart';
import 'package:wallet/modules/home/features/start/start_page.dart';
import 'package:wallet/modules/home/features/start/start_store.dart';
import 'package:wallet/modules/home/repositories/home_repository_impl.dart';
import 'package:wallet/shared/services/local_secure_storage/auth_data_storage_impl.dart';

import '../../shared/services/local_secure_storage/biometric_storage_impl.dart';
import 'repositories/home_repository.dart';

class HomeModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.lazySingleton((i) => BiometricStorageImpl()),
        Bind.lazySingleton(
          (i) => StartStore(
            repository: i<HomeRepository>(),
            biometricStorage: i<BiometricStorageImpl>(),
            authDataStorage: i<AuthDataStorageImpl>(),
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
          child: (context, args) => StartPage(
            userData: args.data['userData'],
          ),
        ),
      ];
}
