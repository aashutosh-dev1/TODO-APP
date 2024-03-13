import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tasker/app_router.dart';
import 'package:tasker/core/extensions/app_theme_extensions.dart';
import 'package:tasker/core/utils/completed_utils.dart';
import 'package:tasker/core/utils/priority_utils.dart';
import 'package:tasker/features/home/bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Just Do It',
          style: context.textTheme.headlineMedium?.copyWith(
            color: context.colorScheme.background,
          ),
        ),
        actions: [
          IconButton(
            key: const Key('create-navigate-button'),
            icon: Icon(
              Icons.add,
              color: context.colorScheme.background,
            ),
            onPressed: () => context.push(AppRouter.taskCreate),
          )
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          log(state.fetchTasksStatus.toString());
          switch (state.fetchTasksStatus) {
            case FetchTasksStatus.initial:
              return const Center(child: CircularProgressIndicator());
            case FetchTasksStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case FetchTasksStatus.failed:
              return const Center(child: Text('Failed to load tasks'));
            case FetchTasksStatus.success:
              final tasks = state.tasksList;
              return tasks.isEmpty
                  ? const Center(child: Text('No tasks yet :/'))
                  : ListView.separated(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: tasks.length,
                      padding: const EdgeInsets.all(16),
                      separatorBuilder: (context, index) => const Gap(16),
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          if (selectedIndex != index) {
                            setState(() {
                              selectedIndex = index;
                            });
                          } else {
                            setState(() {
                              selectedIndex = -1;
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16, horizontal: 8),
                          decoration: BoxDecoration(
                            color: context.colorScheme.background,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 3,
                                offset: const Offset(0, 5),
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width /
                                        2.15,
                                    child: Text(
                                      tasks[index].label,
                                      style: context.textTheme.titleMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color: PriorityUtils.getPriorityColor(
                                              tasks[index].priority),
                                        ),
                                        child: Text(
                                          PriorityUtils.getPriorityLabel(
                                              tasks[index].priority),
                                          style: context.textTheme.labelSmall,
                                        ),
                                      ),
                                      const Gap(8),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4, horizontal: 8),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          color:
                                              CompletedUtils.getCompletedColor(
                                                  tasks[index].isCompleted),
                                        ),
                                        child: Text(
                                          CompletedUtils.getCompletedLabel(
                                              tasks[index].isCompleted),
                                          style: context.textTheme.labelSmall,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const Gap(8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      tasks[index].description,
                                      style: context.textTheme.bodyMedium,
                                    ),
                                  ),
                                  const Gap(10.0),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                                255, 113, 150, 214)
                                            .withOpacity(0.1),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        selectedIndex == index
                                            ? Icons.keyboard_arrow_up_outlined
                                            : Icons
                                                .keyboard_arrow_down_outlined,
                                        color: context.colorScheme.primary,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Gap(8),
                              AnimatedContainer(
                                height: selectedIndex == index ? 50 : 0,
                                duration: const Duration(milliseconds: 200),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: List.generate(
                                    3,
                                    (idx) => InkWell(
                                      onTap: () {
                                        if (idx == 0) {
                                          context.read<HomeBloc>().add(
                                              DeleteTaskEvent(
                                                  id: tasks[index].id));
                                          setState(() {
                                            selectedIndex = -1;
                                          });
                                        } else if (idx == 1) {
                                          setState(() {
                                            selectedIndex = -1;
                                          });
                                          context
                                              .push(AppRouter.taskEdit, extra: {
                                            'task': tasks[index],
                                          });
                                        } else {
                                          context.read<HomeBloc>().add(
                                              CompleteTaskEvent(
                                                  id: tasks[index].id));
                                          setState(() {
                                            selectedIndex = -1;
                                          });
                                        }
                                      },
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3.5,
                                        child: Row(
                                          children: [
                                            if (selectedIndex == index)
                                              Icon(
                                                idx == 0
                                                    ? Icons.delete
                                                    : idx == 1
                                                        ? Icons.edit
                                                        : Icons.check,
                                                color: idx == 0
                                                    ? context.colorScheme.error
                                                    : idx == 1
                                                        ? Colors.amber
                                                        : Colors.green,
                                              ),
                                            const Gap(8),
                                            Text(
                                              idx == 0
                                                  ? 'Delete'
                                                  : idx == 1
                                                      ? 'Edit'
                                                      : 'Complete',
                                              style: context
                                                  .textTheme.labelLarge
                                                  ?.copyWith(
                                                color: idx == 0
                                                    ? context.colorScheme.error
                                                    : idx == 1
                                                        ? Colors.amber
                                                        : Colors.green,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
          }
        },
      ),
    );
  }
}
