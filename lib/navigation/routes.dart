import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhea_app/blocs/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:rhea_app/blocs/platform/platform_cubit.dart';
import 'package:rhea_app/blocs/session/session_bloc.dart';
import 'package:rhea_app/navigation/route_rhea.dart';
import 'package:rhea_app/repositories/network/remote/data_source/authentication/implementation/authenticate_implementation.dart';
import 'package:rhea_app/repositories/network/remote/data_source/plan/implementation/plan_implementation.dart';
import 'package:rhea_app/repositories/network/remote/data_source/profile/implementation/profile_implementation.dart';
import 'package:rhea_app/repositories/network/remote/data_source/stage/implementation/stage_implementation.dart';
import 'package:rhea_app/repositories/network/remote/data_source/work_session/implementation/work_session_implementation.dart';
import 'package:rhea_app/screens/authentication/authentication_screen.dart';
import 'package:rhea_app/screens/authentication/email/email_screen.dart';
import 'package:rhea_app/screens/dashboard/dashboard_screen.dart';
import 'package:rhea_app/screens/ending_workout/ending_workout_screen.dart';
import 'package:rhea_app/screens/exercise_detail/exercise_detail_screen.dart';
import 'package:rhea_app/screens/stage/stage_screen.dart';
import 'package:rhea_app/screens/stage_detail/stage_detail_screen.dart';
import 'package:rhea_app/screens/trial/trial_screen.dart';
import 'package:rhea_app/screens/videoplayer/videoplayer_screen.dart';
import 'package:rhea_app/shared/widgets/rhea_webview.dart';
import 'package:routemaster/routemaster.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final RoutemasterDelegate routemasterDelegate = RoutemasterDelegate(
  navigatorKey: navigatorKey,
  observers: [RouteObserver()],
  routesBuilder: (context) {
    final sessionState = context.watch<SessionBloc>().state;
    if (sessionState.status == SessionState.unauthorized().status) {
      return _unauthenticatedRoutes(context);
    }
    if (sessionState.status == SessionState.authorized().status &&
        sessionState.status == SessionState.free().status) {
      return _freeRoutes(context);
    }
    if (sessionState.status == SessionState.authorized().status ||
        sessionState.status == SessionState.paid().status) {
      return _authenticatedRoutes(context);
    }

    return _unauthenticatedRoutes(context);

    //offline : access to the dashboard
    //online : access to the dashboard
    //unauthorized : access to the authentication screen
    //authorized : access to the dashboard
  },
);

