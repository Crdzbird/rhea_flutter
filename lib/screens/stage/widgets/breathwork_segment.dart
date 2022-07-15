import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rhea_app/blocs/stage/stage_bloc.dart';
import 'package:rhea_app/l10n/l10n.dart';
import 'package:rhea_app/shared/widgets/solid_button.dart';
import 'package:rhea_app/styles/color.dart';
import 'package:shimmer/shimmer.dart';

class BreathworkSegment extends StatelessWidget {
  const BreathworkSegment({super.key});

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.additional_breathwork.toUpperCase(),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: biscay,
                        decoration: TextDecoration.underline,
                      ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 20),
                Text(
                  l10n.breathwork,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: hoki,
                      ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 20),
                SolidButton(
                  leading: SvgPicture.asset(
                    'assets/svg/ic_play.svg',
                    color: biscay,
                  ),
                  title: Text(
                    l10n.breathwork,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: biscay,
                        ),
                  ),
                  trailing: Chip(
                    label: Text(
                      l10n.optional,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    backgroundColor: botticelli,
                  ),
                  background: white,
                  borderRadius: 20,
                  onPressed: () {},
                  buttonPadding: const EdgeInsetsDirectional.only(
                    top: 20,
                    bottom: 20,
                  ),
                )
              ],
            ),
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.additional_breathwork.toUpperCase(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: biscay,
                    decoration: TextDecoration.underline,
                  ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 20),
            Text(
              ((state as OnSuccessStage).stage.closingMotivationalText.isEmpty)
                  ? l10n.breathwork
                  : state.stage.closingMotivationalText,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: hoki,
                  ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 20),
            SolidButton(
              leading: SvgPicture.asset(
                'assets/svg/ic_play.svg',
                color: biscay,
              ),
              title: Text(
                l10n.breathwork,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: biscay,
                    ),
              ),
              trailing: Chip(
                label: Text(
                  l10n.optional,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                backgroundColor: botticelli,
              ),
              background: white,
              borderRadius: 20,
              onPressed: () {},
              buttonPadding: const EdgeInsetsDirectional.only(
                top: 20,
                bottom: 20,
              ),
            )
          ],
        );
      },
    );
  }
}
