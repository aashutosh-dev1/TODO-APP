import 'package:flutter/material.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tasker/domain/entities/task.dart';
import 'package:tasker/features/home/bloc/home_bloc.dart';
import 'package:tasker/features/home/home_screen.dart';

class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

class MockHomeState extends Fake implements HomeState {}

class MockHomeEvent extends Fake implements HomeEvent {}

void main() {
  group('Widget Test', () {
    late final HomeBloc homeBloc;

    setUpAll(() {
      TestWidgetsFlutterBinding.ensureInitialized();

      registerFallbackValue(MockHomeState());
      registerFallbackValue(MockHomeEvent());

      homeBloc = MockHomeBloc();
    });

    testWidgets("Show all tasks", (tester) async {
      when(() => homeBloc.state).thenAnswer(
        (invocation) => HomeState(
          fetchTasksStatus: FetchTasksStatus.success,
          tasksList: [
            Task(
              id: 1,
              label: 'test',
              description: 'desc',
              priority: 2,
              isCompleted: 0,
            ),
          ],
        ),
      );

      await tester.pumpWidget(
        BlocProvider(
          create: (context) => homeBloc,
          child: const MaterialApp(
            home: HomeScreen(),
          ),
        ),
      );

      expect(find.text('test'), findsOneWidget);

      when(() => homeBloc.state).thenAnswer((invocation) => HomeState(
            fetchTasksStatus: FetchTasksStatus.success,
            tasksList: [
              Task(
                id: 1,
                label: 'test',
                description: 'desc',
                priority: 2,
                isCompleted: 0,
              ),
              Task(
                id: 2,
                label: 'label',
                description: 'description',
                priority: 1,
                isCompleted: 0,
              ),
            ],
          ));

      homeBloc.add(InsertTaskEvent(
        task: Task(
          id: 2,
          label: 'label',
          description: 'description',
          priority: 1,
          isCompleted: 0,
        ),
      ));

      await expectLater(homeBloc.state.tasksList.last.label, 'label');
    });
  });
}
