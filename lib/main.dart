import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wallet/firebase_options.dart';
import 'package:wallet/shared/models/enviroment.dart';
import 'package:wallet/shared/services/firebase/crashlytics/crashlytics_service.dart';

import 'app_module.dart';
import 'app_widget.dart';

Future<void> main() async {
  await dotenv.load(fileName: Enviroment.fileName);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runZonedGuarded<Future<void>>(
    () async {
      await CrashlyticsService.initialize();

      runApp(
        ModularApp(
          module: AppModule(),
          child: const AppWidget(),
        ),
      );
    },
    (((error, stack) =>
        FirebaseCrashlytics.instance.recordError(error, stack))),
  );
}
