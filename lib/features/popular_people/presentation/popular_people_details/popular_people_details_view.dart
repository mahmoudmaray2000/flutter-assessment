import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'popular_people_details_bloc.dart';
import 'popular_people_details_event.dart';
import 'popular_people_details_state.dart';

class PopularPeopleDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => PopularPeopleDetailsBloc()..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<PopularPeopleDetailsBloc>(context);

    return Container();
  }
}

