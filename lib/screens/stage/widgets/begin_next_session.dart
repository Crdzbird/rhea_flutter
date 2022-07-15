import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rhea_app/blocs/work_session/work_session_bloc.dart';
import 'package:rhea_app/l10n/l10n.dart';
import 'package:rhea_app/shared/widgets/solid_button.dart';
import 'package:rhea_app/styles/color.dart';
import 'package:shimmer/shimmer.dart';

class BeginNextSession extends StatelessWidget {
  const BeginNextSession({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<WorkSessionBloc, WorkSessionState>(
      builder: (context, state) {
        if (state is OnIdleWorkSession ||
            state is OnLoadingWorkSession ||
            state is OnFailedWorkSession) {
          return Shimmer.fromColors(
            baseColor: biscay,
            highlightColor: turquoise,
            child: SolidButton(
              background: biscay,
              borderRadius: 50,
              padding: const EdgeInsetsDirectional.only(
                end: 100,
                top: 20,
                bottom: 20,
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Spacer(),
                  SvgPicture.asset(
                    'assets/svg/ic_play.svg',
                    color: turquoise,
                  ),
                  const SizedBox(width: 25),
                  Text(
                    l10n.begin_next_session,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          );
        }
        final _indexActive = (state as OnSuccessWorkSession)
            .stageSessions
            .indexWhere((element) => element.isActive);
        return SolidButton(
          background: biscay,
          borderRadius: 50,
          padding: const EdgeInsetsDirectional.only(
            end: 100,
            top: 20,
            bottom: 20,
          ),
          onPressed: () =>
              context.read<WorkSessionBloc>().navigateToStageDetail(
                    state.workSessions[_indexActive],
                  ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Spacer(),
              SvgPicture.asset(
                'assets/svg/ic_play.svg',
                color: turquoise,
              ),
              const SizedBox(width: 25),
              Text(
                l10n.begin_next_session,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const Spacer(),
            ],
          ),
        );
      },
    );
  }
}
