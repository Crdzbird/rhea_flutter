import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rhea_app/l10n/l10n.dart';
import 'package:rhea_app/styles/color.dart';

class CardHitBox extends StatelessWidget {
  const CardHitBox({super.key, required this.time, required this.heartbeat});
  final String time;
  final String heartbeat;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return GridView(
      shrinkWrap: true,
      padding: const EdgeInsetsDirectional.only(top: 20),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 2,
        crossAxisSpacing: 20,
      ),
      children: [
        DecoratedBox(
          decoration: const BoxDecoration(
            color: white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox.shrink(),
              SvgPicture.asset(
                'assets/svg/ic_timer.svg',
              ),
              Text(
                l10n.duration,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: biscay,
                    ),
              ),
              Text(
                time,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: turquoise,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox.shrink(),
            ],
          ),
        ),
        DecoratedBox(
          decoration: const BoxDecoration(
            color: white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox.shrink(),
              SvgPicture.asset(
                'assets/svg/ic_heart.svg',
              ),
              Text(
                l10n.target_heart_rate,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: biscay,
                    ),
              ),
              Text(
                heartbeat,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: persimmom,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox.shrink(),
            ],
          ),
        ),
      ],
    );
    // return Row(
    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
    //   children: [
    //     Expanded(
    //       child: DecoratedBox(
    //         decoration: const BoxDecoration(
    //           color: white,
    //           borderRadius: BorderRadius.all(Radius.circular(20)),
    //         ),
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           children: [
    //             const SizedBox.shrink(),
    //             SvgPicture.asset(
    //               'assets/svg/ic_timer.svg',
    //             ),
    //             Text(
    //               l10n.duration,
    //               style: Theme.of(context).textTheme.labelMedium?.copyWith(
    //                     color: biscay,
    //                   ),
    //             ),
    //             Text(
    //               '16:00',
    //               style: Theme.of(context).textTheme.displayMedium?.copyWith(
    //                     color: turquoise,
    //                     fontWeight: FontWeight.w600,
    //                   ),
    //             ),
    //             const SizedBox.shrink(),
    //           ],
    //         ),
    //       ),
    //     ),
    //     Expanded(
    //       child: DecoratedBox(
    //         decoration: const BoxDecoration(
    //           color: white,
    //           borderRadius: BorderRadius.all(Radius.circular(20)),
    //         ),
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //           children: [
    //             const SizedBox.shrink(),
    //             SvgPicture.asset(
    //               'assets/svg/ic_timer.svg',
    //             ),
    //             Text(
    //               l10n.duration,
    //               style: Theme.of(context).textTheme.labelMedium?.copyWith(
    //                     color: biscay,
    //                   ),
    //             ),
    //             Text(
    //               '16:00',
    //               style: Theme.of(context).textTheme.displayMedium?.copyWith(
    //                     color: turquoise,
    //                     fontWeight: FontWeight.w600,
    //                   ),
    //             ),
    //             const SizedBox.shrink(),
    //           ],
    //         ),
    //       ),
    //     ),
    //   ],
    // );
  }
}