RouteMap _unauthenticatedRoutes(BuildContext context) {
  if (context.read<PlatformCubit>().state.platformType ==
      PlatformType.android) {
    return RouteMap(
      routes: {
        RouteRhea.authenticationScreen.path: (routeData) {
          return MaterialPage<Widget>(
            child: RepositoryProvider(
              create: (context) => AuthenticateImplementation(),
              child: const AuthenticationScreen(),
            ),
            key: const ValueKey('authentication_page'),
            restorationId: 'authentication_page',
          );
        },
        RouteRhea.emailScreen.path: (routeData) {
          return MaterialPage<Widget>(
            child: MultiRepositoryProvider(
              providers: [
                RepositoryProvider(
                  create: (context) => AuthenticateImplementation(),
                ),
                RepositoryProvider(
                  create: (context) => ProfileImplementation(),
                ),
              ],
              child: const EmailScreen(),
            ),
            restorationId: 'email_page',
          );
        },
        RouteRhea.webviewScreen.path: (routeData) {
          return MaterialPage<Widget>(
            child: RheaWebView(
              url: routeData.queryParameters['url'] ?? 'https://getrhea.com',
            ),
            restorationId: 'webview_page',
          );
        },
        RouteRhea.trialScreen.path: (routeData) {
          return const MaterialPage<Widget>(
            child: TrialScreen(),
            restorationId: 'trial_page',
          );
        },
        RouteRhea.dashboardScreen.path: (routeData) {
          return IndexedPage(
            child: BlocProvider(
              create: (context) => BottomNavigationCubit(),
              child: const DashboardScreen(),
            ),
            paths: const ['stage', 'settings'],
          );
        },
        RouteRhea.stageScreen.path: (route) => MaterialPage<Widget>(
              child: MultiRepositoryProvider(
                providers: [
                  RepositoryProvider(
                    create: (context) => PlanImplementation(),
                  ),
                  RepositoryProvider(
                    create: (context) => StageImplementation(),
                  ),
                  RepositoryProvider(
                    create: (context) => WorkSessionImplementation(),
                  ),
                ],
                child: const StageScreen(),
              ),
              key: const ValueKey('stage'),
              restorationId: 'stage',
            ),
        RouteRhea.settingsScreen.path: (route) => const MaterialPage<Widget>(
              key: ValueKey('settings'),
              child: TrialScreen(),
              restorationId: 'settings',
            ),
        RouteRhea.stageDetailScreen.path: (route) => MaterialPage<Widget>(
              key: const ValueKey('stage_detail'),
              child: StageDetailScreen(
                stageId: route.pathParameters['stageId'] ?? '',
              ),
              restorationId: 'stage_detail',
            ),
        RouteRhea.videoPlayerScreen.path: (route) => MaterialPage<Widget>(
              key: const ValueKey('video_player'),
              child: VideoPlayerScreen(
                stageId: route.pathParameters['stageId'] ?? '',
                preview: false,
              ),
              restorationId: 'video_player',
            ),
        RouteRhea.endingWorkoutScreen.path: (route) => MaterialPage<Widget>(
              key: const ValueKey('ending_workout'),
              child: EndingWorkoutScreen(
                stageId: route.pathParameters['stageId'] ?? '',
              ),
              restorationId: 'ending_workout',
            ),
        RouteRhea.exerciseDetailScreen.path: (route) => MaterialPage<Widget>(
              key: const ValueKey('exercise_detail'),
              child: ExerciseDetailScreen(
                stageId: route.pathParameters['stageId'] ?? '',
              ),
              restorationId: 'exercise_detail',
            ),
        RouteRhea.videoPlayerDemonstrationScreen.path: (route) =>
            MaterialPage<Widget>(
              key: const ValueKey('video_player_demonstration'),
              child: VideoPlayerScreen(
                stageId: route.pathParameters['stageId'] ?? '',
                preview: true,
              ),
              restorationId: 'video_player_demonstration',
            ),
      },
      onUnknownRoute: (_) => Redirect(RouteRhea.authenticationScreen.path),
    );
  }
  if (context.read<PlatformCubit>().state.platformType == PlatformType.iOS) {
    return RouteMap(
      routes: {
        RouteRhea.authenticationScreen.path: (routeData) {
          return CupertinoPage<Widget>(
            child: RepositoryProvider(
              create: (context) => AuthenticateImplementation(),
              child: const AuthenticationScreen(),
            ),
            key: const ValueKey('authentication_page'),
            restorationId: 'authentication_page',
          );
        },
        RouteRhea.emailScreen.path: (routeData) {
          return CupertinoPage<Widget>(
            child: MultiRepositoryProvider(
              providers: [
                RepositoryProvider(
                  create: (context) => AuthenticateImplementation(),
                ),
                RepositoryProvider(
                  create: (context) => ProfileImplementation(),
                ),
              ],
              child: const EmailScreen(),
            ),
            restorationId: 'email_page',
          );
        },
        RouteRhea.webviewScreen.path: (routeData) {
          return CupertinoPage<Widget>(
            child: RheaWebView(
              url: routeData.queryParameters['url'] ?? 'https://getrhea.com',
            ),
            restorationId: 'webview_page',
          );
        },
        RouteRhea.trialScreen.path: (routeData) {
          return const CupertinoPage<Widget>(
            child: TrialScreen(),
            restorationId: 'trial_page',
          );
        },
        RouteRhea.dashboardScreen.path: (routeData) {
          return CupertinoTabPage(
            child: BlocProvider(
              create: (context) => BottomNavigationCubit(),
              child: const DashboardScreen(),
            ),
            paths: const ['stage', 'settings'],
          );
        },
        RouteRhea.stageScreen.path: (route) => CupertinoPage<Widget>(
              child: MultiRepositoryProvider(
                providers: [
                  RepositoryProvider(
                    create: (context) => PlanImplementation(),
                  ),
                  RepositoryProvider(
                    create: (context) => StageImplementation(),
                  ),
                  RepositoryProvider(
                    create: (context) => WorkSessionImplementation(),
                  ),
                ],
                child: const StageScreen(),
              ),
              key: const ValueKey('stage'),
              restorationId: 'stage',
            ),
        RouteRhea.settingsScreen.path: (route) => const CupertinoPage<Widget>(
              key: ValueKey('settings'),
              child: TrialScreen(),
              restorationId: 'settings',
            ),
        RouteRhea.stageDetailScreen.path: (route) => CupertinoPage<Widget>(
              key: const ValueKey('stage_detail'),
              child: StageDetailScreen(
                stageId: route.pathParameters['stageId'] ?? '',
              ),
              restorationId: 'stage_detail',
            ),
        RouteRhea.videoPlayerScreen.path: (route) => CupertinoPage<Widget>(
              key: const ValueKey('video_player'),
              child: VideoPlayerScreen(
                stageId: route.pathParameters['stageId'] ?? '',
                preview: false,
              ),
              restorationId: 'video_player',
            ),
        RouteRhea.endingWorkoutScreen.path: (route) => CupertinoPage<Widget>(
              key: const ValueKey('ending_workout'),
              child: EndingWorkoutScreen(
                stageId: route.pathParameters['stageId'] ?? '',
              ),
              restorationId: 'ending_workout',
            ),
        RouteRhea.exerciseDetailScreen.path: (route) => CupertinoPage<Widget>(
              key: const ValueKey('exercise_detail'),
              child: ExerciseDetailScreen(
                stageId: route.pathParameters['stageId'] ?? '',
              ),
              restorationId: 'exercise_detail',
            ),
        RouteRhea.videoPlayerDemonstrationScreen.path: (route) =>
            CupertinoPage<Widget>(
              key: const ValueKey('video_player_demonstration'),
              child: VideoPlayerScreen(
                stageId: route.pathParameters['stageId'] ?? '',
                preview: true,
              ),
              restorationId: 'video_player_demonstration',
            ),
      },
      onUnknownRoute: (_) => Redirect(RouteRhea.authenticationScreen.path),
    );
  }
  return RouteMap(
    routes: {
      RouteRhea.authenticationScreen.path: (routeData) {
        return MaterialPage<Widget>(
          child: RepositoryProvider(
            create: (context) => AuthenticateImplementation(),
            child: const AuthenticationScreen(),
          ),
          key: const ValueKey('authentication_page'),
          restorationId: 'authentication_page',
        );
      },
      RouteRhea.emailScreen.path: (routeData) {
        return MaterialPage<Widget>(
          child: MultiRepositoryProvider(
            providers: [
              RepositoryProvider(
                create: (context) => AuthenticateImplementation(),
              ),
              RepositoryProvider(
                create: (context) => ProfileImplementation(),
              ),
            ],
            child: const EmailScreen(),
          ),
          restorationId: 'email_page',
        );
      },
      RouteRhea.webviewScreen.path: (routeData) {
        return MaterialPage<Widget>(
          child: RheaWebView(
            url: routeData.queryParameters['url'] ?? 'https://getrhea.com',
          ),
          restorationId: 'webview_page',
        );
      },
      RouteRhea.dashboardScreen.path: (routeData) {
        return const IndexedPage(
          child: DashboardScreen(),
          paths: ['stage', 'settings'],
        );
      },
      RouteRhea.trialScreen.path: (routeData) {
        return const MaterialPage<Widget>(
          child: TrialScreen(),
          restorationId: 'trial_page',
        );
      },
    },
    onUnknownRoute: (_) => Redirect(RouteRhea.authenticationScreen.path),
  );
}

