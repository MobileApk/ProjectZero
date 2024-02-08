import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_zero/app.dart';
import 'package:project_zero/utils/config_reader.dart';
import 'package:project_zero/utils/strings.dart';

String? clientId;
String? clientSecret;

Future<void> mainCommon(String env) async {
  WidgetsFlutterBinding.ensureInitialized();
  await ConfigReader.initialize();
  switch (env) {
    case devENV:
      clientId = ConfigReader.getStagingClientId();
      clientSecret = ConfigReader.getStagingClientSecret();
      break;
    case prodENV:
      clientId = ConfigReader.getProdClientId();
      clientSecret = ConfigReader.getProdClientSecret();
      break;
  }

  log(clientId.toString(), name: "Client Id");
  log(clientSecret.toString(), name: "Client Secret");
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}
