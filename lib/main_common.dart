import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_zero/app.dart';
import 'package:project_zero/firebase_options.dart';
import 'package:project_zero/utils/config_reader.dart';
import 'package:project_zero/utils/strings.dart';
import 'injection_container.dart' as di;

String? clientId;
String? clientSecret;
String baseUrl = "";

Future<void> mainCommon(String env) async {
  /// Initialize Flutter Binding
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  /// Fixing Device Orientation
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  /// Initializing Dipendency Injection
  await di.init();

  /// Reading Flavors
  await ConfigReader.initialize();
  switch (env) {
    case devENV:
      baseUrl = ConfigReader.getDevBaseUrl();
      clientId = ConfigReader.getDevClientId();
      clientSecret = ConfigReader.getDevClientSecret();
      break;
    case prodENV:
      baseUrl = ConfigReader.getProdBaseUrl();
      clientId = ConfigReader.getProdClientId();
      clientSecret = ConfigReader.getProdClientSecret();
      break;
  }
  log(clientId.toString(), name: "Client Id");
  log(clientSecret.toString(), name: "Client Secret");

  /// Running App
  runApp(const ProjectZero());
}
