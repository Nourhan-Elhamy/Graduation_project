import 'package:flutter_bloc/flutter_bloc.dart';
import '../repos/auth_repo.dart';
import 'auth_cubit_states.dart';



class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;

  AuthCubit(this.repository) : super(AuthInitial());

  Future<void> register({
    required String email,
    required String password,
    required String fullName,
    required String address,
  }) async {
    emit(AuthLoading());
    try {
      final result = await repository.register(
        email: email,
        password: password,
        fullName: fullName,

      );
      result.fold(
        (failure) => emit(AuthFailure(failure)),
        (message) => emit(AuthSuccess(message)),
      );
    } catch (e) {
      emit(AuthFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final result = await repository.login(
        email: email,
        password: password,
      );
      result.fold(
            (failure) => emit(AuthFailure(failure)),
            (userData) => emit(LoginSuccess(userData)),      );
    } catch (e) {
      emit(AuthFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> forgetPassword({
    required String email,
  }) async {
    emit(AuthLoading());
    try {
      final result = await repository.forgetPassword(email: email);
      result.fold(
            (failure) => emit(AuthFailure(failure)),
            (data) {
          final message = data['message'] ?? 'Success';
          final code = data['code'] ?? '';
          final fullMessage = code.isNotEmpty ? '$message\ncode: $code' : message;
          emit(AuthSuccess(fullMessage));
        },
      );
    } catch (e) {
      emit(AuthFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> verifyCode({
    required String email,
    required String code,
  }) async {
    emit(AuthLoading());
    try {
      final result = await repository.verifyCode(email: email, code: code);
      result.fold(
            (failure) => emit(AuthFailure(failure)),
            (message) => emit(AuthSuccess(message)),
      );
    } catch (e) {
      emit(AuthFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }


  Future<void> resetPassword({
    required String email,
    required String code,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      final result = await repository.resetPassword(
        email: email,
        code: code,
        password: password,
      );
      result.fold(
            (failure) => emit(AuthFailure(failure)),
            (message) => emit(AuthSuccess(message)),
      );
    } catch (e) {
      emit(AuthFailure(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
