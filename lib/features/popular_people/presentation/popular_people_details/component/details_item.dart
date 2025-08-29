import 'package:flutter/material.dart';
import 'package:flutter_assessment/features/popular_people/data/responses/popular_people_response/popular_people_data.dart';
import 'package:flutter_assessment/features/popular_people/presentation/popular_people_details/component/images_grid_item.dart';
import 'package:flutter_assessment/features/popular_people/presentation/popular_people_details/component/profile_image_item.dart';
import 'package:flutter_assessment/features/popular_people/presentation/popular_people_details/popular_people_details_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsContent extends StatelessWidget {
  final dynamic details;
  final List<PopularPeopleData> images;
  const DetailsContent({super.key, required this.details, required this.images});
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PopularPeopleDetailsBloc>();
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          if (details.profilePath != null)
            Hero(
              tag: "https://image.tmdb.org/t/p/w500${details.profilePath}",
              child: ProfileImage(
                imageUrl:
                    "https://image.tmdb.org/t/p/w500${details.profilePath}",
                bloc: bloc,
              ),
            )
          else
            const Center(child: Text('No image available')),
          const SizedBox(height: 16),
          Text(
            details.name ?? 'Unknown',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 8),
          Text(details.biography ?? 'No biography available'),
          const SizedBox(height: 16),

          Text('Images', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),

          images.isNotEmpty
              ? ImagesGrid(images: images, bloc: bloc)
              : const Center(child: Text('No images available')),
        ],
      ),
    );
  }
}
