import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rhea_app/blocs/authentication/authentication_bloc.dart';
import 'package:rhea_app/models/credentials.dart';
import 'package:rhea_app/models/enums/preferences_type.dart';
import 'package:rhea_app/models/network/api_result.dart';
import 'package:rhea_app/models/network/network_exceptions.dart';
import 'package:rhea_app/models/profile.dart';
import 'package:rhea_app/models/session.dart';
import 'package:rhea_app/repositories/local/shared_preferences/shared_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/hydrated_bloc.dart';
import '../mocks/shared_mocks.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('AuthenticationBloc', () {
    late MockAuthenticateImplementation autenticateImplementation;
    late MockProfileImplementation profileImplementation;
    late AuthenticationBloc authenticationBloc;

    setUp(() async {
      SharedPreferences.setMockInitialValues({
        PreferencesType.profile.name: const Profile(
          birthday: 220896,
          email: 'luisalfonsocb83@gmail.com',
          firstName: 'luis',
          id: '1',
          lastName: 'alfonso',
          trialStatus: 'paid',
        ).toJson,
        PreferencesType.session.name:
            const Session(authToken: 'token', refreshToken: 'refreshToken')
                .toJson
      });
      initHydratedStorage();
      autenticateImplementation = MockAuthenticateImplementation();
      profileImplementation = MockProfileImplementation();
      await SharedProvider.init();
      authenticationBloc = AuthenticationBloc(
        authenticateImplementation: autenticateImplementation,
        profileImplementation: profileImplementation,
      );
    });

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emit an Idle state when the bloc is created',
      build: () => authenticationBloc,
      act: (bloc) => bloc.add(const OnIdleEvent()),
      expect: () => [
        OnIdleAuthentication(),
      ],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'send credentials and emit a failure state',
      setUp: () async {
        when(
          profileImplementation.fetchProfile(),
        ).thenAnswer(
          (_) async => const ApiResult.failure(
            error: NetworkExceptions.badRequest(),
            message: 'Invalid credentials',
          ),
        );
      },
      build: () {
        authenticationBloc.usernameController.text = 'example@gmail.com';
        authenticationBloc.passwordController.text = '12345678';
        when(
          autenticateImplementation.authenticate(
            Credentials(
              email: authenticationBloc.usernameController.text,
              password: authenticationBloc.passwordController.text,
            ),
          ),
        ).thenAnswer(
          (_) async => const ApiResult.failure(
            error: NetworkExceptions.badGateway(),
            message: '',
          ),
        );
        return authenticationBloc;
      },
      act: (bloc) async {
        await bloc.sendCredentials();
      },
      expect: () => [
        OnLoadingAuthentication(),
        const OnFailedAuthentication(''),
      ],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'send credentials and emit a success state',
      build: () {
        authenticationBloc.usernameController.text = 'jack.chorley@me.com';
        authenticationBloc.passwordController.text = 'MySecurePassword1!';
        when(
          autenticateImplementation.authenticate(
            Credentials(
              email: authenticationBloc.usernameController.text,
              password: authenticationBloc.passwordController.text,
            ),
          ),
        ).thenAnswer(
          (_) async => const ApiResult.success(
            data: Session(authToken: 'token', refreshToken: 'refreshToken'),
          ),
        );
        when(
          profileImplementation.fetchProfile(),
        ).thenAnswer(
          (_) async => const ApiResult.success(
            data: Profile(
              birthday: 220896,
              email: 'luisalfonsocb83@gmail.com',
              firstName: 'luis',
              id: '1',
              lastName: 'alfonso',
              trialStatus: 'paid',
            ),
          ),
        );
        return authenticationBloc;
      },
      act: (bloc) => bloc.sendCredentials(),
      expect: () =>
          [OnLoadingAuthentication(), const OnSuccessAuthentication(Profile())],
    );
  });
}
