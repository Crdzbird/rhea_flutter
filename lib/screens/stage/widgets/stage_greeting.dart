import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rhea_app/blocs/profile/profile_bloc.dart';
import 'package:rhea_app/l10n/l10n.dart';
import 'package:rhea_app/repositories/network/remote/data_source/profile/implementation/profile_implementation.dart';
import 'package:rhea_app/styles/color.dart';
import 'package:shimmer/shimmer.dart';

class StageGreeting extends StatelessWidget {
  const StageGreeting({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider<ProfileBloc>(
        create: (_) => ProfileBloc(
          profileImplementation: context.read<ProfileImplementation>(),
        ),
        child: const AnimatedAlign(
          duration: Duration(milliseconds: 350),
          alignment: AlignmentDirectional.centerStart,
          child: _StageGreeting(),
        ),
      );
}

class _StageGreeting extends StatelessWidget {
  const _StageGreeting();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state == OnIdleProfile() || state == OnLoadingProfile()) {
          return Shimmer.fromColors(
            baseColor: biscay,
            highlightColor: turquoise,
            child: RichText(
              text: TextSpan(
                text: l10n.hey,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: biscay,
                    ),
                children: [
                  const TextSpan(text: '\n'),
                  TextSpan(
                    text: l10n.load,
                    style: Theme.of(context).textTheme.displayLarge?.copyWith(
                          color: turquoise,
                        ),
                  ),
                ],
              ),
            ),
          );
        }
        return RichText(
          text: TextSpan(
            text: l10n.hey,
            style: Theme.of(context).textTheme.displayLarge?.copyWith(
                  color: biscay,
                ),
            children: [
              const TextSpan(text: '\n'),
              TextSpan(
                text: (context.read<ProfileBloc>().state as OnSuccessProfile)
                    .profile
                    .firstName,
                style: Theme.of(context).textTheme.displayLarge?.copyWith(
                      color: turquoise,
                    ),
              ),
            ],
          ),
        );
      },
    );
  }
}
