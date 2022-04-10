import 'dart:io';

import 'package:local_auth/error_codes.dart' as error_codes;

class LocalAuthMessages {
  final String _locale = Platform.localeName.split('_')[0];

  String authenticateErrorMessage({
    required String code,
  }) {
    switch (code) {
      case error_codes.lockedOut:
        switch (_locale) {
          case 'en':
            return '';
          case 'es':
            return '';
          default:
            return 'Tentativas bloqueadas devido ao número de tentativas erradas. Tente novamente em alguns segundos ou utilize outro fator de seguranca (PIN/Padrão/Senha).';
        }
      case error_codes.notAvailable:
        switch (_locale) {
          case 'en':
            return '';
          case 'es':
            return '';
          default:
            return 'Infelizmente seu dispositivo não oferece suporte para biometria. Será necessário realizar a autenticação de dois fatores em todas as entradas no app.';
        }
      case error_codes.notEnrolled:
        switch (_locale) {
          case 'en':
            return '';
          case 'es':
            return '';
          default:
            return 'Seu dispositivo não está configurado para utilizar o recurso de biometria. Acesse as configurações do dispositivo  para ativar.';
        }
      case error_codes.otherOperatingSystem:
        switch (_locale) {
          case 'en':
            return '';
          case 'es':
            return '';
          default:
            return 'Seu dispositivo não é Android nem iOS';
        }
      case error_codes.passcodeNotSet:
        switch (_locale) {
          case 'en':
            return '';
          case 'es':
            return '';
          default:
            return 'Seu dispositivo não está configurado com proteção por nenhum fator de segurança. Acesse as configurações do dispositivo para ativar.';
        }
      case error_codes.permanentlyLockedOut:
        switch (_locale) {
          case 'en':
            return '';
          case 'es':
            return '';
          default:
            return 'Tentativas bloqueadas permanentemente devido ao número de tentativas erradas. Utilize outro fator de seguranca (PIN/Padrão/Senha).';
        }
      default:
        return 'Erro ao acessar os recursos de biometria. Tente novamente mais tarde.';
    }
  }

  String localizeReasonMessage() {
    switch (_locale) {
      case 'en':
        return 'en';
      case 'es':
        return 'es';
      default:
        return 'realize a authenticação para continuar';
    }
  }
}
