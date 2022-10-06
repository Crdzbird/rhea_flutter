import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhea_app/blocs/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:rhea_app/blocs/platform/platform_cubit.dart';
import 'package:rhea_app/styles/color.dart';

class RheaBottomNavigationBar extends StatelessWidget {
  const RheaBottomNavigationBar({
    super.key,
    required this.items,
  });
  final List<BottomNavigationBarItem> items;

  @override
  Widget build(BuildContext context) {
    if (context.read<PlatformCubit>().state.platformType ==
        PlatformType.android) {
      return BottomNavigationBar(
        items: items,
        currentIndex: context
            .select<BottomNavigationCubit, int>((value) => value.state.index),
        selectedItemColor: black,
        unselectedItemColor: linkWater,
        elevation: 0,
        onTap: (index) =>
            context.read<BottomNavigationCubit>().onIndexChanging(index),
      );
    }
    return CupertinoTabBar(
      items: items,
      activeColor: black,
      inactiveColor: linkWater,
      currentIndex: context
          .select<BottomNavigationCubit, int>((value) => value.state.index),
      onTap: (index) =>
          context.read<BottomNavigationCubit>().onIndexChanging(index),
    );
  }
}
