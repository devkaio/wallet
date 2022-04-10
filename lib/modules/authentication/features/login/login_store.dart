import 'package:firebase_auth/firebase_auth.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:wallet/modules/authentication/repositories/authentication_repository.dart';
import 'package:wallet/shared/services/local_auth/local_auth_impl.dart';
import 'package:wallet/shared/services/local_secure_storage/auth_data_storage_impl.dart';
import 'package:wallet/shared/services/local_secure_storage/biometric_storage_impl.dart';
import 'package:wallet/shared/utils/failure.dart';

import 'login_state.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {
  final AuthenticationRepository repository;
  _LoginStoreBase({
    required this.repository,
  });

  UserCredential? userCredential;

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
    final result = await repository.login(
      email: email,
      password: password,
    );

    result.fold(
      (l) => update(LoginStateFailure(error: l)),
      (r) async {
        userCredential = r.data;

        final String? idToken = await r.data.user?.getIdToken();

        await BiometricStorageImpl().setBiometrics(
          biometricsKey: 'biometricsKey',
          biometric: true,
        );

        await AuthDataStorageImpl().setTokenId(
          tokenIdKey: 'tokenIdKey',
          tokenId: idToken!,
        );
        update(LoginStateSuccess());
      },
    );
  }

  Future<void> checkBiometrics() async {
    final String? checkBiometrics = await BiometricStorageImpl().getBiometrics(
      biometricsKey: 'biometricsKey',
    );

    final String? checkTokenId =
        await AuthDataStorageImpl().getTokenId(tokenIdKey: 'tokenIdKey');

    try {
      if (checkBiometrics != null &&
          checkBiometrics.isNotEmpty &&
          checkTokenId != null &&
          checkTokenId.isNotEmpty) {
        update(LoginStateEmpty());
      } else {
        throw Exception();
      }
    } on Exception {
      update(LoginStateFailure(
          error: Failure(
        status: 0,
        message: 'sessao expirada',
        type: 'session',
        exception: 'exception',
      )));
    }
  }

  Future<void> authenticateWithBiometrics({
    required LocalAuthentication auth,
  }) async {
    final tokenId = await FirebaseAuth.instance.currentUser?.getIdToken();
    final localTokenId =
        await AuthDataStorageImpl().getTokenId(tokenIdKey: 'tokenIdKey');

    if (tokenId == localTokenId) {
      final result = await LocalAuthImpl().authenticate(auth: auth);

      result.fold(
        (l) => null,
        (r) => update(LoginStateSuccess()),
      );
    } else {
      update(LoginStateFailure(
          error: Failure(
        status: 0,
        message: 'sessão expirad',
        type: 'expired',
        exception: 'exception',
      )));
    }
  }
}
