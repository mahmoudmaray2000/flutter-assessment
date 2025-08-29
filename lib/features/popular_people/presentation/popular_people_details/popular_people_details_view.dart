import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assessment/features/popular_people/data/responses/popular_people_response/popular_people_data.dart';
import 'package:flutter_assessment/features/popular_people/popular_people_injector.dart';
import 'package:flutter_assessment/features/popular_people/presentation/popular_people_details/component/details_item.dart';
import 'package:flutter_assessment/features/popular_people/presentation/popular_people_details/component/full_screenI_image_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'popular_people_details_bloc.dart';
import 'popular_people_details_event.dart';
import 'popular_people_details_state.dart';

class PopularPeopleDetailsPage extends StatelessWidget {
  final int personId;
  final List<PopularPeopleData> images;

  const PopularPeopleDetailsPage({
    super.key,
    required this.personId,
    this.images = const [],
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PopularPeopleModule.createPopularPeopleDetailsBloc()
        ..add(FetchPopularPeopleDetailsEvent(personId: personId)),
      child: Scaffold(
        appBar: AppBar(title: const Text('Person Details')),
        body: BlocConsumer<PopularPeopleDetailsBloc, PopularPeopleDetailsState>(
          listener: _handleStateListener,
          buildWhen: (previous, current) =>
          current is! ImageDownloadSuccessState &&
              current is! ImageDownloadErrorState,
          builder: (context, state) {
            if (state is PopularPeopleDetailsLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PopularPeopleDetailsLoadedState) {
              return DetailsContent(details: state.details, images: images);
            } else if (state is PopularPeopleDetailsErrorState) {
              return Center(child: Text(state.errorMessage));
            }
            return const Center(child: Text('No details available'));
          },
        ),
      ),
    );
  }

  void _handleStateListener(BuildContext context, PopularPeopleDetailsState state) {
    if (state is ImageDownloadSuccessState) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image saved Successfully')),
      );
    } else if (state is ImageDownloadErrorState) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to download image: ${state.errorMessage}'),
        ),
      );
    }
  }
}



