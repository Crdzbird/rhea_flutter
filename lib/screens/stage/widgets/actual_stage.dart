import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhea_app/blocs/work_session/work_session_bloc.dart';
import 'package:rhea_app/l10n/l10n.dart';
import 'package:rhea_app/shared/widgets/row_flow.dart';
import 'package:rhea_app/styles/color.dart';
import 'package:shimmer/shimmer.dart';

class ActualStage extends StatelessWidget {
  const ActualStage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<WorkSessionBloc, WorkSessionState>(
      builder: (context, state) {
        if (state is OnLoadingWorkSession ||
            state is OnIdleWorkSession ||
            state is OnFailedWorkSession) {
          return Shimmer.fromColors(
            baseColor: biscay,
            highlightColor: turquoise,
            child: Column(
              children: [
                Text(
                  l10n.current_stage.toUpperCase(),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: biscay,
                        decoration: TextDecoration.underline,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  l10n.load,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: turquoise,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
                Text(
                  l10n.recommended_time_to_complete.toUpperCase(),
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: biscay,
                        decoration: TextDecoration.underline,
                      ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  l10n.load,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: turquoise,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 25),
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
                  child: RowFlow(items: [l10n.load, l10n.load, l10n.load]),
                ),
              ],
            ),
          );
        }
        final _stageSession = (state as OnSuccessWorkSession)
            .stageSessions
            .firstWhere((element) => element.isActive);
        return Column(
          children: [
            Text(
              l10n.current_stage.toUpperCase(),
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: biscay,
                    decoration: TextDecoration.underline,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              _stageSession.session.isEmpty ? l10n.load : _stageSession.session,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: turquoise,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),
            Text(
              l10n.recommended_time_to_complete.toUpperCase(),
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: biscay,
                    decoration: TextDecoration.underline,
                  ),
              textAlign: TextAlign.center,
            ),
            Text(
              _stageSession.session.isEmpty
                  ? l10n.load
                  : _stageSession.recommendedTime,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: turquoise,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),
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
              child: RowFlow(items: _stageSession.equipments),
            ),
          ],
        );
      },
    );
  }
}
