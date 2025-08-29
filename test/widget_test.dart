import 'package:flutter/material.dart';
import 'package:flutter_assessment/features/popular_people/popular_people_injector.dart';
import 'package:flutter_assessment/injection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_assessment/features/popular_people/presentation/popular_people/popular_people_view.dart';
import 'package:flutter_assessment/features/popular_people/domain/entity/popular_people_entity.dart';
import 'package:flutter_assessment/features/popular_people/presentation/popular_people/component/popular_people_list_item.dart';

void main() async{
  TestWidgetsFlutterBinding.ensureInitialized();
  await Injector.init();
  PopularPeopleModule.init();


  Widget wrap(Widget child) => MaterialApp(home: Scaffold(body: child));

  group('PopularPeoplePage (UI-only smoke)', () {
    testWidgets('renders AppBar title', (tester) async {
      await tester.pumpWidget(MaterialApp(home: const PopularPeoplePage()));
      await tester.pump();
      expect(find.text('Popular People'), findsOneWidget);
    });
  });

  group('PopularPeopleListItem (component UI)', () {
    testWidgets('renders a person name', (tester) async {
      final p = PopularPeopleEntity(
        id: 1,
        name: 'Person 1',
        profilePath: '',
        knownFor: const [],
      );

      await tester.pumpWidget(
        wrap(
          Column(
            children: [
              PopularPeopleListItem(
                key: const ValueKey(1),
                person: p,
              ),
            ],
          ),
        ),
      );
      await tester.pump();
      expect(find.text('Person 1'), findsOneWidget);
    });

    testWidgets('renders multiple items', (tester) async {
      final people = [
        PopularPeopleEntity(id: 1, name: 'Person 1', profilePath: '', knownFor: const []),
        PopularPeopleEntity(id: 2, name: 'Person 2', profilePath: '', knownFor: const []),
      ];

      await tester.pumpWidget(
        wrap(
          Column(
            children: [
              for (final p in people)
                PopularPeopleListItem(
                  key: ValueKey(p.id),
                  person: p,
                ),
            ],
          ),
        ),
      );
      await tester.pump();
      expect(find.text('Person 1'), findsOneWidget);
      expect(find.text('Person 2'), findsOneWidget);
    });
  });
}
