import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rhea_app/blocs/password/password_cubit.dart';
import 'package:rhea_app/l10n/l10n.dart';
import 'package:rhea_app/shared/widgets/textform_component.dart';
import 'package:rhea_app/styles/color.dart';

class PasswordWidget extends StatelessWidget {
  const PasswordWidget({super.key, required this.controller, this.validator});
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => PasswordCubit(),
        child: _PasswordVisibilityWidget(controller, validator),
      );
}

class _PasswordVisibilityWidget extends StatelessWidget {
  const _PasswordVisibilityWidget(this.controller, this.validator);
  final TextEditingController controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return TextFormComponent(
      contentPadding: const EdgeInsetsDirectional.only(
        start: 25,
        end: 25,
        top: 15,
        bottom: 15,
      ),
      width: MediaQuery.of(context).size.width * 0.8,
      radius: 50,
      titlePadding: const EdgeInsetsDirectional.only(start: 20),
      controller: controller,
      inputStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: biscay,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
      title: l10n.password_hint,
      titleStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
            color: hoki,
            fontFamily: 'Kansas',
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
      titleColor: biscay,
      shadowElevation: 0,
      keyboardType: TextInputType.visiblePassword,
      validator: validator,
      obscureText: !context.select((PasswordCubit cubit) => cubit.state),
      suffixIcon: IconButton(
        padding: const EdgeInsetsDirectional.only(end: 5),
        icon: SvgPicture.asset(
          context.select((PasswordCubit cubit) => cubit.state)
              ? 'assets/svg/ic_eye_open.svg'
              : 'assets/svg/ic_eye_close.svg',
          width: MediaQuery.of(context).size.width * 0.05,
          height: MediaQuery.of(context).size.width * 0.05,
          color: biscay, //boticcelly empty
        ),
        onPressed: () => context.read<PasswordCubit>().change(),
      ),
    );
  }
}
