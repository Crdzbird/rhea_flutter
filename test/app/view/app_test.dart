// // Copyright (c) 2022, Very Good Ventures
// // https://verygood.ventures
// //
// // Use of this source code is governed by an MIT-style
// // license that can be found in the LICENSE file or at
// // https://opensource.org/licenses/MIT.

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:responsive_framework/responsive_framework.dart';
// import 'package:rhea_app/blocs/platform/platform_cubit.dart';
// import 'package:rhea_app/blocs/session/session_bloc.dart';
// import 'package:rhea_app/blocs/theme/theme_cubit.dart';
// import 'package:rhea_app/bootstrap.dart';
// import 'package:rhea_app/l10n/l10n.dart';
// import 'package:rhea_app/models/network/api_result.dart';
// import 'package:rhea_app/models/profile.dart';
// import 'package:rhea_app/models/session.dart';
// import 'package:rhea_app/navigation/routes.dart';
// import 'package:rhea_app/repositories/local/shared_preferences/shared_provider.dart';
// import 'package:rhea_app/repositories/network/remote/data_source/profile/implementation/profile_implementation.dart';
// import 'package:rhea_app/repositories/network/remote/data_source/session/implementation/session_implementation.dart';
// import 'package:rhea_app/repositories/network/remote/dio_helper.dart';
// import 'package:rhea_app/styles/theme_context.dart';
// import 'package:rhea_app/utils/crontask/crontask_provider.dart';
// import 'package:routemaster/routemaster.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../helpers/hydrated_bloc.dart';
// import '../../mocks/shared_mocks.mocks.dart';

// void main() {
//   TestWidgetsFlutterBinding.ensureInitialized();

//   setUp(() async {
//     initHydratedStorage();
//     SharedPreferences.setMockInitialValues({});
//     Bloc.observer = AppBlocObserver();
//     DioHelper.init();
//     CrontaskProvider.init();
//     await SharedProvider.init();
//   });
//   group('App', () {
//     late SessionBloc sessionBloc;
//     late MockSessionImplementation sessionImplementation;
//     late MockProfileImplementation profileImplementation;

//     setUp(() {
//       sessionImplementation = MockSessionImplementation();
//       profileImplementation = MockProfileImplementation();
//       sessionBloc = SessionBloc(
//         sessionImplementation: sessionImplementation,
//         profileImplementation: profileImplementation,
//       );
//     });

//     testWidgets('renders FirstPage', (tester) async {
//       when(profileImplementation.fetchProfile())
//           .thenAnswer((_) async => const ApiResult.success(data: Profile()));
//       when(sessionImplementation.refreshToken())
//           .thenAnswer((_) async => const ApiResult.success(data: Session()));
//       when(sessionBloc.checkSession())
//           .thenAnswer((_) async => const ApiResult.success(data: Session()));
//       when(sessionBloc.fetchProfile())
//           .thenAnswer((_) async => const ApiResult.success(data: Session()));
//       await tester.pumpApp();
//       expect(find.byType(SvgPicture), findsOneWidget);
//     });
//   });
// }

// extension PumpApp on WidgetTester {
//   Future<void> pumpApp() async {
//     await pumpWidget(
//       MultiRepositoryProvider(
//         providers: [
//           RepositoryProvider<ProfileImplementation>(
//             create: (_) => ProfileImplementation(),
//           ),
//           RepositoryProvider<SessionImplementation>(
//             create: (_) => SessionImplementation(),
//           ),
//         ],
//         child: MultiBlocProvider(
//           providers: [
//             BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
//             BlocProvider<PlatformCubit>(create: (_) => PlatformCubit()),
//           ],
//           child: BlocBuilder<ThemeCubit, ThemeState>(
//             builder: (context, themeState) {
//               return BlocBuilder<PlatformCubit, PlatformState>(
//                 builder: (context, platformState) => BlocProvider<SessionBloc>(
//                   create: (_) => SessionBloc(
//                     sessionImplementation:
//                         context.read<SessionImplementation>(),
//                     profileImplementation:
//                         context.read<ProfileImplementation>(),
//                   ),
//                   child: BlocBuilder<SessionBloc, SessionState>(
//                     builder: (context, state) {
//                       return MaterialApp.router(
//                         darkTheme: context.dark,
//                         theme: context.light,
//                         highContrastDarkTheme: context.dark,
//                         highContrastTheme: context.light,
//                         themeMode: themeState.theme,
//                         debugShowCheckedModeBanner: false,
//                         localizationsDelegates: const [
//                           AppLocalizations.delegate,
//                           GlobalMaterialLocalizations.delegate,
//                           GlobalWidgetsLocalizations.delegate,
//                           GlobalCupertinoLocalizations.delegate,
//                         ],
//                         builder: (_, child) => ResponsiveWrapper.builder(
//                           child,
//                           maxWidth: 1200,
//                           minWidth: 480,
//                           defaultScale: true,
//                           defaultName: MOBILE,
//                           breakpoints: [
//                             const ResponsiveBreakpoint.autoScale(
//                               480,
//                               name: MOBILE,
//                             ),
//                             const ResponsiveBreakpoint.resize(
//                               600,
//                               name: MOBILE,
//                             ),
//                             const ResponsiveBreakpoint.autoScale(
//                               850,
//                               name: TABLET,
//                             ),
//                             const ResponsiveBreakpoint.autoScale(
//                               1080,
//                               name: DESKTOP,
//                             ),
//                           ],
//                         ),
//                         supportedLocales: AppLocalizations.supportedLocales,
//                         routeInformationParser: const RoutemasterParser(),
//                         routerDelegate: routemasterDelegate,
//                       );
//                     },
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
