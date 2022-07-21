import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rhea_app/models/exercise.dart';
import 'package:rhea_app/navigation/routes.dart';
import 'package:rhea_app/styles/color.dart';
import 'package:routemaster/routemaster.dart';

class ExerciseDetailScreen extends StatelessWidget {
  const ExerciseDetailScreen({super.key, required this.stageId});
  final String stageId;

  @override
  Widget build(BuildContext context) {
    final _exercises = RouteData.of(context).queryParameters['video_exercises'];
    final exercises = _exercises == null || _exercises.isEmpty
        ? const <Exercise>[]
        : Exercise.fromString(_exercises);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        actions: [
          GestureDetector(
            onTap: () async => routemasterDelegate.pop(),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: botticelli,
              child: SvgPicture.asset(
                'assets/svg/ic_close.svg',
                color: white,
              ),
            ),
          ),
          const SizedBox(width: 20)
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => routemasterDelegate.push(
                  'video_player_demonstration',
                  queryParameters: {'video_exercises': _exercises!},
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl: exercises[0].previewImageUrl,
                          fit: BoxFit.fill,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                      AnimatedAlign(
                        duration: const Duration(milliseconds: 350),
                        alignment: AlignmentDirectional.center,
                        child: SvgPicture.asset(
                          'assets/svg/ic_play.svg',
                          color: white,
                          height: MediaQuery.of(context).size.width * 0.2,
                          width: MediaQuery.of(context).size.width * 0.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                exercises[0].name,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: biscay,
                    ),
              ),
              const SizedBox(height: 20),
              ...exercises[0].previewDescription.map(
                    (e) => Text(
                      '$e\n',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: biscay,
                            fontFamily: 'Polar',
                          ),
                      textAlign: TextAlign.center,
                    ),
                  )
            ],
          ),
        ),
      ),
    );
  }
}
