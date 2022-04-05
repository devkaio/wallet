import 'dart:io';

class LoginError {
  final String _locale = Platform.localeName.split('_')[0];

  String errorMessage({
    required String code,
  }) {
    if (_locale == 'en') {
      switch (code) {
        case 'user-not-found':
          return 'User don\'t exist in our database. Try another e-mail or create an account.';
        case 'wrong-password':
          return 'Incorrect password. Try again.';
        case 'invalid-email':
          return 'Invalid email address. Please provide correct email.';
        case 'too-many-requests':
          return 'We have blocked all requests from this device due to unusual activity. Try again later.';
        default:
          return 'internal error';
      }
    } else if (_locale == 'es') {
      switch (code) {
        case 'user-not-found':
          return 'Usuário não encontrado em nossa base de dados. Tente entrar com outro email ou crie uma conta.';
        case 'wrong-password':
          return 'Senha incorreta. Revise os dados e tente novamente.';
        case 'invalid-email':
          return 'Email inválido. Revise os dados e tente novamente.';
        case 'too-many-requests':
          return 'We have blocked all requests from this device due to unusual activity. Try again later.';
        default:
          return 'Erro interno.';
      }
    } else {
      switch (code) {
        case 'user-not-found':
          return 'Usuário não encontrado em nossa base de dados. Tente entrar com outro email ou crie uma conta.';
        case 'wrong-password':
          return 'Senha incorreta. Revise os dados e tente novamente.';
        case 'invalid-email':
          return 'Email inválido. Revise os dados e tente novamente.';
        case 'too-many-requests':
          return 'Acesso temporariamente bloqueado devido a muitas tentativas. Tente novamente em alguns minutos.';
        default:
          return 'Erro interno.';
      }
    }
  }
}
