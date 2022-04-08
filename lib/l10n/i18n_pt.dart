


import 'i18n.dart';

/// The translations for Portuguese (`pt`).
class I18nPt extends I18n {
  I18nPt([String locale = 'pt']) : super(locale);

  @override
  String get alreadyHaveAccount => 'Já possui uma conta?';

  @override
  String get confirmPassword => 'Confirmar senha';

  @override
  String get createAccount => 'criar conta';

  @override
  String get createAccountAndStartTransferring => 'Crie uma conta e comece a transferir';

  @override
  String get createNewAccount => 'Criar nova conta';

  @override
  String get email => 'Email';

  @override
  String get forgotPassword => 'Esqueceu a senha?';

  @override
  String get helloWorld => 'Olá Mundo!';

  @override
  String get initializing => 'Inicializando...';

  @override
  String get login => 'entrar';

  @override
  String get loginAndStartTransferring => 'Faça login e comece a transferir';

  @override
  String get logout => 'Sair';

  @override
  String get name => 'Nome';

  @override
  String get password => 'Senha';
}
