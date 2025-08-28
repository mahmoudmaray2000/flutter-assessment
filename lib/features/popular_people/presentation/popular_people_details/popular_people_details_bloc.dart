import 'package:bloc/bloc.dart';

import 'popular_people_details_event.dart';
import 'popular_people_details_state.dart';

class PopularPeopleDetailsBloc extends Bloc<PopularPeopleDetailsEvent, PopularPeopleDetailsState> {
  PopularPeopleDetailsBloc() : super(PopularPeopleDetailsState().init()) {
    on<InitEvent>(_init);
  }

  void _init(InitEvent event, Emitter<PopularPeopleDetailsState> emit) async {
    emit(state.clone());
  }
}
