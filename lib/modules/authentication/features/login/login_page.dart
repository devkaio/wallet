import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:local_auth/local_auth.dart';
import 'package:mobx/mobx.dart';
import 'package:wallet/l10n/i18n.dart';
import 'package:wallet/modules/authentication/features/login/login_store.dart';
import 'package:wallet/shared/constants/app_colors.dart';
import 'package:wallet/shared/constants/app_text_style.dart';
import 'package:wallet/shared/widgets/custom_text_field.dart';
import 'package:wallet/shared/widgets/primary_button.dart';

import '../../../../shared/utils/failure.dart';
import '../../../../shared/widgets/custom_text_button.dart';
import 'login_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ModularState<LoginPage, LoginStore> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LocalAuthentication _auth = LocalAuthentication();

  ReactionDisposer? _disposer;
  @override
  void initState() {
    _disposer = reaction((_) => store.state, (LoginState s) {
      s.when(
        loading: () => showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const Center(child: CircularProgressIndicator()),
        ),
        failure: () {
          Navigator.pop(context);

          final Failure? error = (s as LoginStateFailure).error;
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(error?.type ?? 'erro'),
              content: Text(error?.message ?? 'erro'),
              actions: [
                TextButton(
                  onPressed: () => Modular.to.pop(),
                  child: const Text('ok'),
                ),
              ],
            ),
          );
        },
        success: () {
          Modular.to.pushReplacementNamed(
            '/home/',
            arguments: {
              'userData': store.userData,
            },
          );
        },
        biometrics: () {
          store.loginWithBiometrics(auth: _auth);
        },
        empty: () {
          Navigator.pop(context);
        },
        orElse: () {},
      );
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      store.checkBiometrics();
    });
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    if (_disposer != null) _disposer!();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
                minWidth: constraints.maxWidth,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 40.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                I18n.of(context)?.loginAndStartTransferring ??
                                    'Login and Start transfering',
                                style: AppTextStyle.h1,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Transform.rotate(
                                angle: -math.pi / 4,
                                child: const Icon(
                                  Icons.send_rounded,
                                  size: 48.0,
                                  color: AppColors.secondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32.0),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: CustomTextField(
                          controller: _emailController,
                          labelText: I18n.of(context)?.email ?? 'Email',
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: CustomTextField(
                          controller: _passwordController,
                          labelText: I18n.of(context)?.password ?? 'Password',
                          obscureText: true,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Align(
                          heightFactor: 0.5,
                          alignment: Alignment.centerRight,
                          child: CustomTextButton(
                            text: I18n.of(context)?.forgotPassword ??
                                'Forget password?',
                            onPressed: () {},
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: PrimaryButton(
                            onPressed: () {
                              store.login(
                                email: _emailController.text,
                                password: _passwordController.text,
                              );
                            },
                            text: I18n.of(context)?.login ?? 'Login'),
                      ),
                      CustomTextButton(
                        onPressed: () {
                          Modular.to.popAndPushNamed('/create_account');
                        },
                        text: I18n.of(context)?.createNewAccount ??
                            'create new account?',
                      ),
                      const SizedBox(height: 32.0),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
