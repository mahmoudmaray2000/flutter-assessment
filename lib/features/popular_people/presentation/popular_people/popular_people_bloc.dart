import 'package:bloc/bloc.dart';

import 'popular_people_event.dart';
import 'popular_people_state.dart';

class PopularPeopleBloc extends Bloc<PopularPeopleEvent, PopularPeopleState> {
  PopularPeopleBloc() : super(PopularPeopleState().init()) {
    on<InitEvent>(_init);
  }

  void _init(InitEvent event, Emitter<PopularPeopleState> emit) async {
    emit(state.clone());
  }
}
