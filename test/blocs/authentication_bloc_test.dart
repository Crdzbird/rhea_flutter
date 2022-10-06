import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rhea_app/blocs/authentication/authentication_bloc.dart';
import 'package:rhea_app/models/credentials.dart';
import 'package:rhea_app/models/enums/preferences_type.dart';
import 'package:rhea_app/models/network/api_result.dart';
import 'package:rhea_app/models/profile.dart';
import 'package:rhea_app/models/session.dart';
import 'package:rhea_app/navigation/routes.dart';
import 'package:rhea_app/repositories/local/shared_preferences/shared_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helpers/hydrated_bloc.dart';
import '../mocks/shared_mocks.mocks.dart';

void main() {
  setUp(() {
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
          const Session(authToken: 'token', refreshToken: 'refreshToken').toJson
    });
    SharedProvider.init();
    initHydratedStorage();
  });
  group('User test reading details', () {
    final autenticateImplementation = MockAuthenticateImplementation();
    final profileImplementation = MockProfileImplementation();

    blocTest<AuthenticationBloc, AuthenticationState>(
      'emit an Idle state when the bloc is created',
      build: () => AuthenticationBloc(
        authenticateImplementation: autenticateImplementation,
        profileImplementation: profileImplementation,
      ),
      act: (bloc) => bloc.add(const OnIdleEvent()),
      expect: () => [
        OnIdleAuthentication(),
      ],
    );

    blocTest<AuthenticationBloc, AuthenticationState>(
      'send credentials and emit a success state',
      setUp: () {
        when(
          autenticateImplementation.authenticate(
            const Credentials(
              email: 'jack.chorley@me.com',
              password: 'MySecurePassword1!',
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
        when(
          routemasterDelegate.popUntil((routeData) => routeData.path == '/'),
        ).thenAnswer((_) async {});
        when(
          routemasterDelegate.replace(
            '/dashboard',
          ),
        ).thenAnswer((_) {});
      },
      build: () => AuthenticationBloc(
        authenticateImplementation: autenticateImplementation,
        profileImplementation: profileImplementation,
      ),
      act: (bloc) => bloc.sendCredentials(),
      expect: () => [OnLoadingAuthentication(), OnIdleAuthentication()],
    );
  });
}
