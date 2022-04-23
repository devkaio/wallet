import 'dart:isolate';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class CrashlyticsService {
  static Future<void> initialize() async {
    try {
      await FirebaseCrashlytics.instance
          .setCrashlyticsCollectionEnabled(!kDebugMode);
      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
      Isolate.current.addErrorListener(ErrorReport.isolateErrorListener);
    } catch (error) {
      debugPrint('Couldnt load FirebaseCrashlytics: $error');
    }
  }
}

class ErrorReport {
  static Future<void> _report(
    dynamic exception,
    StackTrace stackTrace,
    String tag,
  ) async {
    debugPrintStack(label: tag, stackTrace: stackTrace);
    await FirebaseCrashlytics.instance.setCustomKey(tag, exception.toString());
    await FirebaseCrashlytics.instance.log(exception.toString());
    await FirebaseCrashlytics.instance.recordError(exception, stackTrace);
  }

  static void externalFailureError(
      dynamic exception, StackTrace? stackTrace, String? reportTag) {
    if (stackTrace != null && reportTag != null && exception != null) {
      _report(exception, stackTrace, 'EXTERNAL_FAILURE: $reportTag');
    }
  }

  static SendPort get isolateErrorListener {
    return RawReceivePort((pair) async {
      final List<dynamic> errorAndStackTrace = pair;
      final exception = errorAndStackTrace[0];
      final stackTrace = errorAndStackTrace[1];
      _report(exception, stackTrace, 'ISOLATE');
    }).sendPort;
  }
}
