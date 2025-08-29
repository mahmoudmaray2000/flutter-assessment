import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assessment/features/popular_people/data/responses/popular_people_response/popular_people_data.dart';
import 'package:flutter_assessment/features/popular_people/presentation/popular_people_details/component/full_screenI_image_item.dart';
import 'package:flutter_assessment/features/popular_people/presentation/popular_people_details/popular_people_details_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImagesGrid extends StatelessWidget {
  final List<PopularPeopleData> images;
  final PopularPeopleDetailsBloc bloc;
  const ImagesGrid({super.key, required this.images, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        final imageUrl =
            "https://image.tmdb.org/t/p/w500${images[index].backdropPath}";
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: bloc,
                child: FullScreenImagePage(imageUrl: imageUrl),
              ),
            ),
          ),
          child: Hero(
            tag: imageUrl,
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              placeholder: (_, __) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (_, __, ___) => const Icon(Icons.error),
            ),
          ),
        );
      },
    );
  }
}
