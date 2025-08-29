import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assessment/features/popular_people/presentation/popular_people_details/popular_people_details_bloc.dart';
import 'package:flutter_assessment/features/popular_people/presentation/popular_people_details/popular_people_details_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FullScreenImagePage extends StatelessWidget {
  final String imageUrl;

  const FullScreenImagePage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Viewer')),
      body: Center(
        child: Hero(
          tag: imageUrl,
          child: CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.contain,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<PopularPeopleDetailsBloc>().add(
            DownloadImageEvent(imageUrl: imageUrl),
          );
        },
        child: const Icon(Icons.download),
      ),
    );
  }
}
