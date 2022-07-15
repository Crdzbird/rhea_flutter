// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:rhea_app/l10n/l10n.dart';
import 'package:rhea_app/models/exercise.dart';
import 'package:rhea_app/models/work_session.dart';
import 'package:rhea_app/navigation/routes.dart';
import 'package:rhea_app/screens/stage_detail/widgets/exercise_preview.dart';
import 'package:rhea_app/shared/widgets/solid_button.dart';
import 'package:rhea_app/styles/color.dart';

class StageVideoList extends StatefulWidget {
  const StageVideoList({super.key, required this.workSession});
  final WorkSession workSession;
  @override
  State<StageVideoList> createState() => _StageVideoListState();
}

class _StageVideoListState extends State<StageVideoList> {
  var _dragExtend = 0.1;
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (notification) {
        _dragExtend = notification.extent;
        return false;
      },
      child: DraggableScrollableSheet(
        initialChildSize: 0.1,
        minChildSize: 0.1,
        builder: (BuildContext context, ScrollController scrollController) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, -2),
                  blurRadius: 6,
                  color: Theme.of(context).shadowColor,
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  color: Theme.of(context).shadowColor,
                  height: 4,
                  width: MediaQuery.of(context).size.width * .3,
                ),
                const SizedBox(height: 25),
                Flexible(
                  child: ListView.separated(
                    controller: scrollController,
                    itemBuilder: (context, index) => Column(
                      children: [
                        Text(
                          '${1 + index}. ${widget.workSession.videoSections[index].name}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                color: biscay,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          widget.workSession.videoSections[index].detail,
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: hoki,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                        const SizedBox(height: 30),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          primary: false,
                          itemBuilder: (context, e) => ExercisePreview(
                            exercise: widget
                                .workSession.videoSections[index].exercises[e],
                            onTap: () => routemasterDelegate.push(
                              'exercise_detail',
                              queryParameters: {
                                'video_exercises': Exercise.toStringList(
                                  widget.workSession.videoSections[index]
                                      .exercises,
                                  e,
                                  widget.workSession.videoSections[index]
                                      .exercises.length,
                                )
                              },
                            ),
                          ),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          itemCount: widget.workSession.videoSections[index]
                              .exercises.length,
                        ),
                      ],
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 25,
                    ),
                    itemCount: widget.workSession.videoSections.length,
                  ),
                ),
                Visibility(
                  visible: _dragExtend > 0.2,
                  child: AnimatedOpacity(
                    opacity: _dragExtend <= 0.2 ? 0 : _dragExtend,
                    duration: const Duration(milliseconds: 300),
                    child: Column(
                      children: [
                        const SizedBox(height: 15),
                        SolidButton(
                          background: turquoise,
                          borderRadius: 50,
                          width: MediaQuery.of(context).size.width * 0.6,
                          title: Text(
                            l10n.begin_session,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          onPressed: () => routemasterDelegate.push(
                            'video_player',
                            queryParameters: {
                              'video_exercises': Exercise.toFullString(
                                widget.workSession.videoSections
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
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
