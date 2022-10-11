import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rhea_app/models/credentials.dart';
import 'package:rhea_app/models/network/api_result.dart';
import 'package:rhea_app/models/network/network_exceptions.dart';
import 'package:rhea_app/models/session.dart';
import 'package:rhea_app/repositories/network/remote/data_source/authentication/implementation/authenticate_implementation.dart';

import '../mocks/shared_mocks.mocks.dart';

void main() {
  late final AuthenticateImplementation authenticateImplementation;

  setUpAll(() {
    authenticateImplementation = MockAuthenticateImplementation();
  });

  test('Authenticate request ok', () async {
    when(
      authenticateImplementation.authenticate(
        const Credentials(email: 'email', password: 'password'),
      ),
    ).thenAnswer(
      (_) async => const ApiResult.success(
        data: Session(authToken: 'token', refreshToken: 'refreshToken'),
      ),
    );
    final result = await authenticateImplementation.authenticate(
      const Credentials(email: 'email', password: 'password'),
    );
    result.when(
      success: (data) {
        final session = data as Session;
        expect(session.authToken, 'token');
        expect(session.refreshToken, 'refreshToken');
      },
      failure: (error, message) {},
    );
  });

  test('Authenticate request failure', () async {
    when(
      authenticateImplementation.authenticate(
        const Credentials(email: 'email', password: 'password'),
      ),
    ).thenAnswer(
      (_) async => const ApiResult.failure(
        error: NetworkExceptions.badRequest(),
        message: 'error',
      ),
    );
    final result = await authenticateImplementation.authenticate(
      const Credentials(email: 'email', password: 'password'),
    );
    result.when(
      success: (data) {},
      failure: (error, message) {
        expect(error, const NetworkExceptions.badRequest());
        expect(message, 'error');
      },
    );
  });

  test('Authenticate.signOut', () {
    authenticateImplementation.signOut('');
    verify(authenticateImplementation.signOut('')).called(1);
  });
}
