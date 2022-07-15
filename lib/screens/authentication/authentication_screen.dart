import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhea_app/blocs/authentication/authentication_bloc.dart';
import 'package:rhea_app/repositories/network/remote/data_source/authentication/implementation/authenticate_implementation.dart';
import 'package:rhea_app/repositories/network/remote/data_source/profile/implementation/profile_implementation.dart';
import 'package:rhea_app/screens/authentication/authentication_view.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticateImplementation:
              context.read<AuthenticateImplementation>(),
          profileImplementation: context.read<ProfileImplementation>(),
        ),
        child: const AuthenticationView(),
      );
}
