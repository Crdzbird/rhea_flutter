import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rhea_app/l10n/l10n.dart';
import 'package:rhea_app/navigation/routes.dart';
import 'package:rhea_app/shared/widgets/solid_button.dart';
import 'package:rhea_app/styles/color.dart';
import 'package:rhea_app/utils/constants.dart';

class AuthenticationView extends StatelessWidget {
  const AuthenticationView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(backgroundColor, BlendMode.srcOver),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SvgPicture.asset(
              'assets/svg/ic_rhea_letters.svg',
              width: MediaQuery.of(context).size.width * 0.25,
              height: MediaQuery.of(context).size.width * 0.25,
            ),
            Text(
              l10n.titleDescription,
              style: Theme.of(context).textTheme.displayMedium,
              textAlign: TextAlign.center,
            ),
            Column(
              children: [
                SolidButton(
                  leading: SvgPicture.asset(
                    'assets/svg/ic_google.svg',
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  title: Text(
                    l10n.google,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 19,
                        ),
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
                  background: pictonBlue,
                  onPressed: () {},
                ),
                SolidButton(
                  leading: SvgPicture.asset(
                    'assets/svg/ic_apple.svg',
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  title: Text(
                    l10n.apple,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 19,
                        ),
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
                    top: 6,
                  ),
                  background: black,
                  onPressed: () {},
                ),
                SolidButton(
                  leading: SvgPicture.asset(
                    'assets/svg/ic_email.svg',
                    width: MediaQuery.of(context).size.width * 0.05,
                  ),
                  title: Text(
                    l10n.email,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 19,
                        ),
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
                    top: 6,
                  ),
                  background: turquoise,
                  onPressed: () => routemasterDelegate.push('email'),
                ),
              ],
            ),
            RichText(
              text: TextSpan(
                text: l10n.tryingJoinRhea,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontFamily: 'polar',
                      fontWeight: FontWeight.bold,
                    ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => routemasterDelegate.push(
                        'rheaWebView',
                        queryParameters: {'url': rheaWebpage},
                      ),
                children: [
                  const TextSpan(text: ' '),
                  TextSpan(
                    text: l10n.tryingJoinRheaDescription,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: botticelli,
                          fontFamily: 'polar',
                        ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
