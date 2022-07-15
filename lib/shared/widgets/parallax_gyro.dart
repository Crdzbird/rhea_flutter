import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rhea_app/styles/color.dart';
import 'package:sensors_plus/sensors_plus.dart';

///Create a Parallax effect by the values of gyroscope values
///
///[elevation] changes the background size to appears be more far away
///
///[intensity] multiplies gyro sensors value
class ParallaxGyro extends StatefulWidget {
  const ParallaxGyro({
    super.key,
    required this.image,
    this.height = 100,
    this.width = 100,
    this.elevation = 1,
    this.intensity = 1,
  });
  final ImageProvider image;
  final double height;
  final double width;
  final double intensity;
  final double elevation;

  @override
  State<ParallaxGyro> createState() => _ParallaxGyroState();
}

class _ParallaxGyroState extends State<ParallaxGyro> {
  double initX = 0, initY = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          StreamBuilder<GyroscopeEvent>(
            stream: SensorsPlatform.instance.gyroscopeEvents,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.y.abs() > 0.0) {
                  initX = initX + (snapshot.data!.y);
                }
                if (snapshot.data!.x.abs() > 0.0) {
                  initY = initY + (snapshot.data!.x);
                }
              }
              return Positioned(
                left: 10 - (initX * widget.intensity),
                right: 10 + (initX * widget.intensity),
                top: 10 - (initY * widget.intensity),
                bottom: 10 + (initY * widget.intensity),
                child: Center(
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          width: widget.height - (widget.elevation * 10),
                          height: widget.width - (widget.elevation * 10),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              isAntiAlias: true,
                              opacity: 0.8,
                              image: widget.image,
                              colorFilter: ColorFilter.mode(
                                Colors.white.withOpacity(.1),
                                BlendMode.srcOver,
                              ),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: white.withOpacity(0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Positioned(
            left: 10,
            right: 10,
            top: 10,
            bottom: 10,
            child: Center(
              child: Container(
                width: widget.width,
                height: widget.height,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: .1),
                  image:
                      DecorationImage(image: widget.image, fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
