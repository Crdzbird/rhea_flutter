import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rhea_app/blocs/authentication/authentication_bloc.dart';

import '../helpers/hydrated_bloc.dart';
import '../mocks/shared_mocks.mocks.dart';

void main() {
  setUp(initHydratedStorage);
  // -----------------------------------------------------------------
  group('User test reading details', () {
    final autenticateImplementation = MockAuthenticateImplementation();
    final profileImplementation = MockProfileImplementation();

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emit new state with all user details',
      build: () => AuthenticationBloc(
        authenticateImplementation: autenticateImplementation,
        profileImplementation: profileImplementation,
      ),
      act: (bloc) => bloc.add(const OnIdleEvent()),
      expect: () => [
        OnIdleAuthentication(),
      ],
    );
  });
}
