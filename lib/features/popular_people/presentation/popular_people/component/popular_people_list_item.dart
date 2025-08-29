import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assessment/features/popular_people/domain/entity/popular_people_entity.dart';


class PopularPeopleListItem extends StatelessWidget {
  final PopularPeopleEntity person;

  const PopularPeopleListItem({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading:ClipOval(
          child: person.profilePath != null
              ? CachedNetworkImage(
            imageUrl: "https://image.tmdb.org/t/p/w500${person.profilePath}",
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          )
              : CircleAvatar(),
        ),
        title: Text(person.name!),
        subtitle: Text(person.knownForDepartment??""),
      ),
    );
  }
}
