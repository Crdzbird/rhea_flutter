import 'package:flutter/material.dart';
import 'package:rhea_app/l10n/l10n.dart';

import 'package:rhea_app/styles/color.dart';

class RowFlow<T> extends StatelessWidget {
  const RowFlow({
    super.key,
    required this.items,
    this.alignment = WrapAlignment.center,
    this.spacing = 8,
    this.runSpacing = 8,
  });
  final List<T> items;
  final WrapAlignment alignment;
  final double spacing;
  final double runSpacing;

  @override
  Widget build(BuildContext context) => Wrap(
        alignment: alignment,
        spacing: spacing,
        runSpacing: runSpacing,
        children: [
          if (items.isEmpty)
            Chip(
              label: Padding(
                padding: const EdgeInsetsDirectional.only(
                  start: 30,
                  end: 30,
                  top: 15,
                  bottom: 15,
                ),
                child: Text(
                  context.l10n.none,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: biscay,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              backgroundColor: albescentWhiteOpacity,
            )
          else
            ...items.map(
              (e) => Chip(
                label: Padding(
                  padding: const EdgeInsetsDirectional.only(
                    start: 30,
                    end: 30,
                    top: 15,
                    bottom: 15,
                  ),
                  child: Text(
                    '$e',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: biscay,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                backgroundColor: albescentWhiteOpacity,
              ),
            )
        ],
      );
}
