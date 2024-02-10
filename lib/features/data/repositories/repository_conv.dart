import 'package:project_zero/features/data/models/auth/login_model.dart';
import 'package:project_zero/features/domain/entities/auth/login_entity.dart';

class RepositoryConv {
  static LoginEntity loginModelToEntityConv(LoginModel data) {
    return LoginEntity(
      id: data.result?.id,
      name: data.result?.username,
      token: data.result?.token,
    );
  }
}
