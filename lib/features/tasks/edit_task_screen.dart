import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:tasker/core/extensions/app_theme_extensions.dart';
import 'package:tasker/core/utils/completed_utils.dart';
import 'package:tasker/core/utils/priority_utils.dart';
import 'package:tasker/domain/entities/task.dart';
import 'package:tasker/features/home/bloc/home_bloc.dart';
import 'package:tasker/widgets/custom_app_button.dart';
import 'package:tasker/widgets/label_dropdown_widget.dart';
import 'package:tasker/widgets/label_text_form_field.dart';

class EditTaskScreen extends StatefulWidget {
  const EditTaskScreen({super.key, required this.task});

  final Task task;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  final labelController = TextEditingController();
  final descriptionController = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  String? priorityVal;
  String? completedVal;

  @override
  void initState() {
    super.initState();
    labelController.text = widget.task.label;
    descriptionController.text = widget.task.description;
    priorityVal = PriorityUtils.getPriorityLabel(widget.task.priority);
    completedVal = CompletedUtils.getCompletedLabel(widget.task.isCompleted);
  }

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
          'Edit task',
          style: context.textTheme.headlineMedium?.copyWith(
            color: context.colorScheme.background,
          ),
        ),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.editTasksStatus == EditTasksStatus.success) {
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
                    textFieldController: labelController,
                    label: 'Title',
                    hintText: 'Enter title',
                    textFieldType: TextFieldType.text,
                    isLabelBold: true,
                  ),
                  const Gap(16),
                  LabelTextFormField(
                    textFieldController: descriptionController,
                    label: 'Description',
                    hintText: 'Enter description',
                    textFieldType: TextFieldType.text,
                    maxLines: 3,
                    isLabelBold: true,
                  ),
                  const Gap(16),
                  LabelDropdownWidget(
                    label: 'Priority',
                    hint: 'Select Priority',
                    items: const ['High', 'Medium', 'Low'],
                    value: priorityVal,
                    onChanged: (p0) {
                      setState(() {
                        priorityVal = p0;
                      });
                    },
                    isLabelBold: true,
                  ),
                  const Gap(16),
                  LabelDropdownWidget(
                    label: 'Completed',
                    hint: 'is completed?',
                    items: const ['Incomplete', 'Completed'],
                    value: completedVal,
                    onChanged: (p0) {
                      setState(() {
                        completedVal = p0;
                      });
                    },
                    isLabelBold: true,
                  ),
                  const Gap(16),
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      return CustomAppButton(
                        width: double.infinity,
                        isLoading: state.insertTasksStatus ==
                            InsertTasksStatus.loading,
                        buttonLabel: 'Submit',
                        buttonType: ButtonType.primary,
                        onButtonPressed: () {
                          if (_formkey.currentState!.validate()) {
                            final task = Task(
                              id: widget.task.id,
                              label: labelController.text.trim(),
                              description: descriptionController.text.trim(),
                              priority: PriorityUtils.getPriorityValue(
                                  priorityVal!.toLowerCase()),
                              isCompleted: CompletedUtils.getCompletedValue(
                                  completedVal!.toLowerCase()),
                            );

                            context
                                .read<HomeBloc>()
                                .add(EditTaskEvent(task: task));
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
