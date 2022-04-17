import 'package:local_auth/local_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:wallet/modules/home/repositories/home_repository.dart';
import 'package:wallet/shared/services/local_auth/local_auth_impl.dart';
import 'package:wallet/shared/services/local_secure_storage/auth_data_storage_impl.dart';
import 'package:wallet/shared/services/local_secure_storage/biometric_storage_impl.dart';

import 'start_state.dart';

part 'start_store.g.dart';

class StartStore = _StartStoreBase with _$StartStore;

abstract class _StartStoreBase with Store {
  final HomeRepository repository;
  final BiometricStorageImpl biometricStorage;
  final AuthDataStorageImpl authDataStorage;
  _StartStoreBase({
    required this.repository,
    required this.biometricStorage,
    required this.authDataStorage,
  });

  @observable
  StartState state = StartStateEmpty();

  @observable
  bool isBiometricsAvaliable = false;

  @action
  void update(StartState newState) {
    state = newState;
  }

  Future<void> getToken() async {
    update(StartStateLoading());
    final result = await repository.getToken();

    result.fold(
      (l) => update(StartStateFailure(error: l)),
      (r) => update(StartStateSuccess()),
    );
  }

  Future<void> checkBiometricSupport({
    required LocalAuthentication auth,
  }) async {
    final String? _checkLocalBiometric =
        await biometricStorage.getBiometrics(biometricsKey: 'biometricsKey');

    if (_checkLocalBiometric == 'false' || _checkLocalBiometric == null) {
      final _isDeviceSupported = await LocalAuthImpl().isDeviceSupported(
        auth: auth,
      );

      _isDeviceSupported.fold(
        (l) => throw l,
        (r) {
          if (r.data) {
            update(StartStateEmpty());
          }
        },
      );
    }
  }

  Future<void> authenticateBiometrics({
    required LocalAuthentication auth,
  }) async {
    final result = await LocalAuthImpl().authenticate(auth: auth);
    final tokenId =
        await AuthDataStorageImpl().getTokenId(tokenIdKey: 'tokenIdKey');
    final refreshToken = await AuthDataStorageImpl()
        .getRefreshToken(refreshTokenKey: 'refreshTokenKey');

    result.fold(
      (l) {
        update(StartStateFailure(error: l));
      },
      (r) async {
        await biometricStorage.setBiometrics(
          biometricsKey: 'biometricsKey',
          biometric: true,
        );
        await authDataStorage.setTokenId(
          tokenIdKey: 'tokenIdKey',
          tokenId: tokenId!,
        );
        await AuthDataStorageImpl().setRefreshToken(
          refreshTokenKey: 'refreshTokenKey',
          refreshToken: refreshToken!,
        );

        update(StartStateSuccess());
      },
    );
  }

  Future<void> signOut() async {
    final result = await repository.signOut();

    result.fold(
      (l) => null,
      (r) {
        BiometricStorageImpl().deleteBiometrics();
      },
    );
  }
}
