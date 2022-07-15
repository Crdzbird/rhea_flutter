import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhea_app/blocs/platform/platform_cubit.dart';
import 'package:rhea_app/styles/color.dart';
import 'package:rhea_app/styles/typography.dart';

extension ThemeContext on BuildContext {
  ThemeData get light => ThemeData(
        // canvasColor: Colors.red,
        platform: read<PlatformCubit>().state.targetPlatform,
        useMaterial3: true,
        primarySwatch: createMaterialColor(social1),
        scaffoldBackgroundColor:
            read<PlatformCubit>().state.targetPlatform == PlatformType.android
                ? whiteLilac
                : linkWater,
        shadowColor: mirage_45,
        bottomSheetTheme:
            const BottomSheetThemeData(backgroundColor: mirage_45),
        appBarTheme: AppBarTheme(
          backgroundColor: whiteLilac,
          titleTextStyle: typographyLightTheme.titleMedium,
          elevation: 0,
          iconTheme: const IconThemeData(color: black),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: whiteLilac,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: smokeyGrey,
          contentTextStyle: typographyLightTheme.bodyMedium,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          behavior: SnackBarBehavior.floating,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: white,
          selectedIconTheme: const IconThemeData(
            color: turquoise,
          ),
          unselectedIconTheme: const IconThemeData(
            color: linkWater,
          ),
          selectedLabelStyle: typographyLightTheme.labelMedium?.copyWith(
            color: black,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: typographyLightTheme.labelMedium?.copyWith(
            color: linkWater,
            fontWeight: FontWeight.w600,
          ),
          selectedItemColor: black,
          unselectedItemColor: linkWater,
          showUnselectedLabels: true,
          showSelectedLabels: true,
          elevation: 0,
        ),
        fontFamily: 'Kansas',
        textTheme: typographyLightTheme,
      );

  ThemeData get dark => ThemeData(
        // canvasColor: Colors.red,
        platform: read<PlatformCubit>().state.targetPlatform,
        useMaterial3: true,
        primarySwatch: createMaterialColor(social1),
        scaffoldBackgroundColor:
            read<PlatformCubit>().state.targetPlatform == PlatformType.android
                ? whiteLilac
                : linkWater,
        shadowColor: mirage_45,
        bottomSheetTheme:
            const BottomSheetThemeData(backgroundColor: mirage_45),
        appBarTheme: AppBarTheme(
          backgroundColor: whiteLilac,
          titleTextStyle: typographyLightTheme.titleMedium,
          elevation: 0,
          iconTheme: const IconThemeData(color: black),
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: whiteLilac,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: smokeyGrey,
          contentTextStyle: typographyLightTheme.bodyMedium,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          behavior: SnackBarBehavior.floating,
        ),
        tabBarTheme: TabBarTheme(
          labelColor: black,
          unselectedLabelStyle: typographyLightTheme.labelLarge?.copyWith(
            color: Colors.yellow,
            fontWeight: FontWeight.w900,
          ),
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: whiteLilac,
          ),
          labelStyle: typographyLightTheme.labelLarge?.copyWith(
            color: black,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: white,
          selectedIconTheme: const IconThemeData(
            color: turquoise,
          ),
          unselectedIconTheme: const IconThemeData(
            color: linkWater,
          ),
          selectedLabelStyle: typographyLightTheme.labelLarge?.copyWith(
            color: black,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: typographyLightTheme.labelLarge?.copyWith(
            color: linkWater,
            fontWeight: FontWeight.w600,
          ),
          showUnselectedLabels: true,
          showSelectedLabels: true,
          elevation: 30,
        ),
        fontFamily: 'Kansas',
        textTheme: typographyLightTheme,
      );
}
