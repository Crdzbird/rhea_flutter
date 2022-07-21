// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:rhea_app/blocs/platform/platform_cubit.dart';
import 'package:rhea_app/blocs/session/session_bloc.dart';
import 'package:rhea_app/blocs/theme/theme_cubit.dart';
import 'package:rhea_app/l10n/l10n.dart';
import 'package:rhea_app/navigation/routes.dart';
import 'package:rhea_app/repositories/network/remote/data_source/profile/implementation/profile_implementation.dart';
import 'package:rhea_app/repositories/network/remote/data_source/session/implementation/session_implementation.dart';
import 'package:rhea_app/styles/theme_context.dart';
import 'package:rhea_app/utils/crontask/crontask.dart';
import 'package:rhea_app/utils/crontask/crontask_provider.dart';
import 'package:routemaster/routemaster.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    CrontaskProvider.cron.schedule(
      Schedule.parse('0 */5 * * *'),
      () => SessionImplementation().refreshToken(),
    );
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ProfileImplementation>(
          create: (_) => ProfileImplementation(),
        ),
        RepositoryProvider<SessionImplementation>(
          create: (_) => SessionImplementation(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeCubit>(create: (_) => ThemeCubit()),
          BlocProvider<PlatformCubit>(create: (_) => PlatformCubit()),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, themeState) {
            return BlocBuilder<PlatformCubit, PlatformState>(
              builder: (context, platformState) => BlocProvider<SessionBloc>(
                create: (_) => SessionBloc(
                  sessionImplementation: context.read<SessionImplementation>(),
                  profileImplementation: context.read<ProfileImplementation>(),
                ),
                child: BlocBuilder<SessionBloc, SessionState>(
                  builder: (context, state) {
                    return MaterialApp.router(
                      darkTheme: context.dark,
                      theme: context.light,
                      highContrastDarkTheme: context.dark,
                      highContrastTheme: context.light,
                      themeMode: themeState.theme,
                      debugShowCheckedModeBanner: false,
                      localizationsDelegates: const [
                        AppLocalizations.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                        GlobalCupertinoLocalizations.delegate,
                      ],
                      builder: (_, child) => ResponsiveWrapper.builder(
                        child,
                        maxWidth: 1200,
                        minWidth: 480,
                        defaultScale: true,
                        defaultName: MOBILE,
                        breakpoints: [
                          const ResponsiveBreakpoint.autoScale(
                            480,
                            name: MOBILE,
                          ),
                          const ResponsiveBreakpoint.resize(600, name: MOBILE),
                          const ResponsiveBreakpoint.autoScale(
                            850,
                            name: TABLET,
                          ),
                          const ResponsiveBreakpoint.autoScale(
                            1080,
                            name: DESKTOP,
                          ),
                        ],
                      ),
                      supportedLocales: AppLocalizations.supportedLocales,
                      routeInformationParser: const RoutemasterParser(),
                      routerDelegate: routemasterDelegate,
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
