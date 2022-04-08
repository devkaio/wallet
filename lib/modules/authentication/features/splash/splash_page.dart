import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:wallet/l10n/i18n.dart';
import 'package:wallet/modules/authentication/features/splash/splash_state.dart';
import 'package:wallet/modules/authentication/features/splash/splash_store.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ModularState<SplashPage, SplashStore> {
  ReactionDisposer? _disposer;
  @override
  void initState() {
    _disposer = reaction((_) => store.state, (SplashState s) {
      s.when(
        loading: () => showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) =>
              const Center(child: CircularProgressIndicator()),
        ),
        failure: () {
          Modular.to.pushReplacementNamed("/initial");
        },
        success: () {
          Modular.to.pushReplacementNamed(
            '/home/',
          );
        },
        orElse: () {
          Navigator.pop(context);
        },
      );
    });
    store.authenticate();
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(I18n.of(context)?.initializing ?? 'Initializing'),
            const SizedBox(height: 16.0),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
