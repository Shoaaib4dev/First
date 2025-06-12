import 'package:ghj/services/auth/auth_exceptions.dart';
import 'package:ghj/services/auth/auth_provider.dart';
import 'package:ghj/services/auth/auth_user.dart';
import 'package:test/test.dart';

void main() {
  group('mock Authentication', () {
    final provider = MockAuthProvider();

    test('should not be Initialized to begin with', () {
      expect(provider.isInitialized, false);
    });

    test('cant logout not init', () {
      expect(
        provider.logout(),
        throwsA(const TypeMatcher<NotInitializedException>()),
      );
    });

    test('should be init', () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    });

    test('null', () {
      expect(provider.currentUser, null);
    });
    test('should be able ', () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    }, timeout: const Timeout(Duration(seconds: 2)));

    test('create user should deleee ', () async {
      final bademailuser = provider.createUser(
        email: 'shsen@hrr.com',
        password: 'kkkkfdsfk',
      );
      expect(
        bademailuser,
        throwsA(const TypeMatcher<UserNotFoundAuthException>()),
      );
      final badpassworduser = provider.createUser(
        email: 'shsren@h.com',
        password: 'Hhhhh',
      );
      expect(
        badpassworduser,
        throwsA(const TypeMatcher<WrongPasswordAuthException>()),
      );
      final user = await provider.createUser(email: "dfdf", password: 'ggg');
      expect(provider.currentUser, user);
      expect(user.isEmailVerified, false);
    });
  });
}

class NotInitializedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user ;
  var _isInitialized = false;
  bool get isInitialized => _isInitialized;

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    if (!isInitialized) throw NotInitializedException();
    await Future.delayed(const Duration(seconds: 1));
    return logIn(email: email, password: password);
  }

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    _isInitialized = true;
  }

  @override
  Future<AuthUser> logIn({required String email, required String password}) {
    if (!isInitialized) throw NotInitializedException();
    if (email == 'shsen@hrr.com') throw UserNotFoundAuthException();
    if (password == 'Hhhhh') throw WrongPasswordAuthException();
    const user = AuthUser(isEmailVerified: false,email: 'shsen@hrr.com');
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logout() async {
    if (!isInitialized) throw NotInitializedException();
    if (_user == null) throw UserNotFoundAuthException();
    await Future.delayed(const Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!isInitialized) throw NotInitializedException();
    final user = _user;
    if (user == null) throw UserNotFoundAuthException();
    const newUser = AuthUser(isEmailVerified: true, email:'shsen@hrr.com');
    _user = newUser;
  }
}
