import 'package:askfemi/features/group_user/visions/ugc_home/ugc_task_details/ugc_task_model/ugc_sub_task_model.dart';
import 'package:askfemi/features/group_user/visions/ugc_home/ugc_task_details/ugc_task_model/ugc_task_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_texts_style.dart';

class EditTaskScreen extends StatefulWidget {
  final UgcTask originalTask;

  const EditTaskScreen({super.key, required this.originalTask});

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late List<UgcSubTask> _editableSubTasks;
  late List<TextEditingController> _subtaskControllers;
  late List<FocusNode> _subtaskFocusNodes;
  late DateTime _selectedDateTime; // Add this for date time selection

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController(text: widget.originalTask.title);
    _descriptionController = TextEditingController(
      text: widget.originalTask.description,
    );

    // Initialize with original task date or current date
    _selectedDateTime = widget.originalTask.createdAt ?? DateTime.now();

    _editableSubTasks = widget.originalTask.subtasks
        .map((sub) => UgcSubTask(title: sub.title, isCompleted: sub.isCompleted))
        .toList();

    _subtaskControllers = _editableSubTasks
        .map((sub) => TextEditingController(text: sub.title))
        .toList();

    _subtaskFocusNodes = _editableSubTasks.map((_) => FocusNode()).toList();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    for (final c in _subtaskControllers) {
      c.dispose();
    }
    for (final node in _subtaskFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  // Method to show combined date and time picker
  Future<void> _selectDateTime(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: AppColors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    // Only show time picker if date was selected (not cancelled)
    if (selectedDate != null) {
      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: AppColors.primaryColor,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: AppColors.black,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child!,
          );
        },
      );

      // Only update if time was selected (not cancelled)
      if (selectedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime.hour,
            selectedTime.minute,
          );
        });
      }
    }
  }

  void _confirmDeleteSubtask(int index) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.lightGrey,
                ),
                height: 8,
                width: 50,
              ),
              const SizedBox(height: 32),
              Icon(
                CupertinoIcons.trash,
                size: 80,
                color: AppColors.primaryColor,
              ),
              const SizedBox(height: 16),
              Text('Delete subtask?', style: AppTextStyles.smallHeading),
              const SizedBox(height: 8),
              Text(
                'Are you sure you want to delete this subtask?',
                textAlign: TextAlign.center,
                style: AppTextStyles.defaultTextStyle.copyWith(
                  color: AppColors.grey,
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.backgroundColor,
                        side: BorderSide(color: AppColors.primaryColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(
                        'No',
                        style: AppTextStyles.defaultTextStyle.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _removeSubtask(index);
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: Text(
                        'Yes',
                        style: AppTextStyles.defaultTextStyle.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _addNewSubtask() {
    setState(() {
      _editableSubTasks.add(UgcSubTask(title: '', isCompleted: false));
      _subtaskControllers.add(TextEditingController());
      _subtaskFocusNodes.add(FocusNode());
    });
  }

  void _removeSubtask(int index) {
    setState(() {
      _subtaskFocusNodes[index].dispose();
      _subtaskFocusNodes.removeAt(index);
      _editableSubTasks.removeAt(index);
      _subtaskControllers.removeAt(index).dispose();
    });
  }

  void _saveSubtask(int index) {
    _editableSubTasks[index] = UgcSubTask(
      title: _subtaskControllers[index].text.trim(),
      isCompleted: _editableSubTasks[index].isCompleted,
    );


    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Subtask saved'),
        duration: Duration(seconds: 1),
        backgroundColor: AppColors.black,
      ),
    );
    _subtaskFocusNodes[index].unfocus();
  }

  void _saveTask() {
    for (int i = 0; i < _editableSubTasks.length; i++) {
      _editableSubTasks[i] = UgcSubTask(
        title: _subtaskControllers[i].text.trim(),
        isCompleted: _editableSubTasks[i].isCompleted,
      );
    }

    final updatedTask = UgcTask(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      status: widget.originalTask.status,
      createdAt: _selectedDateTime,
      // Use the updated date time
      startTime: widget.originalTask.startTime,
      completedTime: widget.originalTask.completedTime,
      subtasks: _editableSubTasks,
      time: '',
    );

    Get.snackbar("Success", "Task updated", backgroundColor: AppColors.grey);

    Get.back(result: updatedTask);
  }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy - hh:mm a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text("Edit Task", style: AppTextStyles.smallHeading),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ───── Task Title ─────
              Text('Task Title', style: AppTextStyles.smallHeading),
              const SizedBox(height: 8),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Enter Title',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.lightGrey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.primaryColor),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                ),
                style: AppTextStyles.defaultTextStyle,
              ),

              const SizedBox(height: 20),

              /// ───── Task Description ─────
              Text('Task Description', style: AppTextStyles.smallHeading),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descriptionController,
                minLines: 4,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: 'Enter Description',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: AppColors.lightGrey.withValues(alpha: 0.7),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: AppColors.primaryColor),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
                style: AppTextStyles.defaultTextStyle,
              ),

              const SizedBox(height: 20),

              /// ───── Task Date & Time ─────
              Text('Task Date & Time', style: AppTextStyles.smallHeading),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () => _selectDateTime(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.grey),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDateTime(_selectedDateTime),
                        style: AppTextStyles.defaultTextStyle.copyWith(
                          color: AppColors.black,
                        ),
                      ),
                      Icon(
                        Icons.access_time_outlined,
                        color: AppColors.iconColor,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// ───── Subtasks ─────
              Text('Sub Task', style: AppTextStyles.smallHeading),
              const SizedBox(height: 12),
              ...List.generate(_editableSubTasks.length, (index) {
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
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _subtaskControllers[index],
                                focusNode: _subtaskFocusNodes[index],
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
                                final hasFocus =
                                    _subtaskFocusNodes[index].hasFocus;
                                final hasText = value.text.isNotEmpty;

                                return IconButton(
                                  onPressed: () {
                                    if (hasFocus && hasText) {
                                      _saveSubtask(index);
                                      _subtaskFocusNodes[index].unfocus();
                                      setState(() {});
                                    } else {
                                      _confirmDeleteSubtask(index);
                                    }
                                  },
                                  icon: Icon(
                                    (hasFocus && hasText)
                                        ? Icons.check
                                        : CupertinoIcons.trash,
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

              /// ───── Add Sub Task ─────
              GestureDetector(
                onTap: _addNewSubtask,
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
                      Icon(Icons.add, color: AppColors.black),
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

              /// ───── Update Button ─────
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Completed',
                    style: AppTextStyles.defaultTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
