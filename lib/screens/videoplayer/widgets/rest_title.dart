import 'package:flutter/material.dart';
import 'package:rhea_app/l10n/l10n.dart';

class RestTitle extends StatelessWidget {
  const RestTitle({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(
            context.l10n.rest,
            style: Theme.of(context).textTheme.displayLarge,
          ),
          Text(
            context.l10n.rest_description,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 20),
        ],
      );
}
