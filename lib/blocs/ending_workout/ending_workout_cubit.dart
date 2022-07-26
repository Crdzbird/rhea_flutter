import 'package:flutter_bloc/flutter_bloc.dart';

class EndingWorkoutCubit extends Cubit<String> {
  EndingWorkoutCubit() : super('');

  void change(String value) => emit(value);
}
