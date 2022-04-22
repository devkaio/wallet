import 'dart:io';

class CreateAccountError {
  final String _locale = Platform.localeName.split('_')[0];

  String errorMessage({
    required String code,
  }) {
    if (_locale == 'en') {
      switch (code) {
        case 'MISSING_PASSWORD':
          return 'Empty password. Please provide valid password and try again.';
        case 'INVALID_EMAIL':
          return 'Invalid email address. Please provide valid email and try again.';
        case 'WEAK_PASSWORD : Password should be at least 6 characters':
          return 'Password should be at least 6 characters.';
        default:
          return 'internal error';
      }
    } else if (_locale == 'es') {
      switch (code) {
        case 'MISSING_PASSWORD':
          return 'Empty password. Please provide valid password and try again.';
        case 'INVALID_EMAIL':
          return 'Email inválido. Revise os dados e tente novamente.';
        case 'WEAK_PASSWORD : Password should be at least 6 characters':
          return 'Password should be at least 6 characters.';
        default:
          return 'Erro interno.';
      }
    } else {
      switch (code) {
        case 'MISSING_PASSWORD':
          return 'Campo de senha vazio. Por favor, preencha o campo de senha para continuar.';
        case 'INVALID_EMAIL':
          return 'Email inválido. Revise os dados e tente novamente.';
        case 'WEAK_PASSWORD : Password should be at least 6 characters':
          return 'A senha deve conter pelo menos 6 digitos.';
        default:
          return 'Erro interno.';
      }
    }
  }
}
