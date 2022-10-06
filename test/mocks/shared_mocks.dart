import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:rhea_app/repositories/network/remote/data_source/authentication/implementation/authenticate_implementation.dart';
import 'package:rhea_app/repositories/network/remote/data_source/profile/implementation/profile_implementation.dart';

@GenerateMocks([AuthenticateImplementation, ProfileImplementation, Storage])
class SharedMocks {}
