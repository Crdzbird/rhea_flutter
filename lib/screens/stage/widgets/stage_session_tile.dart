import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rhea_app/blocs/work_session/work_session_bloc.dart';
import 'package:rhea_app/extensions/category_type_extension.dart';
import 'package:rhea_app/extensions/feeling_type_extension.dart';
import 'package:rhea_app/l10n/l10n.dart';
import 'package:rhea_app/models/enums/category_type.dart';
import 'package:rhea_app/models/enums/feelings_type.dart';
import 'package:rhea_app/shared/widgets/solid_button.dart';
import 'package:rhea_app/styles/color.dart';
import 'package:shimmer/shimmer.dart';

class StageSessionTile extends StatelessWidget {
  const StageSessionTile({super.key});

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
            child: ListView.separated(
              primary: false,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              itemBuilder: (context, index) => SolidButton(
                leading: SvgPicture.asset(
                  'assets/svg/ic_play.svg',
                ),
                title: const Text('title'),
                trailing: SvgPicture.asset(
                  'assets/svg/ic_play.svg',
                ),
                background: turquoise,
                borderRadius: 20,
                buttonPadding: const EdgeInsetsDirectional.only(
                  top: 20,
                  bottom: 20,
                ),
              ),
            ),
          );
        }
        return ListView.separated(
          primary: false,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: (state as OnSuccessWorkSession).stageSessions.length,
          separatorBuilder: (context, index) => const SizedBox(height: 15),
          itemBuilder: (context, index) {
            final _stageSession = state.stageSessions[index];
            return SolidButton(
              leading: SvgPicture.asset(
                _stageSession.feelingsType == FeelingsType.unkwnown
                    ? _stageSession.categoryType.icon
                    : _stageSession.feelingsType.icon,
                color: _stageSession.isCompleted
                    ? (_stageSession.feelingsType == FeelingsType.unkwnown
                        ? (_stageSession.categoryType == CategoryType.sleep
                            ? dullLavender
                            : turquoise)
                        : null)
                    : (_stageSession.isActive ? white : botticelli),
              ),
              title: Text(
                _stageSession.session.isEmpty
                    ? l10n.rhea
                    : _stageSession.session,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: _stageSession.isCompleted
                          ? black
                          : _stageSession.isActive
                              ? white
                              : botticelli,
                    ),
              ),
              trailing: _stageSession.isCompleted
                  ? SvgPicture.asset(
                      'assets/svg/ic_check.svg',
                    )
                  : const SizedBox.shrink(),
              background: _stageSession.isActive ? turquoise : white,
              borderRadius: 20,
              onPressed: _stageSession.isActive
                  ? () => context
                      .read<WorkSessionBloc>()
                      .navigateToStageDetail(state.workSessions[index])
                  : null,
              buttonPadding: const EdgeInsetsDirectional.only(
                top: 20,
                bottom: 20,
              ),
            );
          },
        );
      },
    );
  }
}
