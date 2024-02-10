import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_zero/core/failures_and_exceptions.dart';
import 'package:project_zero/features/domain/entities/auth/login_entity.dart';
import 'package:project_zero/features/domain/usecases/auth/login_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUsecase loginUsecase;
  LoginCubit(this.loginUsecase) : super(LoginInitial());

  void login({required String email, required String password}) async {
    emit(LoginLoading());
    final result =
        await loginUsecase.call(LoginParams(email: email, password: password));
    result.fold((l) => _emitFailure(l), (data) {
      emit(LoginSuccess(data));
    });
  }

  FutureOr<void> _emitFailure(
    Failure failure,
  ) {
    if (failure is ServerFailure) {
      emit(LoginError(failure.message));
    } else if (failure is CacheFailure) {
      emit(LoginError(failure.message));
    } else {
      emit(LoginError(failure.message));
    }
  }
}
