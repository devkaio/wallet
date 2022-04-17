import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:wallet/shared/models/enviroment.dart';

import 'app_module.dart';
import 'app_widget.dart';

Future<void> main() async {
  await dotenv.load(fileName: Enviroment.fileName);

  runApp(
    ModularApp(
      module: AppModule(),
      child: const AppWidget(),
    ),
  );
}
