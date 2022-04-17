import 'package:flutter_modular/flutter_modular.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:wallet/app_controller.dart';
import 'package:wallet/modules/authentication/repositories/authentication_repository.dart';

import '../../../../shared/models/models.dart';
import '../../../../shared/services/services.dart';
import '../../../../shared/utils/utils.dart';
import 'login_state.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  final AuthenticationRepository repository;
  _LoginStoreBase({
    required this.repository,
  });

  AuthData? authData;

  TokenData? tokenData;

  UserData? userData;

  @observable
  LoginState state = LoginStateEmpty();

  @action
  void update(LoginState newState) {
    state = newState;
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    update(LoginStateLoading());

    final localTokenId =
        await AuthDataStorageImpl().getTokenId(tokenIdKey: 'tokenIdKey');
    try {
      final result = await repository.login(
        email: email,
        password: password,
      );

      result.fold(
        (l) => throw l,
        (r) async {
          Modular.get<AppController>().authData = r.data;
          final tokenId = r.data.idToken;

          if (localTokenId != null && localTokenId == tokenId) {
            await getUserData();
            update(LoginStateSuccess());
          } else {
            BiometricStorageImpl().deleteBiometrics();
            AuthDataStorageImpl().deleteUserData();

            await AuthDataStorageImpl().setTokenId(
              tokenIdKey: 'tokenIdKey',
              tokenId: r.data.idToken!,
            );
            await AuthDataStorageImpl().setRefreshToken(
              refreshTokenKey: 'refreshTokenKey',
              refreshToken: r.data.refreshToken!,
            );
            await getUserData();
            update(LoginStateSuccess());
          }
        },
      );
    } on Failure catch (e) {
      update(LoginStateFailure(
          error: Failure(
        status: e.status,
        message: e.message,
        type: e.type,
        exception: e.exception,
      )));
    }
  }

  Future<void> checkBiometrics() async {
    final String? checkBiometrics = await BiometricStorageImpl().getBiometrics(
      biometricsKey: 'biometricsKey',
    );

    final String? checkTokenId =
        await AuthDataStorageImpl().getTokenId(tokenIdKey: 'tokenIdKey');

    final String? checkRefreshToken = await AuthDataStorageImpl()
        .getRefreshToken(refreshTokenKey: 'refreshTokenKey');

    if (checkBiometrics != null &&
        checkBiometrics.isNotEmpty &&
        checkTokenId != null &&
        checkTokenId.isNotEmpty &&
        checkRefreshToken != null &&
        checkRefreshToken.isNotEmpty) {
      update(LoginStateBiometrics());
    }
  }

  Future<void> loginWithBiometrics({
    required LocalAuthentication auth,
  }) async {
    final localRefreshToken = await AuthDataStorageImpl()
        .getRefreshToken(refreshTokenKey: 'refreshTokenKey');

    final checkBiometricPermission = await BiometricStorageImpl()
        .getBiometrics(biometricsKey: 'biometricsKey');

    if (checkBiometricPermission == 'true') {
      await updateToken();

      final newRefreshToken = tokenData!.refreshToken;

      if (newRefreshToken == localRefreshToken) {
        final result = await LocalAuthImpl().authenticate(auth: auth);

        result.fold(
          (l) => null,
          (r) async {
            update(LoginStateLoading());
            await getUserData();
            update(LoginStateSuccess());
          },
        );
      }
    }
  }

  Future<void> updateToken() async {
    update(LoginStateLoading());
    final localRefreshToken = await AuthDataStorageImpl()
        .getRefreshToken(refreshTokenKey: 'refreshTokenKey');

    final result = await repository.updateToken(
      refreshToken: localRefreshToken!,
    );

    result.fold(
      (l) {
        BiometricStorageImpl().deleteBiometrics();
        AuthDataStorageImpl().deleteUserData();
        update(LoginStateFailure(error: l));
      },
      (r) {
        tokenData = r.data;
        update(LoginStateEmpty());
      },
    );
  }

  Future<void> getUserData() async {
    final localTokenId =
        await AuthDataStorageImpl().getTokenId(tokenIdKey: 'tokenIdKey');

    final result = await repository.getUserData(
      idToken: localTokenId!,
    );

    result.fold(
      (l) {
        return Future.error(l);
      },
      (r) {
        userData = r.data;
      },
    );
  }
}
