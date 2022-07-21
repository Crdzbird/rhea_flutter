import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rhea_app/blocs/video/player/player_bloc.dart';
import 'package:rhea_app/blocs/video/visibility/visibility_cubit.dart';
import 'package:rhea_app/extensions/duration_extension.dart';
import 'package:rhea_app/screens/videoplayer/widgets/circle_timer.dart';
import 'package:rhea_app/shared/widgets/circular_percent_indicator.dart';
import 'package:rhea_app/styles/color.dart';

class MainTimer extends StatelessWidget {
  const MainTimer({super.key, required this.preview});
  final bool preview;

  @override
  Widget build(BuildContext context) => preview
      ? const SizedBox.shrink()
      : Opacity(
          opacity:
              context.select((VisibilityCubit cubit) => cubit.state) ? 1 : 0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleTimer(),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        CircularPercentIndicator(
                          radius: MediaQuery.of(context).size.width * 0.015,
                          progressColor: turquoise,
                          backgroundColor: smokeyGrey,
                          percent: context.watch<PlayerBloc>().progress,
                          animation: true,
                          animateFromLastPercent: true,
                          animationDuration: 300,
                          circularStrokeCap: CircularStrokeCap.round,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          context
                              .watch<PlayerBloc>()
                              .totalRemainingTime
                              .toMinutesAndSeconds,
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/svg/ic_heart.svg',
                          color: persimmom,
                          width: MediaQuery.of(context).size.width * 0.03,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '00',
                          style:
                              Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
}
