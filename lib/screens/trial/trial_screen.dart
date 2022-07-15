import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rhea_app/l10n/l10n.dart';
import 'package:rhea_app/navigation/routes.dart';
import 'package:rhea_app/styles/color.dart';
import 'package:rhea_app/utils/constants.dart';

class TrialScreen extends StatelessWidget {
  const TrialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/trial_background.jpeg'),
            colorFilter:
                ColorFilter.mode(trialBackgroundColor, BlendMode.srcOver),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svg/ic_rhea.svg',
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.width * 0.15,
            ),
            Padding(
              padding:
                  const EdgeInsetsDirectional.only(start: 20, end: 20, top: 30),
              child: RichText(
                text: TextSpan(
                  text: l10n.trial_app,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                  children: [
                    const TextSpan(text: ' '),
                    TextSpan(
                      text: l10n.trial_not_available,
                      style:
                          Theme.of(context).textTheme.displayMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: persimmom,
                              ),
                    ),
                    const TextSpan(text: ' '),
                    TextSpan(
                      text: l10n.trial_subscription,
                      style:
                          Theme.of(context).textTheme.displayMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                    ),
                  ],
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => routemasterDelegate.push(
                          'rheaWebView',
                          queryParameters: {'url': rheaWebpage},
                        ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsetsDirectional.only(start: 20, end: 20, top: 15),
              child: Text(
                l10n.trial_detail,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
