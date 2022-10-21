import 'i18n.dart';

/// The translations for English (`en`).
class I18nEn extends I18n {
  I18nEn([String locale = 'en']) : super(locale);

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get createAccount => 'create account';

  @override
  String get createAccountAndStartTransferring => 'Create account and start transferring';

  @override
  String get createNewAccount => 'Create new account';

  @override
  String get email => 'Email';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get initializing => 'Initializing...';

  @override
  String get login => 'login';

  @override
  String get loginAndStartTransferring => 'Login and start transferring';

  @override
  String get logout => 'Logout';

  @override
  String get name => 'Name';

  @override
  String get password => 'Password';
}
