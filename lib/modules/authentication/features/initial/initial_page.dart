import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:wallet/l10n/i18n.dart';
import 'package:wallet/modules/authentication/features/initial/initial_store.dart';
import 'package:wallet/shared/constants/constants.dart';
import 'package:wallet/shared/widgets/widgets.dart';

import 'initial_state.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({Key? key}) : super(key: key);

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends ModularState<InitialPage, InitialStore> {
  ReactionDisposer? _disposer;
  @override
  void initState() {
    _disposer = reaction((_) => store.state, (InitialState s) {
      s.when(
        loading: () => showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const Center(child: CircularProgressIndicator()),
        ),
        failure: () {},
        success: () {},
        orElse: () {},
      );
    });

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
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
              minWidth: constraints.maxWidth,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const AppLogo(),
                    const SizedBox(height: 8.0),
                    Text(
                      'WALLET',
                      style: AppTextStyle.h1.apply(color: AppColors.primary),
                    ),
                  ],
                ),
                const SizedBox(height: 32.0),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32.0),
                      child: PrimaryButton(
                        onPressed: () {
                          Modular.to.pushNamed('/create_account');
                        },
                        text:
                            I18n.of(context)?.createAccount ?? 'Create Account',
                      ),
                    ),
                    CustomTextButton(
                      onPressed: () {
                        Modular.to.pushNamed('/login');
                      },
                      text: I18n.of(context)?.alreadyHaveAccount ??
                          'already have an account?',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
