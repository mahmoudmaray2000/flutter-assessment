import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assessment/features/popular_people/data/responses/popular_people_response/popular_people_data.dart';
import 'package:flutter_assessment/features/popular_people/popular_people_injector.dart';
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
      create: (context) =>
      PopularPeopleModule.createPopularPeopleDetailsBloc(),
      child: Builder(
        builder: (context) {
          context.read<PopularPeopleDetailsBloc>().add(
            FetchPopularPeopleDetailsEvent(personId: personId),
          );
          return Scaffold(
            appBar: AppBar(title: const Text('Person Details')),
            body: BlocBuilder<PopularPeopleDetailsBloc, PopularPeopleDetailsState>(
              builder: (context, state) {
                if (state is PopularPeopleDetailsLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PopularPeopleDetailsLoadedState) {
                  final details = state.details;
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        if (details.profilePath != null)
                          CachedNetworkImage(
                            imageUrl:
                            "https://image.tmdb.org/t/p/w500${details.profilePath}",
                            width: double.infinity,
                            height: 300,
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                          )
                        else
                          const Center(child: Text('No image available')),
                        const SizedBox(height: 16),
                        Text(
                          details.name!,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(details.biography ?? 'No biography available'),
                        const SizedBox(height: 16),
                        Text(
                          'Images',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        images.isNotEmpty
                            ? GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: images.length,
                          itemBuilder: (context, index) {
                            final imageUrl =
                                "https://image.tmdb.org/t/p/w500${images[index].backdropPath}";
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        FullScreenImagePage(imageUrl: imageUrl),
                                  ),
                                );
                              },
                              child: Hero(
                                tag: imageUrl,
                                child: CachedNetworkImage(
                                  imageUrl: imageUrl,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                  const Center(child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                                ),
                              ),
                            );
                          },
                        )
                            : const Center(child: Text('No images available')),
                      ],
                    ),
                  );
                } else if (state is PopularPeopleDetailsErrorState) {
                  return Center(child: Text(state.errorMessage));
                } else {
                  return const Center(child: Text('No details available'));
                }
              },
            ),
          );
        }
      ),
    );
  }
}