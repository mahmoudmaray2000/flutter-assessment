import 'package:flutter/material.dart';
import 'package:flutter_assessment/features/popular_people/popular_people_injector.dart';
import 'package:flutter_assessment/features/popular_people/presentation/popular_people/component/popular_people_list_item.dart';
import 'package:flutter_assessment/features/popular_people/presentation/popular_people_details/popular_people_details_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'popular_people_bloc.dart';
import 'popular_people_event.dart';
import 'popular_people_state.dart';

class PopularPeoplePage extends StatelessWidget {
  const PopularPeoplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PopularPeopleModule.createPopularPeopleBloc(),
      child: Builder(
        builder: (context) {
          context.read<PopularPeopleBloc>().add(
            FetchPopularPeopleEvent(page: 1),
          );
          return Scaffold(
            appBar: AppBar(title: const Text('Popular People')),
            body: BlocBuilder<PopularPeopleBloc, PopularPeopleState>(
              builder: (context, state) {
                if (state is PopularPeopleLoadingState && state.page == 1) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PopularPeopleLoadedState) {
                  return NotificationListener<ScrollNotification>(
                    onNotification: (notification) {
                      if (notification is ScrollEndNotification &&
                          notification.metrics.pixels >=
                              notification.metrics.maxScrollExtent - 100) {
                        if (state.hasMore && !state.isLoadingMore) {
                          context.read<PopularPeopleBloc>().add(
                            LoadMorePopularPeopleEvent(),
                          );
                        }
                      }
                      return false;
                    },
                    child: ListView.builder(
                      cacheExtent: 250,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      itemCount:
                          state.popularPeople.length +
                          (state.isLoadingMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index < state.popularPeople.length) {
                          final person = state.popularPeople[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PopularPeopleDetailsPage(
                                        personId: person.id!,
                                        images: person.knownFor!,
                                      ),
                                ),
                              );
                            },
                            child: PopularPeopleListItem(
                              person: person,
                              key: ValueKey(person.id),
                            ),
                          );
                        } else {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }
                      },
                    ),
                  );
                } else if (state is PopularPeopleErrorState) {
                  return Center(child: Text(state.errorMessage));
                } else {
                  return const Center(child: Text('No data available'));
                }
              },
            ),
          );
        },
      ),
    );
  }
}
