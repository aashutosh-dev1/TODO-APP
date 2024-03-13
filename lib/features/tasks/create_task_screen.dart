import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tasker/core/extensions/app_theme_extensions.dart';
import 'package:tasker/core/utils/priority_utils.dart';
import 'package:tasker/domain/entities/task.dart';
import 'package:tasker/features/home/bloc/home_bloc.dart';
import 'package:tasker/widgets/custom_app_button.dart';
import 'package:tasker/widgets/label_dropdown_widget.dart';
import 'package:tasker/widgets/label_text_form_field.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  final labelController = TextEditingController();
  final descriptionController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  String? val;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            )),
        title: Text(
          'Create task',
          style: context.textTheme.headlineMedium?.copyWith(
            color: context.colorScheme.background,
          ),
        ),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.insertTasksStatus == InsertTasksStatus.success) {
            context.pop();
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  LabelTextFormField(
                    key: Key('title'),
                    textFieldController: labelController,
                    label: 'Title',
                    hintText: 'Enter title',
                    textFieldType: TextFieldType.text,
                    isLabelBold: true,
                  ),
                  const Gap(16),
                  LabelTextFormField(
                    key: Key('description'),
                    textFieldController: descriptionController,
                    label: 'Description',
                    hintText: 'Enter description',
                    textFieldType: TextFieldType.text,
                    maxLines: 3,
                    isLabelBold: true,
                  ),
                  const Gap(16),
                  LabelDropdownWidget(
                    key: Key('drop-down'),
                    label: 'Priority',
                    hint: 'Select Priority',
                    items: const ['High', 'Medium', 'Low'],
                    value: val,
                    onChanged: (p0) {
                      setState(() {
                        val = p0;
                      });
                    },
                    isLabelBold: true,
                  ),
                  const Gap(16),
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      return CustomAppButton(
                        key: Key('submit'),
                        width: double.infinity,
                        isLoading: state.insertTasksStatus ==
                            InsertTasksStatus.loading,
                        buttonLabel: 'Submit',
                        buttonType: ButtonType.primary,
                        onButtonPressed: () {
                          if (_formkey.currentState!.validate()) {
                            final lastLastID = state.tasksList.isEmpty
                                ? 0
                                : state.tasksList.last.id;

                            var id = lastLastID + 1;

                            final task = Task(
                              id: id,
                              label: labelController.text.trim(),
                              description: descriptionController.text.trim(),
                              priority: PriorityUtils.getPriorityValue(
                                  val!.toLowerCase()),
                              isCompleted: 0,
                            );

                            context
                                .read<HomeBloc>()
                                .add(InsertTaskEvent(task: task));
                          }
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
