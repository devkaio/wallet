import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:system_settings/system_settings.dart';
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

class _StartPageState extends ModularState<StartPage, StartStore>
    with WidgetsBindingObserver {
  final LocalAuthentication _localAuth = LocalAuthentication();

  ReactionDisposer? _disposer;
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    _disposer = reaction((_) => store.state, (StartState s) {
      s.when(
        loading: () => showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const Center(child: CircularProgressIndicator()),
        ),
        failure: () {
          final Failure? error = (s as StartStateFailure).error;
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(error?.type ?? 'erro'),
              content: Text(error?.message ?? 'erro'),
              actions: [
                TextButton(
                  onPressed: () {
                    if (error?.exception == 'biometrics_error') {
                      Navigator.pop(context);
                      SystemSettings.security();
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('ok'),
                ),
              ],
            ),
          );
        },
        success: () {
          //TODO: implements StartStateSuccess
        },
        sessionExpired: () {
          showDialog(
            context: context,
            builder: (context) {
              return CustomDialog(
                title: 'Sessão Expirada',
                content:
                    'O tempo da sessão acabou. Por favor, realize o login novamente?',
                buttons: [
                  PrimaryButton(
                    onPressed: () {
                      Modular.to.popUntil(ModalRoute.withName('/initial'));
                    },
                    text: 'ok',
                  )
                ],
              );
            },
          );
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
    WidgetsBinding.instance.removeObserver(this);

    if (_disposer != null) _disposer!();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    store.checkAppState(
      state.name,
      auth: _localAuth,
    );
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
