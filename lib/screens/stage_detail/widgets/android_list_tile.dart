import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rhea_app/extensions/int_extension.dart';
import 'package:rhea_app/models/exercise.dart';
import 'package:rhea_app/styles/color.dart';

class AndroidListTile extends StatelessWidget {
  const AndroidListTile({
    super.key,
    required this.exercise,
    required this.onTap,
  });
  final Exercise exercise;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        splashColor: turquoise,
        borderRadius: BorderRadius.circular(
          20,
        ),
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: exercise.previewImageUrl,
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: 400,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  ),
                ),
                AnimatedPositioned(
                  top: 0,
                  left: MediaQuery.of(context).size.width * 0.05,
                  bottom: 0,
                  duration: const Duration(milliseconds: 350),
                  child: SvgPicture.asset(
                    'assets/svg/ic_play.svg',
                    color: white,
                    height: MediaQuery.of(context).size.width * 0.1,
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 5),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Text(
                exercise.name,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: biscay,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ),
            const Spacer(),
            Text(
              exercise.duration.toMinutesAndSeconds,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: botticelli,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      );
}
