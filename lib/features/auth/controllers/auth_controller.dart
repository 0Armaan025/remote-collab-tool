import '../repositories/auth_repository.dart';

class AuthController {
  final AuthRepository _authRepository = AuthRepository();

  Future<void> login(String email, String password) async {
    await _authRepository.login(email, password);
  }

  Future<void> register(String email, String password) async {
    await _authRepository.register(email, password);
  }

  Future<void> logout() async {
    await _authRepository.logout();
  }
}
