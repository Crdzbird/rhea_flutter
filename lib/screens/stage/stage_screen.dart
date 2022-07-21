import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rhea_app/blocs/plan/plan_bloc.dart';
import 'package:rhea_app/blocs/stage/stage_bloc.dart';
import 'package:rhea_app/blocs/work_session/work_session_bloc.dart';
import 'package:rhea_app/repositories/network/remote/data_source/plan/implementation/plan_implementation.dart';
import 'package:rhea_app/repositories/network/remote/data_source/stage/implementation/stage_implementation.dart';
import 'package:rhea_app/repositories/network/remote/data_source/work_session/implementation/work_session_implementation.dart';
import 'package:rhea_app/screens/stage/widgets/actual_stage.dart';
import 'package:rhea_app/screens/stage/widgets/begin_next_session.dart';
import 'package:rhea_app/screens/stage/widgets/breathwork_segment.dart';
import 'package:rhea_app/screens/stage/widgets/motivational_text.dart';
import 'package:rhea_app/screens/stage/widgets/stage_greeting.dart';
import 'package:rhea_app/screens/stage/widgets/stage_progress.dart';
import 'package:rhea_app/screens/stage/widgets/stage_session_tile.dart';

class StageScreen extends StatelessWidget {
  const StageScreen({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider<PlanBloc>(
            create: (context) => PlanBloc(
              planImplementation: context.read<PlanImplementation>(),
            ),
          ),
          BlocProvider<StageBloc>(
            create: (context) => StageBloc(
              stageImplementation: context.read<StageImplementation>(),
              planBloc: context.read<PlanBloc>(),
            ),
          ),
          BlocProvider<WorkSessionBloc>(
            create: (context) => WorkSessionBloc(
              workSessionImplementation:
                  context.read<WorkSessionImplementation>(),
              stageBloc: context.read<StageBloc>(),
            ),
          ),
        ],
        child: const _StageScreen(),
      );
}

class _StageScreen extends StatelessWidget {
  const _StageScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              AnimatedAlign(
                duration: const Duration(milliseconds: 350),
                alignment: AlignmentDirectional.centerStart,
                child: SvgPicture.asset(
                  'assets/svg/ic_rhea.svg',
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: MediaQuery.of(context).size.width * 0.15,
                ),
              ),
              const SizedBox(height: 20),
              const StageGreeting(),
              const SizedBox(height: 25),
              const MotivationalText(),
              const SizedBox(height: 40),
              const BeginNextSession(),
              const SizedBox(height: 20),
              LimitedBox(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
                maxHeight: MediaQuery.of(context).size.height * 0.4,
                child: const StageProgress(),
              ),
              const SizedBox(height: 30),
              const StageSessionTile(),
              const SizedBox(height: 30),
              const AnimatedAlign(
                duration: Duration(milliseconds: 350),
                alignment: AlignmentDirectional.centerStart,
                child: BreathworkSegment(),
              ),
              const SizedBox(height: 20),
              const ActualStage(),
            ],
          ),
        ),
      ),
    );
  }
}
