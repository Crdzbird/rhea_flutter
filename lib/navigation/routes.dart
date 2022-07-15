import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhea_app/blocs/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:rhea_app/blocs/platform/platform_cubit.dart';
import 'package:rhea_app/blocs/session/session_bloc.dart';
import 'package:rhea_app/repositories/network/remote/data_source/authentication/implementation/authenticate_implementation.dart';
import 'package:rhea_app/repositories/network/remote/data_source/plan/implementation/plan_implementation.dart';
import 'package:rhea_app/repositories/network/remote/data_source/profile/implementation/profile_implementation.dart';
import 'package:rhea_app/repositories/network/remote/data_source/stage/implementation/stage_implementation.dart';
import 'package:rhea_app/repositories/network/remote/data_source/work_session/implementation/work_session_implementation.dart';
import 'package:rhea_app/screens/authentication/authentication_screen.dart';
import 'package:rhea_app/screens/authentication/email/email_screen.dart';
import 'package:rhea_app/screens/dashboard/dashboard_screen.dart';
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
        '/': (routeData) {
          return MaterialPage<Widget>(
            child: RepositoryProvider(
              create: (context) => AuthenticateImplementation(),
              child: const AuthenticationScreen(),
            ),
            key: const ValueKey('authentication_page'),
            restorationId: 'authentication_page',
          );
        },
        '/email': (routeData) {
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
        '/rheaWebView': (routeData) {
          return MaterialPage<Widget>(
            child: RheaWebView(
              url: routeData.queryParameters['url'] ?? 'https://getrhea.com',
            ),
            restorationId: 'webview_page',
          );
        },
        '/trial': (routeData) {
          return const MaterialPage<Widget>(
            child: TrialScreen(),
            restorationId: 'trial_page',
          );
        },
        '/dashboard': (routeData) {
          return TabPage(
            child: BlocProvider(
              create: (context) => BottomNavigationCubit(),
              child: const DashboardScreen(),
            ),
            paths: const ['stage', 'settings'],
          );
        },
        '/dashboard/stage': (route) => MaterialPage<Widget>(
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
        '/dashboard/settings': (route) => const MaterialPage<Widget>(
              key: ValueKey('settings'),
              child: TrialScreen(),
              restorationId: 'settings',
            ),
        '/dashboard/stage_detail/:stageId': (route) => MaterialPage<Widget>(
              key: const ValueKey('stage_detail'),
              child: StageDetailScreen(
                stageId: route.pathParameters['stageId'] ?? '',
              ),
              restorationId: 'stage_detail',
            ),
        '/dashboard/stage_detail/:stageId/video_player': (route) =>
            MaterialPage<Widget>(
              key: const ValueKey('video_player'),
              child: VideoPlayerScreen(
                stageId: route.pathParameters['stageId'] ?? '',
                preview: false,
              ),
              restorationId: 'video_player',
            ),
        '/dashboard/stage_detail/:stageId/exercise_detail': (route) =>
            MaterialPage<Widget>(
              key: const ValueKey('exercise_detail'),
              child: ExerciseDetailScreen(
                stageId: route.pathParameters['stageId'] ?? '',
              ),
              restorationId: 'exercise_detail',
            ),
        '/dashboard/stage_detail/:stageId/exercise_detail/video_player_demonstration':
            (route) => MaterialPage<Widget>(
                  key: const ValueKey('video_player_demonstration'),
                  child: VideoPlayerScreen(
                    stageId: route.pathParameters['stageId'] ?? '',
                    preview: true,
                  ),
                  restorationId: 'video_player_demonstration',
                ),
      },
      onUnknownRoute: (_) => const Redirect('/'),
    );
  }
  if (context.read<PlatformCubit>().state.platformType == PlatformType.iOS) {
    return RouteMap(
      routes: {
        '/': (routeData) {
          return CupertinoPage<Widget>(
            child: RepositoryProvider(
              create: (context) => AuthenticateImplementation(),
              child: const AuthenticationScreen(),
            ),
            key: const ValueKey('authentication_page'),
            restorationId: 'authentication_page',
          );
        },
        '/email': (routeData) {
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
        '/rheaWebView': (routeData) {
          return CupertinoPage<Widget>(
            child: RheaWebView(
              url: routeData.queryParameters['url'] ?? 'https://getrhea.com',
            ),
            restorationId: 'webview_page',
          );
        },
        '/trial': (routeData) {
          return const CupertinoPage<Widget>(
            child: TrialScreen(),
            restorationId: 'trial_page',
          );
        },
        '/dashboard': (routeData) {
          return CupertinoTabPage(
            child: BlocProvider(
              create: (context) => BottomNavigationCubit(),
              child: const DashboardScreen(),
            ),
            paths: const ['stage', 'settings'],
          );
        },
        '/dashboard/stage': (route) => CupertinoPage<Widget>(
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
        '/dashboard/settings': (route) => const CupertinoPage<Widget>(
              key: ValueKey('settings'),
              child: Scaffold(
                body: Center(
                  child: Text('Settings'),
                ),
              ),
              restorationId: 'settings',
            ),
        '/dashboard/stage_detail/:stageId': (route) => CupertinoPage<Widget>(
              key: const ValueKey('stage_detail'),
              child: StageDetailScreen(
                stageId: route.pathParameters['stageId'] ?? '',
              ),
              restorationId: 'stage_detail',
            ),
        '/dashboard/stage_detail/:stageId/video_player': (route) =>
            CupertinoPage<Widget>(
              key: const ValueKey('video_player'),
              child: VideoPlayerScreen(
                stageId: route.pathParameters['stageId'] ?? '',
                preview: false,
              ),
              restorationId: 'video_player',
            ),
        '/dashboard/stage_detail/:stageId/exercise_detail': (route) =>
            CupertinoPage<Widget>(
              key: const ValueKey('exercise_detail'),
              child: ExerciseDetailScreen(
                stageId: route.pathParameters['stageId'] ?? '',
              ),
              restorationId: 'exercise_detail',
            ),
        '/dashboard/stage_detail/:stageId/exercise_detail/video_player_demonstration':
            (route) => CupertinoPage<Widget>(
                  key: const ValueKey('video_player_demonstration'),
                  child: VideoPlayerScreen(
                    stageId: route.pathParameters['stageId'] ?? '',
                    preview: true,
                  ),
                  restorationId: 'video_player_demonstration',
                ),
      },
      onUnknownRoute: (_) => const Redirect('/'),
    );
  }
  return RouteMap(
    routes: {
      '/': (routeData) {
        return MaterialPage<Widget>(
          child: RepositoryProvider(
            create: (context) => AuthenticateImplementation(),
            child: const AuthenticationScreen(),
          ),
          key: const ValueKey('authentication_page'),
          restorationId: 'authentication_page',
        );
      },
      '/email': (routeData) {
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
      '/rheaWebView': (routeData) {
        return MaterialPage<Widget>(
          child: RheaWebView(
            url: routeData.queryParameters['url'] ?? 'https://getrhea.com',
          ),
          restorationId: 'webview_page',
        );
      },
      '/dashboard': (routeData) {
        return const TabPage(
          child: DashboardScreen(),
          paths: ['stage', 'settings'],
        );
      },
      '/trial': (routeData) {
        return const MaterialPage<Widget>(
          child: TrialScreen(),
          restorationId: 'trial_page',
        );
      },
    },
    onUnknownRoute: (_) => const Redirect('/'),
  );
}

RouteMap _authenticatedRoutes(BuildContext context) {
  if (context.read<PlatformCubit>().state.platformType ==
      PlatformType.android) {
    return RouteMap(
      routes: {
        '/': (routeData) => const Redirect('/dashboard'),
        '/rheaWebView': (routeData) {
          return MaterialPage<Widget>(
            child: RheaWebView(
              url: routeData.queryParameters['url'] ?? 'https://getrhea.com',
            ),
            restorationId: 'webview_page',
          );
        },
        '/trial': (routeData) {
          return const MaterialPage<Widget>(
            child: TrialScreen(),
            restorationId: 'trial_page',
          );
        },
        '/dashboard': (routeData) {
          return TabPage(
            child: BlocProvider(
              create: (context) => BottomNavigationCubit(),
              child: const DashboardScreen(),
            ),
            paths: const ['stage', 'settings'],
          );
        },
        '/dashboard/stage': (route) => MaterialPage<Widget>(
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
        '/dashboard/settings': (route) => const MaterialPage<Widget>(
              key: ValueKey('settings'),
              child: TrialScreen(),
              restorationId: 'settings',
            ),
        '/dashboard/stage_detail/:stageId': (route) => MaterialPage<Widget>(
              key: const ValueKey('stage_detail'),
              child: StageDetailScreen(
                stageId: route.pathParameters['stageId'] ?? '',
              ),
              restorationId: 'stage_detail',
            ),
        '/dashboard/stage_detail/:stageId/video_player': (route) =>
            MaterialPage<Widget>(
              key: const ValueKey('video_player'),
              child: VideoPlayerScreen(
                stageId: route.pathParameters['stageId'] ?? '',
                preview: false,
              ),
              restorationId: 'video_player',
            ),
        '/dashboard/stage_detail/:stageId/exercise_detail': (route) =>
            MaterialPage<Widget>(
              key: const ValueKey('exercise_detail'),
              child: ExerciseDetailScreen(
                stageId: route.pathParameters['stageId'] ?? '',
              ),
              restorationId: 'exercise_detail',
            ),
        '/dashboard/stage_detail/:stageId/exercise_detail/video_player_demonstration':
            (route) => MaterialPage<Widget>(
                  key: const ValueKey('video_player_demonstration'),
                  child: VideoPlayerScreen(
                    stageId: route.pathParameters['stageId'] ?? '',
                    preview: true,
                  ),
                  restorationId: 'video_player_demonstration',
                ),
      },
      onUnknownRoute: (_) => const Redirect('/'),
    );
  }
  if (context.read<PlatformCubit>().state.platformType == PlatformType.iOS) {
    return RouteMap(
      routes: {
        '/': (routeData) => const Redirect('/dashboard'),
        '/rheaWebView': (routeData) {
          return CupertinoPage<Widget>(
            child: RheaWebView(
              url: routeData.queryParameters['url'] ?? 'https://getrhea.com',
            ),
            restorationId: 'webview_page',
          );
        },
        '/trial': (routeData) {
          return const CupertinoPage<Widget>(
            child: TrialScreen(),
            restorationId: 'trial_page',
          );
        },
        '/dashboard': (routeData) {
          return CupertinoTabPage(
            child: BlocProvider(
              create: (context) => BottomNavigationCubit(),
              child: const DashboardScreen(),
            ),
            paths: const ['stage', 'settings'],
          );
        },
        '/dashboard/stage': (route) => CupertinoPage<Widget>(
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
        '/dashboard/settings': (route) => const CupertinoPage<Widget>(
              key: ValueKey('settings'),
              child: Scaffold(
                body: Center(
                  child: Text('Settings'),
                ),
              ),
              restorationId: 'settings',
            ),
        '/dashboard/stage_detail/:stageId': (route) => CupertinoPage<Widget>(
              key: const ValueKey('stage_detail'),
              child: StageDetailScreen(
                stageId: route.pathParameters['stageId'] ?? 'empty',
              ),
              restorationId: 'stage_detail',
            ),
        '/dashboard/stage_detail/:stageId/video_player': (route) =>
            CupertinoPage<Widget>(
              key: const ValueKey('video_player'),
              child: VideoPlayerScreen(
                stageId: route.pathParameters['stageId'] ?? '',
                preview: false,
              ),
              restorationId: 'video_player',
            ),
        '/dashboard/stage_detail/:stageId/exercise_detail': (route) =>
            CupertinoPage<Widget>(
              key: const ValueKey('exercise_detail'),
              child: ExerciseDetailScreen(
                stageId: route.pathParameters['stageId'] ?? '',
              ),
              restorationId: 'exercise_detail',
            ),
        '/dashboard/stage_detail/:stageId/exercise_detail/video_player_demonstration':
            (route) => CupertinoPage<Widget>(
                  key: const ValueKey('video_player_demonstration'),
                  child: VideoPlayerScreen(
                    stageId: route.pathParameters['stageId'] ?? '',
                    preview: true,
                  ),
                  restorationId: 'video_player_demonstration',
                ),
      },
      onUnknownRoute: (_) => const Redirect('/'),
    );
  }
  return RouteMap(
    routes: {
      '/': (routeData) => const Redirect('/dashboard'),
      '/rheaWebView': (routeData) {
        return MaterialPage<Widget>(
          child: RheaWebView(
            url: routeData.queryParameters['url'] ?? 'https://getrhea.com',
          ),
          restorationId: 'webview_page',
        );
      },
      '/dashboard': (routeData) {
        return const TabPage(
          child: DashboardScreen(),
          paths: ['stage', 'settings'],
        );
      },
      '/trial': (routeData) {
        return const MaterialPage<Widget>(
          child: TrialScreen(),
          restorationId: 'trial_page',
        );
      },
    },
    onUnknownRoute: (_) => const Redirect('/'),
  );
}

RouteMap _freeRoutes(BuildContext context) {
  if (context.read<PlatformCubit>().state.platformType ==
      PlatformType.android) {
    return RouteMap(
      routes: {
        '/': (routeData) {
          return const MaterialPage<Widget>(
            child: TrialScreen(),
            restorationId: 'trial_page',
          );
        },
      },
      onUnknownRoute: (_) => const Redirect('/'),
    );
  }
  if (context.read<PlatformCubit>().state.platformType == PlatformType.iOS) {
    return RouteMap(
      routes: {
        '/': (routeData) {
          return const CupertinoPage<Widget>(
            child: TrialScreen(),
            restorationId: 'trial_page',
          );
        },
      },
      onUnknownRoute: (_) => const Redirect('/'),
    );
  }
  return RouteMap(
    routes: {
      '/': (routeData) {
        return const MaterialPage<Widget>(
          child: TrialScreen(),
          restorationId: 'trial_page',
        );
      },
    },
    onUnknownRoute: (_) => const Redirect('/'),
  );
}
