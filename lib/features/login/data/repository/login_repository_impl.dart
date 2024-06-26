import 'package:close_ai/constants/app_constant.dart';
import 'package:close_ai/core/dio_provider/api_error.dart';
import 'package:close_ai/core/dio_provider/api_response.dart';
import 'package:close_ai/features/login/data/source/auth_remote_source.dart';
import 'package:close_ai/features/login/domain/repository/login_repository.dart';
import 'package:close_ai/features/signup/data/model/signup_response.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LoginRepository)
class LoginRepositoryImpl extends LoginRepository {
  LoginRepositoryImpl(this._remoteSource);
  final LoginRemoteSource _remoteSource;
  @override
  Future<Either<AppError, ApiResponse<SignUpResponse>>> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _remoteSource.login(email: email, pasword: password);
      return right(result);
    } on FirebaseAuthException catch (e) {
      return left(
        InternalAppError(message: e.message ?? AppConstants.errorMessage),
      );
    } catch (e) {
      return left(const InternalAppError());
    }
  }
}
