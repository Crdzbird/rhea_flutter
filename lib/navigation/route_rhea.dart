enum RouteRhea {
  authenticationScreen('/'),
  emailScreen('/email'),
  webviewScreen('/rheaWebView/:url'),
  trialScreen('/trial'),
  dashboardScreen('/dashboard'),
  stageScreen('/dashboard/stage'),
  settingsScreen('/dashboard/settings'),
  stageDetailScreen('/dashboard/stage_detail/:stageId'),
  videoPlayerScreen('/dashboard/stage_detail/:stageId/video_player'),
  endingWorkoutScreen('/dashboard/stage_detail/:stageId/ending_workout'),
  exerciseDetailScreen('/dashboard/stage_detail/:stageId/exercise_detail'),
  videoPlayerDemonstrationScreen(
    '/dashboard/stage_detail/:stageId/exercise_detail/video_player_demonstration',
  ),
  notFoundScreen('/404');

  const RouteRhea(this.path);
  final String path;

  List<RouteRhea> get screens => [
        authenticationScreen,
        emailScreen,
        trialScreen,
        dashboardScreen,
        webviewScreen,
        stageScreen,
        settingsScreen,
        stageDetailScreen,
        videoPlayerScreen,
        endingWorkoutScreen,
        exerciseDetailScreen,
        videoPlayerDemonstrationScreen,
        notFoundScreen,
      ];
}
