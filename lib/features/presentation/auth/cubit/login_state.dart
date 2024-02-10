part of 'login_cubit.dart';

sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginError extends LoginState {
  final String error;

  LoginError(this.error);
}


final class LoginSuccess extends LoginState {
final LoginEntity data;

  LoginSuccess(this.data);


}