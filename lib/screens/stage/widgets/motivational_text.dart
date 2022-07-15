import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhea_app/blocs/stage/stage_bloc.dart';
import 'package:rhea_app/l10n/l10n.dart';
import 'package:rhea_app/styles/color.dart';
import 'package:shimmer/shimmer.dart';

class MotivationalText extends StatelessWidget {
  const MotivationalText({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<StageBloc, StageState>(
      builder: (context, state) {
        if (state is OnLoadingStage ||
            state is OnIdleStage ||
            state is OnFailedStage) {
          return Shimmer.fromColors(
            baseColor: biscay,
            highlightColor: turquoise,
            child: Text(
              l10n.no_progress,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: hoki,
                  ),
            ),
          );
        }
        return Text(
          (context.read<StageBloc>().state as OnSuccessStage)
              .stage
              .motivationalText,
          style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: hoki,
              ),
        );
      },
    );
  }
}
