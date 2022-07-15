import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rhea_app/blocs/video/player/player_bloc.dart';
import 'package:rhea_app/blocs/video/visibility/visibility_cubit.dart';
import 'package:rhea_app/styles/color.dart';

class SecondaryController extends StatelessWidget {
  const SecondaryController({super.key, required this.preview});
  final bool preview;

  @override
  Widget build(BuildContext context) => Opacity(
        opacity: context.select((VisibilityCubit cubit) => cubit.state) ? 1 : 0,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: CircleAvatar(
                  backgroundColor: transparent,
                  child: SvgPicture.asset(
                    'assets/svg/ic_share_tv.svg',
                    color: white,
                    height: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            if (!preview)
              GestureDetector(
                onTap: () => context.read<PlayerBloc>().showFinishWorkout(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                    child: CircleAvatar(
                      backgroundColor: transparent,
                      child: SvgPicture.asset(
                        'assets/svg/ic_close.svg',
                        color: white,
                        height: 20,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
}