RouteMap _authenticatedRoutes(BuildContext context) {
  if (context.read<PlatformCubit>().state.platformType ==
      PlatformType.android) {
    return RouteMap(
      routes: {
        RouteRhea.authenticationScreen.path: (routeData) =>
            Redirect(RouteRhea.dashboardScreen.path),
        RouteRhea.webviewScreen.path: (routeData) {
          return MaterialPage<Widget>(
            child: RheaWebView(
              url: routeData.queryParameters['url'] ?? 'https://getrhea.com',
            ),
            restorationId: 'webview_page',
          );
        },
        RouteRhea.trialScreen.path: (routeData) {
          return const MaterialPage<Widget>(
            child: TrialScreen(),
            restorationId: 'trial_page',
          );
        },
        RouteRhea.dashboardScreen.path: (routeData) {
          return IndexedPage(
            child: BlocProvider(
              create: (context) => BottomNavigationCubit(),
              child: const DashboardScreen(),
            ),
            paths: const ['stage', 'settings'],
          );
        },
        RouteRhea.stageScreen.path: (route) => MaterialPage<Widget>(
              child: MultiRepositoryProvider(
                providers: [
                  RepositoryProvider(
                    create: (context) => PlanImplementation(),
                  ),
                  RepositoryProvider(
                    create: (context) => StageImplementation(),
                  ),
                  RepositoryProvider(
                    create: (context) => WorkSessionImplementation(),
                  ),
                ],
                child: const StageScreen(),
              ),
              key: const ValueKey('stage'),
              restorationId: 'stage',
            ),
        RouteRhea.settingsScreen.path: (route) => const MaterialPage<Widget>(
              key: ValueKey('settings'),
              child: TrialScreen(),
              restorationId: 'settings',
            ),
        RouteRhea.stageDetailScreen.path: (route) => MaterialPage<Widget>(
              key: const ValueKey('stage_detail'),
              child: StageDetailScreen(
                stageId: route.pathParameters['stageId'] ?? '',
              ),
              restorationId: 'stage_detail',
            ),
        RouteRhea.videoPlayerScreen.path: (route) => MaterialPage<Widget>(
              key: const ValueKey('video_player'),
              child: VideoPlayerScreen(
                stageId: route.pathParameters['stageId'] ?? '',
                preview: false,
              ),
              restorationId: 'video_player',
            ),
        RouteRhea.endingWorkoutScreen.path: (route) => MaterialPage<Widget>(
              key: const ValueKey('ending_workout'),
              child: EndingWorkoutScreen(
                stageId: route.pathParameters['stageId'] ?? '',
              ),
              restorationId: 'ending_workout',
            ),
        RouteRhea.exerciseDetailScreen.path: (route) => MaterialPage<Widget>(
              key: const ValueKey('exercise_detail'),
              child: ExerciseDetailScreen(
                stageId: route.pathParameters['stageId'] ?? '',
              ),
              restorationId: 'exercise_detail',
            ),
        RouteRhea.videoPlayerDemonstrationScreen.path: (route) =>
            MaterialPage<Widget>(
              key: const ValueKey('video_player_demonstration'),
              child: VideoPlayerScreen(
                stageId: route.pathParameters['stageId'] ?? '',
                preview: true,
              ),
              restorationId: 'video_player_demonstration',
            ),
      },
      onUnknownRoute: (_) => Redirect(RouteRhea.authenticationScreen.path),
    );
  }
  if (context.read<PlatformCubit>().state.platformType == PlatformType.iOS) {
    return RouteMap(
      routes: {
        RouteRhea.authenticationScreen.path: (routeData) =>
            Redirect(RouteRhea.dashboardScreen.path),
        RouteRhea.webviewScreen.path: (routeData) {
          return CupertinoPage<Widget>(
            child: RheaWebView(
              url: routeData.queryParameters['url'] ?? 'https://getrhea.com',
            ),
            restorationId: 'webview_page',
          );
        },
        RouteRhea.trialScreen.path: (routeData) {
          return const CupertinoPage<Widget>(
            child: TrialScreen(),
            restorationId: 'trial_page',
          );
        },
        RouteRhea.dashboardScreen.path: (routeData) {
          return CupertinoTabPage(
            child: BlocProvider(
              create: (context) => BottomNavigationCubit(),
              child: const DashboardScreen(),
            ),
            paths: const ['stage', 'settings'],
          );
        },
        RouteRhea.stageScreen.path: (route) => CupertinoPage<Widget>(
              child: MultiRepositoryProvider(
                providers: [
                  RepositoryProvider(
                    create: (context) => PlanImplementation(),
                  ),
                  RepositoryProvider(
                    create: (context) => StageImplementation(),
                  ),
                  RepositoryProvider(
                    create: (context) => WorkSessionImplementation(),
                  ),
                ],
                child: const StageScreen(),
              ),
              key: const ValueKey('stage'),
              restorationId: 'stage',
            ),
        RouteRhea.settingsScreen.path: (route) => const CupertinoPage<Widget>(
              key: ValueKey('settings'),
              child: Scaffold(
                body: Center(
                  child: Text('Settings'),
                ),
              ),
              restorationId: 'settings',
            ),
        RouteRhea.stageDetailScreen.path: (route) => CupertinoPage<Widget>(
              key: const ValueKey('stage_detail'),
              child: StageDetailScreen(
                stageId: route.pathParameters['stageId'] ?? 'empty',
              ),
              restorationId: 'stage_detail',
            ),
        RouteRhea.videoPlayerScreen.path: (route) => CupertinoPage<Widget>(
              key: const ValueKey('video_player'),
              child: VideoPlayerScreen(
                stageId: route.pathParameters['stageId'] ?? '',
                preview: false,
              ),
              restorationId: 'video_player',
            ),
        RouteRhea.endingWorkoutScreen.path: (route) => CupertinoPage<Widget>(
              key: const ValueKey('ending_workout'),
              child: EndingWorkoutScreen(
                stageId: route.pathParameters['stageId'] ?? '',
              ),
              restorationId: 'ending_workout',
            ),
        RouteRhea.exerciseDetailScreen.path: (route) => CupertinoPage<Widget>(
              key: const ValueKey('exercise_detail'),
              child: ExerciseDetailScreen(
                stageId: route.pathParameters['stageId'] ?? '',
              ),
              restorationId: 'exercise_detail',
            ),
        RouteRhea.videoPlayerDemonstrationScreen.path: (route) =>
            CupertinoPage<Widget>(
              key: const ValueKey('video_player_demonstration'),
              child: VideoPlayerScreen(
                stageId: route.pathParameters['stageId'] ?? '',
                preview: true,
              ),
              restorationId: 'video_player_demonstration',
            ),
      },
      onUnknownRoute: (_) => Redirect(RouteRhea.authenticationScreen.path),
    );
  }
  return RouteMap(
    routes: {
      RouteRhea.authenticationScreen.path: (routeData) =>
          Redirect(RouteRhea.dashboardScreen.path),
      RouteRhea.webviewScreen.path: (routeData) {
        return MaterialPage<Widget>(
          child: RheaWebView(
            url: routeData.queryParameters['url'] ?? 'https://getrhea.com',
          ),
          restorationId: 'webview_page',
        );
      },
      RouteRhea.dashboardScreen.path: (routeData) {
        return const IndexedPage(
          child: DashboardScreen(),
          paths: ['stage', 'settings'],
        );
      },
      RouteRhea.trialScreen.path: (routeData) {
        return const MaterialPage<Widget>(
          child: TrialScreen(),
          restorationId: 'trial_page',
        );
      },
    },
    onUnknownRoute: (_) => Redirect(RouteRhea.authenticationScreen.path),
  );
}

RouteMap _freeRoutes(BuildContext context) {
  if (context.read<PlatformCubit>().state.platformType ==
      PlatformType.android) {
    return RouteMap(
      routes: {
        RouteRhea.authenticationScreen.path: (routeData) {
          return const MaterialPage<Widget>(
            child: TrialScreen(),
            restorationId: 'trial_page',
          );
        },
      },
      onUnknownRoute: (_) => Redirect(RouteRhea.authenticationScreen.path),
    );
  }
  if (context.read<PlatformCubit>().state.platformType == PlatformType.iOS) {
    return RouteMap(
      routes: {
        RouteRhea.authenticationScreen.path: (routeData) {
          return const CupertinoPage<Widget>(
            child: TrialScreen(),
            restorationId: 'trial_page',
          );
        },
      },
      onUnknownRoute: (_) => Redirect(RouteRhea.authenticationScreen.path),
    );
  }
  return RouteMap(
    routes: {
      RouteRhea.authenticationScreen.path: (routeData) {
        return const MaterialPage<Widget>(
          child: TrialScreen(),
          restorationId: 'trial_page',
        );
      },
    },
    onUnknownRoute: (_) => Redirect(RouteRhea.authenticationScreen.path),
  );
}
