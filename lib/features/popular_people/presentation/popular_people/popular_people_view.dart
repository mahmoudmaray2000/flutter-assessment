import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'popular_people_bloc.dart';
import 'popular_people_event.dart';
import 'popular_people_state.dart';

class PopularPeoplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => PopularPeopleBloc()..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<PopularPeopleBloc>(context);

    return Container();
  }
}

