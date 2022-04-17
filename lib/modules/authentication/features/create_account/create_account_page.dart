import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:wallet/l10n/i18n.dart';
import 'package:wallet/modules/authentication/features/create_account/create_account_state.dart';
import 'package:wallet/modules/authentication/features/create_account/create_account_store.dart';
import 'package:wallet/shared/widgets/custom_text_field.dart';
import 'package:wallet/shared/widgets/primary_button.dart';

import '../../../../shared/constants/app_colors.dart';
import '../../../../shared/constants/app_text_style.dart';
import '../../../../shared/utils/failure.dart';
import '../../../../shared/widgets/custom_text_button.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState
    extends ModularState<CreateAccountPage, CreateAccountStore> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  ReactionDisposer? _disposer;
  @override
  void initState() {
    _disposer = reaction((_) => store.state, (CreateAccountState s) {
      s.when(
        loading: () => showDialog(
          context: context,
          barrierDismissible: false,
          builder: (_) => const Center(child: CircularProgressIndicator()),
        ),
        failure: () {
          Navigator.pop(context);
          final Failure? error = (s as CreateAccountStateFailure).error;
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
          Modular.to.pushReplacementNamed('/home/', arguments: {
            'userData': store.userData,
          });
        },
        orElse: () {},
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
                                I18n.of(context)
                                        ?.createAccountAndStartTransferring ??
                                    'Crie uma conta e comece a transferir',
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _emailController,
                          labelText: I18n.of(context)?.email ?? 'Email',
                        ),
                        const SizedBox(height: 8.0),
                        CustomTextField(
                          controller: _passwordController,
                          labelText: I18n.of(context)?.password ?? 'Senha',
                          obscureText: true,
                        ),
                        const SizedBox(height: 8.0),
                        CustomTextField(
                          controller: _confirmPasswordController,
                          labelText: I18n.of(context)?.confirmPassword ??
                              'Confirme a senha',
                          obscureText: true,
                        ),
                        const SizedBox(height: 16.0),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      children: [
                        PrimaryButton(
                          onPressed: () {
                            store.createAccount(
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                          },
                          text:
                              I18n.of(context)?.createAccount ?? 'criar conta',
                        ),
                        CustomTextButton(
                          onPressed: () {
                            Modular.to.popAndPushNamed('/login');
                          },
                          text: I18n.of(context)?.alreadyHaveAccount ??
                              'Already have account?',
                        ),
                        const SizedBox(height: 32.0),
                      ],
                    ),
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
