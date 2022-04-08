


import 'i18n.dart';

/// The translations for Spanish Castilian (`es`).
class I18nEs extends I18n {
  I18nEs([String locale = 'es']) : super(locale);

  @override
  String get alreadyHaveAccount => 'Ja possui una cuenta?';

  @override
  String get confirmPassword => 'Confirmar contraseña';

  @override
  String get createAccount => 'crar cuenta';

  @override
  String get createAccountAndStartTransferring => 'Crea una cuenta y comece a transferir';

  @override
  String get createNewAccount => 'Crea nueva cuenta';

  @override
  String get email => 'Email';

  @override
  String get forgotPassword => 'Esqueceu la contraseña';

  @override
  String get helloWorld => '!Ola Mondo!';

  @override
  String get initializing => 'Iniciando...';

  @override
  String get login => 'entra';

  @override
  String get loginAndStartTransferring => 'Inicia sesión y comienza a transferir';

  @override
  String get logout => 'Salir';

  @override
  String get name => 'Nombre';

  @override
  String get password => 'Contraseña';
}
