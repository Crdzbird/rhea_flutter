import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhea_app/blocs/video/player/player_bloc.dart';
import 'package:rhea_app/extensions/int_extension.dart';
import 'package:rhea_app/styles/color.dart';

class CircleTimer extends StatelessWidget {
  const CircleTimer({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: mirage,
      radius: MediaQuery.of(context).size.width * 0.05,
      child: Text(
        context.select((PlayerBloc bloc) => bloc.state) is VideoPositionState ||
                context.select((PlayerBloc bloc) => bloc.state)
                    is VideoPlayingState
            ? (context.select((PlayerBloc bloc) => bloc.state)
                    as VideoPositionState)
                .duration
                .inSeconds
                .toMinutesOrSecondsOrSeconds
            : '00:00',
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: portica,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
