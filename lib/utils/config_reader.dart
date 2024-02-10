import 'dart:convert';

import 'package:flutter/services.dart';

abstract class ConfigReader {
  static Map<String, dynamic>? _config;

  static Future<void> initialize() async {
    final configString = await rootBundle.loadString('config/app_config.json');
    _config = json.decode(configString);
  }

  static String getDevBaseUrl() {
    return _config?['dev_base_url'];
  }

  static String getDevClientId() {
    return _config?['dev_client_id'];
  }

  static String getDevClientSecret() {
    return _config?['dev_client_secret'];
  }

  static String getProdClientId() {
    return _config?['prod_client_id'];
  }

  static String getProdClientSecret() {
    return _config?['prod_client_secret'];
  }

  static String getProdBaseUrl() {
    return _config?['prod_base_url'];
  }
}
