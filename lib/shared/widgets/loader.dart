import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) => const Center(
        child: Padding(
          padding: EdgeInsetsDirectional.only(top: 10, bottom: 10),
          child: SizedBox(
            height: 25,
            width: 25,
            child: CircularProgressIndicator.adaptive(),
          ),
        ),
      );
}
