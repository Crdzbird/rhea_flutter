// ignore_for_file: strict_raw_type

import 'package:flutter/material.dart';
import 'package:rhea_app/navigation/route_rhea.dart';
import 'package:rhea_app/navigation/routes.dart';
import 'package:routemaster/routemaster.dart';

class RouteObserver extends RoutemasterObserver {
  // RoutemasterObserver extends NavigatorObserver and
  // receives all nested Navigator events
  @override
  void didPop(Route route, Route? previousRoute) {}

  @override
  void didChangeRoute(RouteData routeData, Page page) {
    if (routeData.path == RouteRhea.dashboardScreen.path) {
      routemasterDelegate.setNewRoutePath(routeData);
    }
  }

  @override
  void didPush(Route<Object?> route, Route<Object?>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route.settings.name == RouteRhea.authenticationScreen.path &&
        previousRoute?.settings.name == RouteRhea.dashboardScreen.path) {}
  }

  @override
  void didReplace({Route<Object?>? newRoute, Route<Object?>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute?.settings.name == RouteRhea.authenticationScreen.path &&
        oldRoute?.settings.name == RouteRhea.dashboardScreen.path) {}
  }
}
