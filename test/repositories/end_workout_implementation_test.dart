import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rhea_app/models/network/api_result.dart';
import 'package:rhea_app/models/network/network_exceptions.dart';
import 'package:rhea_app/models/reason.dart';

import '../mocks/shared_mocks.mocks.dart';

void main() {
  late MockEndWorkoutImplementation endWorkoutImplementation;

  setUp(() {
    endWorkoutImplementation = MockEndWorkoutImplementation();
  });

  test('EndWorkoutImplementation.Success', () async {
    when(
      endWorkoutImplementation.endWorkout(
        'workSession',
        const Reason(),
      ),
    ).thenAnswer(
      (_) async => const ApiResult.success(
        data: '200',
      ),
    );
    final result = await endWorkoutImplementation.endWorkout(
      'workSession',
      const Reason(),
    );
    result.when(
      success: (data) {
        expect(data, '200');
      },
      failure: (error, message) {},
    );
  });

  test('EndWorkoutImplementation.Failure', () async {
    when(
      endWorkoutImplementation.endWorkout(
        'workSession',
        const Reason(),
      ),
    ).thenAnswer(
      (_) async => const ApiResult.failure(
        error: NetworkExceptions.badRequest(),
        message: 'error',
      ),
    );
    final result = await endWorkoutImplementation.endWorkout(
      'workSession',
      const Reason(),
    );
    result.when(
      success: (data) {},
      failure: (error, message) {
        expect(error, const NetworkExceptions.badRequest());
        expect(message, 'error');
      },
    );
  });
}
