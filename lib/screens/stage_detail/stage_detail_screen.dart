import 'package:flutter/material.dart';
import 'package:rhea_app/extensions/int_extension.dart';
import 'package:rhea_app/l10n/l10n.dart';
import 'package:rhea_app/models/exercise.dart';
import 'package:rhea_app/models/work_session.dart';
import 'package:rhea_app/navigation/routes.dart';
import 'package:rhea_app/screens/stage_detail/widgets/cardhit_box.dart';
import 'package:rhea_app/screens/stage_detail/widgets/stage_video_list.dart';
import 'package:rhea_app/shared/widgets/row_flow.dart';
import 'package:rhea_app/shared/widgets/solid_button.dart';
import 'package:rhea_app/styles/color.dart';
import 'package:routemaster/routemaster.dart';

class StageDetailScreen extends StatelessWidget {
  const StageDetailScreen({super.key, required this.stageId});
  final String stageId;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final _workSession = RouteData.of(context).queryParameters['workSession'];
    final workSession = _workSession == null || _workSession.isEmpty
        ? const WorkSession()
        : WorkSession.fromJson(_workSession);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox.expand(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Text(
                        workSession.name,
                        style:
                            Theme.of(context).textTheme.headlineLarge?.copyWith(
                                  color: turquoise,
                                ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '${l10n.session} ${workSession.no}',
                        style:
                            Theme.of(context).textTheme.displayLarge?.copyWith(
                                  color: biscay,
                                ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      SolidButton(
                        title: Icon(
                          Icons.play_arrow,
                          color: white,
                          size: MediaQuery.of(context).size.width * 0.15,
                        ),
                        background: turquoise,
                        borderRadius: 100,
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.width * 0.2,
                        onPressed: () => routemasterDelegate.push(
                          'video_player',
                          queryParameters: {
                            'video_exercises': Exercise.toFullString(
                              workSession.videoSections
                                  .map(
                                    (section) => section.exercises,
                                  )
                                  .expand(
                                    (exercises) => exercises,
                                  )
                                  .toList(),
                            )
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        workSession.brief,
                        style:
                            Theme.of(context).textTheme.headlineLarge?.copyWith(
                                  color: biscay,
                                  fontWeight: FontWeight.w600,
                                ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 40),
                      Text(
                        workSession.description,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: biscay,
                              fontFamily: 'Polar',
                            ),
                      ),
                      CardHitBox(
                        time: workSession.duration.toMinutesAndSeconds,
                        heartbeat: '${workSession.targetHeartRate}',
                      ),
                      const SizedBox(height: 40),
                      Text(
                        l10n.equipment_required.toUpperCase(),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: biscay,
                              decoration: TextDecoration.underline,
                            ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: RowFlow(items: workSession.equipments),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            StageVideoList(
              workSession: workSession,
            ),
          ],
        ),
      ),
    );
  }
}
