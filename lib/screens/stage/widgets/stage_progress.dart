import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhea_app/blocs/stage/stage_bloc.dart';
import 'package:rhea_app/extensions/stage_session_list_extension.dart';
import 'package:rhea_app/l10n/l10n.dart';
import 'package:rhea_app/shared/widgets/circular_percent_indicator.dart';
import 'package:rhea_app/styles/color.dart';
import 'package:shimmer/shimmer.dart';

class StageProgress extends StatelessWidget {
  const StageProgress({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return LayoutBuilder(
      builder: (context, constraints) => PhysicalModel(
        color: whiteLilac,
        shape: BoxShape.circle,
        shadowColor: Theme.of(context).shadowColor,
        elevation: 4,
        child: BlocBuilder<StageBloc, StageState>(
          builder: (context, state) {
            if (state is OnLoadingStage ||
                state is OnIdleStage ||
                state is OnFailedStage) {
              return Shimmer.fromColors(
                baseColor: biscay,
                highlightColor: turquoise,
                child: CircularPercentIndicator(
                  radius: constraints.maxWidth / 3,
                  lineWidth: 40,
                  animation: true,
                  animationDuration: 2000,
                  percent: 1,
                  animateFromLastPercent: true,
                  center: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          '100%',
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge
                              ?.copyWith(
                                color: turquoise,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ),
                      Text(
                        l10n.complete,
                        style:
                            Theme.of(context).textTheme.headlineLarge?.copyWith(
                                  color: turquoise,
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                    ],
                  ),
                  circularStrokeCap: CircularStrokeCap.round,
                  progressColor: turquoise,
                  backgroundColor: whiteLilac,
                ),
              );
            }
            final progress =
                (state as OnSuccessStage).stage.allSessions.progress;
            return CircularPercentIndicator(
              radius: constraints.maxWidth / 3,
              lineWidth: 40,
              animation: true,
              animationDuration: 2000,
              percent: progress,
              animateFromLastPercent: true,
              center: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      '${(progress * 100).toStringAsFixed(0)}%',
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            color: turquoise,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  Text(
                    l10n.complete,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          color: turquoise,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: turquoise,
              backgroundColor: whiteLilac,
            );
          },
        ),
      ),
    );
  }
}
