import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rhea_app/blocs/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:rhea_app/blocs/platform/platform_cubit.dart';
import 'package:rhea_app/l10n/l10n.dart';
import 'package:rhea_app/shared/widgets/rhea_bottom_navigation_bar.dart';
import 'package:rhea_app/styles/color.dart';
import 'package:routemaster/routemaster.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
      builder: (context, state) {
        if (context.read<PlatformCubit>().state.platformType ==
            PlatformType.android) {
          final tabPage = TabPage.of(context);
          return Scaffold(
            body: TabBarView(
              controller: tabPage.controller,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                for (final stack in tabPage.stacks)
                  PageStackNavigator(stack: stack),
              ],
            ),
            bottomNavigationBar: RheaBottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/svg/ic_stage.svg',
                    color:
                        context.read<BottomNavigationCubit>().state.index == 0
                            ? turquoise
                            : linkWater,
                  ),
                  label: l10n.stage,
                  tooltip: l10n.stage,
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/svg/ic_settings.svg',
                    color:
                        context.read<BottomNavigationCubit>().state.index == 1
                            ? turquoise
                            : linkWater,
                  ),
                  label: l10n.settings,
                  tooltip: l10n.settings,
                ),
              ],
            ),
          );
        }
        final tabPage = CupertinoTabPage.of(context);
        return CupertinoTabScaffold(
          controller: tabPage.controller,
          tabBuilder: tabPage.tabBuilder,
          tabBar: RheaBottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg/ic_stage.svg',
                  color: tabPage.index == 0 ? turquoise : linkWater,
                ),
                label: l10n.stage,
                tooltip: l10n.stage,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/svg/ic_settings.svg',
                  color: tabPage.index == 1 ? turquoise : linkWater,
                ),
                label: l10n.settings,
                tooltip: l10n.settings,
              ),
            ],
          ).build(context) as CupertinoTabBar,
        );
      },
    );
  }
}
