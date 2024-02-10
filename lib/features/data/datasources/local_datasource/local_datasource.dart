import 'package:project_zero/core/config/db_provider.dart';
import 'package:project_zero/core/config/my_shared_pref.dart';

abstract class LocalDataSource {
  void saveAccessToken(String accessToken);

  String getAccessToken();
}

class LocalDataSourceImpl extends LocalDataSource {
  final MySharedPref mySharedPref;
  final DBProvider dbProvider;

  LocalDataSourceImpl(this.mySharedPref, this.dbProvider);

  @override
  String getAccessToken() {
    return mySharedPref.getAccessToken();
  }

  @override
  void saveAccessToken(String accessToken) {
    mySharedPref.saveAccessToken(accessToken);
  }
}
