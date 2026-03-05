import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_texts_style.dart';
import '../ugc_home/ugc_task_details/ugc_task_model/ugc_sub_task_model.dart';

class UgcPersonalTaskScreen extends StatefulWidget {
  const UgcPersonalTaskScreen({super.key});

  @override
  State<UgcPersonalTaskScreen> createState() => _UgcPersonalTaskScreenState();
}

class _UgcPersonalTaskScreenState extends State<UgcPersonalTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();

  final List<UgcSubTask> _subTasks = [];
  final List<TextEditingController> _subtaskControllers = [];
  final List<FocusNode> _subtaskFocusNodes = [];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _dateTimeController.dispose();
    for (final controller in _subtaskControllers) {
      controller.dispose();
    }
    for (final node in _subtaskFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  Future<void> _selectDateTime() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryColor,
              onPrimary: AppColors.black,
              onSurface: AppColors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: AppColors.primaryColor),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && mounted) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: AppColors.primaryColor,
                onPrimary: AppColors.black,
                onSurface: AppColors.black,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(foregroundColor: AppColors.primaryColor),
              ),
            ),
            child: child!,
          );
        },
      );

      if (pickedTime != null && mounted) {
        setState(() {
          _dateTimeController.text =
          '${pickedDate.day}/${pickedDate.month}/${pickedDate.year} ${pickedTime.format(context)}';
        });
      }
    }
  }

  void _addNewSubTask() {
    setState(() {
      _subTasks.add(UgcSubTask(title: ''));
      _subtaskControllers.add(TextEditingController());
      _subtaskFocusNodes.add(FocusNode());
    });
  }

  void _removeSubTask(int index) {
    setState(() {
      _subtaskControllers[index].dispose();
      _subtaskFocusNodes[index].dispose();
      _subTasks.removeAt(index);
      _subtaskControllers.removeAt(index);
      _subtaskFocusNodes.removeAt(index);
    });
  }

  void _saveSubTask(int index) {
    setState(() {
      _subTasks[index] = _subTasks[index].copyWith(
        title: _subtaskControllers[index].text.trim(),
      );
      _subtaskFocusNodes[index].unfocus();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Subtask saved'),
        duration: Duration(seconds: 1),
        backgroundColor: Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        surfaceTintColor: AppColors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,),
          onPressed: () => Navigator.pop(context),
        ),
        title:  Text(
          'Create Task',
          style: AppTextStyles.smallHeading.copyWith(
              fontSize: 22
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add New Task',
                        style: AppTextStyles.largeHeading.copyWith(
                          fontSize: 30,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'You can add 3 to 5 more tasks today!',
                        style: AppTextStyles.smallText.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              /// Task Title
              Text('Task Title', style: AppTextStyles.smallHeading.copyWith(
                fontSize: 14
              )),
              const SizedBox(height: 12),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Type now',
                  hintStyle: AppTextStyles.defaultTextStyle,
                  filled: true,
                  fillColor: AppColors.backgroundColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.grey, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.grey, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.grey, width: 2),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
                cursorColor: AppColors.primaryColor,
                style: const TextStyle(color: Colors.black),
              ),
              const SizedBox(height: 24),

              // Task Description
              Text('Task Description', style: AppTextStyles.smallHeading.copyWith(
                  fontSize: 14
              )),
              const SizedBox(height: 12),
              TextField(
                controller: _descriptionController,
                maxLines: 4,
                cursorColor: AppColors.primaryColor,
                decoration: InputDecoration(
                  hintText: 'What needs your attention?',
                  hintStyle: AppTextStyles.defaultTextStyle,
                  filled: true,
                  fillColor: AppColors.backgroundColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.grey, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.grey, width: 1),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Task Date & Time
              Text('Task Date & Time', style: AppTextStyles.smallHeading.copyWith(
                  fontSize: 14
              )),
              const SizedBox(height: 12),
              TextField(
                controller: _dateTimeController,
                readOnly: true,
                onTap: _selectDateTime,
                decoration: InputDecoration(
                  hintText: '-- : -- --',
                  hintStyle: const TextStyle(color: AppColors.grey, fontSize: 15),
                  filled: true,
                  fillColor: AppColors.backgroundColor,
                  suffixIcon: const Icon(Icons.access_time, color: Color(0xFF6B7280)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.grey, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.grey, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.grey, width: 1),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Subtasks list - UPDATED TO MATCH EditTaskScreen
              ...List.generate(_subTasks.length, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.grey),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'Sub Task',
                                style: AppTextStyles.smallText.copyWith(
                                  color: AppColors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _subtaskControllers[index],
                                focusNode: _subtaskFocusNodes[index],
                                maxLines: null,
                                minLines: 1,
                                decoration: const InputDecoration(
                                  hintText: 'Enter Sub Task Details',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(color: AppColors.grey),
                                ),
                              ),
                            ),
                            ValueListenableBuilder<TextEditingValue>(
                              valueListenable: _subtaskControllers[index],
                              builder: (context, value, child) {
                                final hasFocus = _subtaskFocusNodes[index].hasFocus;
                                final hasText = value.text.isNotEmpty;

                                return IconButton(
                                  onPressed: () {
                                    if (hasFocus && hasText) {
                                      _saveSubTask(index);
                                    } else {
                                      _removeSubTask(index);
                                    }
                                  },
                                  icon: Icon(
                                    (hasFocus && hasText) ? Icons.check : CupertinoIcons.trash,
                                    color: (hasFocus && hasText)
                                        ? AppColors.primaryColor
                                        : AppColors.iconColor,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),

              // Add Sub Task Button
              GestureDetector(
                onTap: _addNewSubTask,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: AppColors.mainBottomNavColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.lightGrey),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add, color: AppColors.black),
                      const SizedBox(width: 6),
                      Text(
                        'Add Sub Task',
                        style: AppTextStyles.defaultTextStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Create Task Button
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_titleController.text.isNotEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Task created successfully!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Create Task',
                    style: AppTextStyles.defaultTextStyle.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

