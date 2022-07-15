import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rhea_app/blocs/authentication/authentication_bloc.dart';
import 'package:rhea_app/l10n/l10n.dart';
import 'package:rhea_app/shared/widgets/password_widget.dart';
import 'package:rhea_app/shared/widgets/solid_button.dart';
import 'package:rhea_app/shared/widgets/textform_component.dart';
import 'package:rhea_app/styles/color.dart';

class EmailView extends StatelessWidget {
  const EmailView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: Form(
        key: context.select((AuthenticationBloc bloc) => bloc.formKey),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                SvgPicture.asset('assets/svg/ic_rhea.svg'),
                const SizedBox(height: 35),
                Text(
                  l10n.welcome_back,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: biscay,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                TextFormComponent(
                  contentPadding: const EdgeInsetsDirectional.only(
                    start: 25,
                    end: 25,
                    top: 15,
                    bottom: 15,
                  ),
                  width: MediaQuery.of(context).size.width * 0.8,
                  inputStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: biscay,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                  titlePadding: const EdgeInsetsDirectional.only(start: 20),
                  radius: 50,
                  controller: context.select(
                    (AuthenticationBloc bloc) => bloc.usernameController,
                  ),
                  validator: context.select(
                    (AuthenticationBloc bloc) => bloc.checkEmail,
                  ),
                  title: l10n.email_hint,
                  titleStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: hoki,
                        fontFamily: 'Kansas',
                        fontWeight: FontWeight.w600,
                      ),
                  titleColor: biscay,
                  shadowElevation: 0,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                PasswordWidget(
                  controller: context.select(
                    (AuthenticationBloc bloc) => bloc.passwordController,
                  ),
                  validator: context.select(
                    (AuthenticationBloc bloc) => bloc.checkPassword,
                  ),
                ),
              ],
            ),
            SolidButton(
              title: Text(
                l10n.login,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 19,
                    ),
                textAlign: TextAlign.center,
              ),
              borderRadius: 50,
              buttonPadding: const EdgeInsetsDirectional.only(
                top: 3,
                bottom: 3,
                start: 20,
              ),
              padding: const EdgeInsetsDirectional.only(
                start: 25,
                end: 25,
                bottom: 6,
              ),
              background: turquoise,
              isLoading: context.select((AuthenticationBloc bloc) => bloc.state)
                  is OnLoadingAuthentication,
              disabledBackground: linkWater,
              onPressed: () =>
                  context.read<AuthenticationBloc>().sendCredentials(),
            ),
          ],
        ),
      ),
    );
  }
}
