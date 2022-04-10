import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:wallet/modules/authentication/features/splash/splash_state.dart';
import 'package:wallet/modules/authentication/features/splash/splash_store.dart';
import 'package:wallet/shared/constants/app_colors.dart';

import '../../../../shared/utils/utils.dart';
import '../../../../shared/widgets/widgets.dart';

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
          final Failure? error = (s as SplashStateFailure).error;

          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (context) => CustomDialog(
              title: 'Erro',
              content:
                  'Houve um problema ao iniciar a aplicação. Tente novamente mais tarde.',
              buttons: [
                PrimaryButton(
                  onPressed: () {
                    Navigator.pop(context);
                    store.authenticate();
                  },
                  text: 'tentar novamente',
                )
              ],
            ),
          );
        },
        success: () {
          Modular.to.pushReplacementNamed("/initial");
        },
        orElse: () {
          Navigator.pop(context);
        },
      );
    });
    Future.delayed(const Duration(seconds: 2), () => store.authenticate());
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
      backgroundColor: AppColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [AppLogo()],
        ),
      ),
    );
  }
}
