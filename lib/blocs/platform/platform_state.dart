part of 'platform_cubit.dart';

enum PlatformType { web, iOS, android, macOS, fuchsia, linux, windows, unknown }

class PlatformState extends Equatable {
  const PlatformState({required this.platformType});

  factory PlatformState.initial() =>
      const PlatformState(platformType: PlatformType.unknown);
  final PlatformType platformType;

  @override
  List<Object?> get props => [platformType];

  PlatformState copyWith(PlatformType platformType) =>
      PlatformState(platformType: platformType);

  @override
  String toString() => 'PlatformState(platformType: $platformType)';

  String enumToString() =>
      platformType.toString().split('.').last.split(')').first.toUpperCase();

  TargetPlatform get targetPlatform {
    if (platformType == PlatformType.web) return TargetPlatform.macOS;
    if (platformType == PlatformType.macOS) return TargetPlatform.macOS;
    if (platformType == PlatformType.fuchsia) return TargetPlatform.fuchsia;
    if (platformType == PlatformType.linux) return TargetPlatform.linux;
    if (platformType == PlatformType.windows) return TargetPlatform.windows;
    if (platformType == PlatformType.iOS) return TargetPlatform.iOS;
    if (platformType == PlatformType.android) return TargetPlatform.android;
    return TargetPlatform.android;
  }
}
