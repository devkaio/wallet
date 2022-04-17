import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:wallet/l10n/i18n.dart';
import 'package:wallet/modules/home/features/start/start_store.dart';

import '../../../../shared/models/models.dart';
import '../../../../shared/services/services.dart';
import '../../../../shared/utils/failure.dart';
import '../../../../shared/widgets/widgets.dart';
import 'start_state.dart';

class StartPage extends StatefulWidget {
  final UserData userData;
  const StartPage({
    Key? key,
    required this.userData,
  }) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends ModularState<StartPage, StartStore> {
  final LocalAuthentication _localAuth = LocalAuthentication();

  ReactionDisposer? _disposer;
  @override
  void initState() {
    _disposer = reaction((_) => store.state, (StartState s) {
      s.when(
        loading: () => showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const Center(child: CircularProgressIndicator()),
        ),
        failure: () {
          Navigator.pop(context);
          final Failure? error = (s as StartStateFailure).error;
          //TODO: implements StartStateFailure
        },
        success: () {
          //TODO: implements StartStateSuccess
        },
        empty: () {
          showDialog(
            context: context,
            builder: (context) {
              return CustomDialog(
                title: 'Biometria',
                content:
                    'Deseja acessar o app através da biometria no próximo login?',
                buttons: [
                  PrimaryButton(
                    onPressed: () async {
                      await BiometricStorageImpl().setBiometrics(
                        biometricsKey: 'biometricsKey',
                        biometric: false,
                      );
                      Navigator.pop(context);
                    },
                    text: 'nao',
                  ),
                  const SizedBox(height: 8.0),
                  PrimaryButton(
                    onPressed: () async {
                      store.authenticateBiometrics(auth: _localAuth);
                      Navigator.pop(context);
                    },
                    text: 'sim',
                  )
                ],
              );
            },
          );
        },
        orElse: () {},
      );
    });

    Future.delayed(
        Duration.zero, () => store.checkBiometricSupport(auth: _localAuth));
    super.initState();
  }

  @override
  void dispose() {
    if (_disposer != null) _disposer!();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(widget.userData.users[0].email as String),
            ElevatedButton(
                onPressed: () async {
                  AuthDataStorageImpl().deleteUserData();
                  await BiometricStorageImpl().setBiometrics(
                    biometricsKey: 'biometricsKey',
                    biometric: false,
                  );
                  store.signOut();
                  Modular.to.popUntil(ModalRoute.withName('/initial/'));
                },
                child: Text(I18n.of(context)?.logout ?? 'Logout')),
          ],
        ),
      ),
    );
  }
}
