// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import '../../../../utils/app_colors.dart';
// import '../../widget/build_task_card.dart';
// import '../../widget/history_calender_widget.dart';
// import '../home/task_details/model/sub_task_model.dart';
// import '../home/task_details/model/task_model.dart';
//
// class HistoryScreen extends StatefulWidget {
//   final TaskStatus? filterStatus;
//
//   const HistoryScreen({super.key, this.filterStatus});
//
//   @override
//   State<HistoryScreen> createState() => _HistoryScreenState();
// }
//
// class _HistoryScreenState extends State<HistoryScreen> {
//   late TaskStatus? selectedStatus;
//   DateTime? _selectedFromDate;
//   DateTime? _selectedToDate;
//   bool _showCalendar = false;
//
//   @override
//   void initState() {
//     super.initState();
//     selectedStatus = widget.filterStatus;
//
//     // Set default dates: From = 1st of current month, To = current date
//     final now = DateTime.now();
//     _selectedFromDate = DateTime(now.year, now.month, 1);
//     _selectedToDate = now; // Current date instead of end of month
//   }
//
//   void _handleDateSelection(DateTime fromDate, DateTime toDate) {
//     setState(() {
//       _selectedFromDate = fromDate;
//       _selectedToDate = toDate;
//       _showCalendar = false;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundColor,
//       appBar: AppBar(
//         backgroundColor: AppColors.backgroundColor,
//         elevation: 0,
//         surfaceTintColor: Colors.white,
//         automaticallyImplyLeading: false,
//         title: const Text(
//           'Task History',
//           style: TextStyle(
//             fontSize: 30,
//             fontWeight: FontWeight.bold,
//             fontFamily: 'Plus Jakarta Sans',
//             color: Colors.black87,
//           ),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {
//               setState(() {
//                 _showCalendar = !_showCalendar;
//               });
//             },
//             icon: const Icon(CupertinoIcons.calendar_today),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Show selected date range
//             if (_selectedFromDate != null && _selectedToDate != null && !_showCalendar)
//               _buildDateRangeIndicator(),
//
//             const SizedBox(height: 16),
//
//             // Show calendar if toggled
//             if (_showCalendar)
//               HistoryCalendarWidget(
//                 initialFromDate: _selectedFromDate,
//                 initialToDate: _selectedToDate,
//                 onDateSelected: _handleDateSelection,
//                 onClose: () {
//                   setState(() {
//                     _showCalendar = false;
//                   });
//                 },
//               ),
//
//             // Task list (hidden when calendar is shown)
//             if (!_showCalendar)
//               Expanded(child: _buildTaskList()),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDateRangeIndicator() {
//     final format = DateFormat('dd MMM');
//     return Row(
//       children: [
//         Text(
//           '${format.format(_selectedFromDate!)} - ${format.format(_selectedToDate!)}',
//           style: TextStyle(
//             fontSize: 14,
//             fontFamily: 'Plus Jakarta Sans',
//             color: Colors.grey[600],
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildTaskList() {
//     final tasks = _getFilteredTasks();
//
//     if (tasks.isEmpty) {
//       return Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.task_alt, size: 64, color: Colors.grey[300]),
//             const SizedBox(height: 16),
//             Text(
//               'No tasks found',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontFamily: 'Plus Jakarta Sans',
//                 color: Colors.grey[600],
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//
//     return ListView.separated(
//       physics: const BouncingScrollPhysics(),
//       itemCount: tasks.length,
//       separatorBuilder: (context, index) => const SizedBox(height: 16),
//       itemBuilder: (context, index) {
//         final task = tasks[index];
//         return buildTaskCard(context: context, task: task);
//       },
//     );
//   }
//
//   List<Task> _getFilteredTasks() {
//     final allTasks = _getAllTasks();
//
//     if (selectedStatus == null) {
//       return allTasks;
//     }
//
//     return allTasks.where((task) => task.status == selectedStatus).toList();
//   }
//
//   // Mock data with properly initialized subtasks
//   List<Task> _getAllTasks() {
//     return [
//       Task(
//         title: 'Design UI Mockups',
//         description: 'Create UI designs for new mobile app.',
//         time: '9:00 AM',
//         status: TaskStatus.completed,
//         createdAt: DateTime(2026, 1, 30, 8, 0),
//         startTime: DateTime(2026, 1, 30, 9, 0),
//         completedTime: DateTime(2026, 1, 30, 9, 0),
//         totalSubtasks: 4,
//         completedSubtasks: 4,
//         subtasks: [
//           SubTask(
//             title: 'Create wireframes',
//             isCompleted: true,
//             duration: '2 hours',
//           ),
//           SubTask(
//             title: 'Design color scheme',
//             isCompleted: true,
//             duration: '1 hour',
//           ),
//           SubTask(
//             title: 'Create component library',
//             isCompleted: false,
//             duration: '3 hours',
//           ),
//           SubTask(
//             title: 'Get client feedback',
//             isCompleted: false,
//             duration: '1 hour',
//           ),
//         ],
//       ),
//       Task(
//         title: 'Write Weekly Report',
//         description: 'Summarize weekly progress and plan for next week.',
//         time: '4:30 PM',
//         status: TaskStatus.completed,
//         createdAt: DateTime(2026, 1, 30, 8, 0),
//         startTime: DateTime(2026, 1, 30, 16, 30),
//         completedTime: DateTime(2026, 1, 30, 16, 30),
//         totalSubtasks: 3,
//         completedSubtasks: 3,
//         subtasks: [
//           SubTask(
//             title: 'Collect team updates',
//             isCompleted: true,
//             duration: '30 min',
//           ),
//           SubTask(
//             title: 'Compile metrics',
//             isCompleted: true,
//             duration: '45 min',
//           ),
//           SubTask(
//             title: 'Write summary',
//             isCompleted: true,
//             duration: '1 hour',
//           ),
//         ],
//       ),
//       Task(
//         title: 'Complete Math Homework',
//         description: 'Solve algebra, geometry and calculus problems.',
//         time: '10:30 AM',
//         status: TaskStatus.completed,
//         createdAt: DateTime(2026, 1, 30, 9, 50),
//         startTime: DateTime(2026, 1, 30, 10, 30),
//         completedTime: DateTime(2026, 1, 30, 12, 45),
//         totalSubtasks: 5,
//         completedSubtasks: 5,
//         subtasks: [
//           SubTask(
//             title: 'Solve algebra problems',
//             isCompleted: true,
//             duration: '30 min',
//           ),
//           SubTask(
//             title: 'Complete geometry worksheet',
//             isCompleted: true,
//             duration: '30 min',
//           ),
//           SubTask(
//             title: 'Study calculus',
//             isCompleted: true,
//             duration: '45 min',
//           ),
//           SubTask(
//             title: 'Review all solutions',
//             isCompleted: true,
//             duration: '20 min',
//           ),
//           SubTask(
//             title: 'Submit homework',
//             isCompleted: true,
//             duration: '10 min',
//           ),
//         ],
//       ),
//       Task(
//         title: 'Prepare Presentation',
//         description: 'Create slides for tomorrow\'s meeting.',
//         time: '2:00 PM',
//         status: TaskStatus.completed,
//         createdAt: DateTime(2026, 1, 30, 8, 0),
//         startTime: DateTime(2026, 1, 30, 14, 0),
//         completedTime: DateTime(2026, 1, 30, 16, 30),
//         totalSubtasks: 6,
//         completedSubtasks: 3,
//         subtasks: [
//           SubTask(
//             title: 'Research topic',
//             isCompleted: true,
//             duration: '1 hour',
//           ),
//           SubTask(
//             title: 'Create outline',
//             isCompleted: true,
//             duration: '30 min',
//           ),
//           SubTask(
//             title: 'Design slides',
//             isCompleted: true,
//             duration: '2 hours',
//           ),
//           SubTask(
//             title: 'Add content',
//             isCompleted: false,
//             duration: '1 hour',
//           ),
//           SubTask(
//             title: 'Practice presentation',
//             isCompleted: false,
//             duration: '30 min',
//           ),
//           SubTask(
//             title: 'Get feedback',
//             isCompleted: false,
//             duration: '15 min',
//           ),
//         ],
//       ),
//       Task(
//         title: 'Team Meeting',
//         description: 'Discuss project updates and next steps.',
//         time: '3:30 PM',
//         status: TaskStatus.completed,
//         createdAt: DateTime(2026, 1, 30, 7, 30),
//         startTime: DateTime(2026, 1, 30, 15, 30),
//         completedTime: DateTime(2026, 1, 30, 16, 15),
//         totalSubtasks: 0,
//         completedSubtasks: 0,
//         subtasks: const [],
//       ),
//       Task(
//         title: 'Code Review',
//         description: 'Review pull requests from team members.',
//         time: '11:00 AM',
//         status: TaskStatus.completed,
//         createdAt: DateTime(2026, 1, 29, 10, 0),
//         startTime: DateTime(2026, 1, 29, 11, 0),
//         completedTime: DateTime(2026, 1, 29, 12, 30),
//         totalSubtasks: 3,
//         completedSubtasks: 3,
//         subtasks: [
//           SubTask(
//             title: 'Review PR #123',
//             isCompleted: true,
//             duration: '20 min',
//           ),
//           SubTask(
//             title: 'Review PR #124',
//             isCompleted: true,
//             duration: '15 min',
//           ),
//           SubTask(
//             title: 'Review PR #125',
//             isCompleted: true,
//             duration: '25 min',
//           ),
//         ],
//       ),
//       Task(
//         title: 'Write Documentation',
//         description: 'Update API documentation for new screens.',
//         time: '4:00 PM',
//         status: TaskStatus.completed,
//         createdAt: DateTime(2026, 1, 30, 9, 0),
//         startTime: DateTime(2026, 1, 30, 16, 0),
//         completedTime: DateTime(2026, 1, 30, 18, 45),
//         totalSubtasks: 4,
//         completedSubtasks: 1,
//         subtasks: [
//           SubTask(
//             title: 'Document authentication API',
//             isCompleted: true,
//             duration: '1 hour',
//           ),
//           SubTask(
//             title: 'Document payment API',
//             isCompleted: false,
//             duration: '1 hour',
//           ),
//           SubTask(
//             title: 'Document user management API',
//             isCompleted: false,
//             duration: '45 min',
//           ),
//           SubTask(
//             title: 'Review documentation',
//             isCompleted: false,
//             duration: '30 min',
//           ),
//         ],
//       ),
//       Task(
//         title: 'Client Call',
//         description: 'Discuss requirements for new project.',
//         time: '1:00 PM',
//         status: TaskStatus.completed,
//         createdAt: DateTime(2026, 1, 30, 8, 30),
//         startTime: DateTime(2026, 1, 30, 13, 0),
//         completedTime: DateTime(2026, 1, 30, 13, 45),
//         totalSubtasks: 0,
//         completedSubtasks: 0,
//         subtasks: const [],
//       ),
//     ];
//   }
// }


import 'package:askfemi/utils/app_texts_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import '../../../../utils/app_colors.dart';
import '../../widget/build_task_card.dart';
import '../../widget/history_calender_widget.dart';
import '../home/task_details/model/sub_task_model.dart';
import '../home/task_details/model/task_model.dart';

class HistoryScreen extends StatefulWidget {
  final TaskStatus? filterStatus;

  const HistoryScreen({super.key, this.filterStatus});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late TaskStatus? selectedStatus;
  DateTime? _selectedFromDate;
  DateTime? _selectedToDate;
  bool _showCalendar = false;

  @override
  void initState() {
    super.initState();
    selectedStatus = widget.filterStatus;

    // Set default dates: From = 1st of current month, To = current date
    final now = DateTime.now();
    _selectedFromDate = DateTime(now.year, now.month, 1);
    _selectedToDate = now; // Current date instead of end of month
  }

  void _handleDateSelection(DateTime fromDate, DateTime toDate) {
    setState(() {
      _selectedFromDate = fromDate;
      _selectedToDate = toDate;
      _showCalendar = false;
    });
  }

  // New method to reset to current date (today)
  void _resetToCurrentDate() {
    setState(() {
      final now = DateTime.now();
      _selectedFromDate = DateTime(now.year, now.month, now.day);
      _selectedToDate = DateTime(now.year, now.month, now.day);
      _showCalendar = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        surfaceTintColor: Colors.white,
        automaticallyImplyLeading: false,
        title:  Text(
          'Task History',
          style: AppTextStyles.largeHeading,
        ),
        actions: [
          // Current Date Text Button (shows today's date)
          TextButton(
            onPressed: _resetToCurrentDate,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              DateFormat('dd MMM yyyy').format(DateTime.now()),
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Plus Jakarta Sans',
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          // Calendar Icon Button
          IconButton(
            onPressed: () {
              setState(() {
                _showCalendar = !_showCalendar;
              });
            },
            icon: const Icon(CupertinoIcons.calendar_today),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Show selected date range
            if (_selectedFromDate != null && _selectedToDate != null && !_showCalendar)
              _buildDateRangeIndicator(),

            const SizedBox(height: 16),

            // Show calendar if toggled
            if (_showCalendar)
              HistoryCalendarWidget(
                initialFromDate: _selectedFromDate,
                initialToDate: _selectedToDate,
                onDateSelected: _handleDateSelection,
                onClose: () {
                  setState(() {
                    _showCalendar = false;
                  });
                },
              ),

            // Task list (hidden when calendar is shown)
            if (!_showCalendar)
              Expanded(child: _buildTaskList()),
          ],
        ),
      ),
    );
  }

  Widget _buildDateRangeIndicator() {
    final format = DateFormat('dd MMM');

    // Check if it's a single day selection (both dates are the same day)
    final isSingleDay = _selectedFromDate!.year == _selectedToDate!.year &&
        _selectedFromDate!.month == _selectedToDate!.month &&
        _selectedFromDate!.day == _selectedToDate!.day;

    return Row(
      children: [
        if (isSingleDay)
          Text(
            format.format(_selectedFromDate!),
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Plus Jakarta Sans',
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          )
        else
          Text(
            '${format.format(_selectedFromDate!)} - ${format.format(_selectedToDate!)}',
            style: TextStyle(
              fontSize: 14,
              fontFamily: 'Plus Jakarta Sans',
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
      ],
    );
  }

  Widget _buildTaskList() {
    final tasks = _getFilteredTasks();

    if (tasks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/empty_task.svg'),
            const SizedBox(height: 16),
            Text(
              'No tasks history found',
              style: TextStyle(
                fontSize: 20,
                fontFamily: 'Plus Jakarta Sans',
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: tasks.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final task = tasks[index];
        return buildTaskCard(context: context, task: task);
      },
    );
  }

  List<Task> _getFilteredTasks() {
    final allTasks = _getAllTasks();

    // Filter by selected date range
    final dateFilteredTasks = allTasks.where((task) {
      // Use createdAt for date filtering
      final taskDate = task.createdAt;

      // Check if task date is within selected range
      if (_selectedFromDate != null && _selectedToDate != null) {
        // Normalize dates to compare only year, month, day
        final taskDay = DateTime(taskDate.year, taskDate.month, taskDate.day);
        final fromDay = DateTime(_selectedFromDate!.year, _selectedFromDate!.month, _selectedFromDate!.day);
        final toDay = DateTime(_selectedToDate!.year, _selectedToDate!.month, _selectedToDate!.day);

        return taskDay.isAfter(fromDay.subtract(const Duration(days: 1))) &&
            taskDay.isBefore(toDay.add(const Duration(days: 1)));
      }
      return true;
    }).toList();

    if (selectedStatus == null) {
      return dateFilteredTasks;
    }

    return dateFilteredTasks.where((task) => task.status == selectedStatus).toList();
  }

  // Mock data with properly initialized subtasks
  List<Task> _getAllTasks() {
    return [
      Task(
        title: 'Design UI Mockups',
        description: 'Create UI designs for new mobile app.',
        time: '9:00 AM',
        status: TaskStatus.completed,
        createdAt: DateTime(2026, 1, 30, 8, 0),
        startTime: DateTime(2026, 1, 30, 9, 0),
        completedTime: DateTime(2026, 1, 30, 9, 0),
        totalSubtasks: 4,
        completedSubtasks: 4,
        subtasks: [
          SubTask(
            title: 'Create wireframes',
            isCompleted: true,
            duration: '2 hours',
          ),
          SubTask(
            title: 'Design color scheme',
            isCompleted: true,
            duration: '1 hour',
          ),
          SubTask(
            title: 'Create component library',
            isCompleted: false,
            duration: '3 hours',
          ),
          SubTask(
            title: 'Get client feedback',
            isCompleted: false,
            duration: '1 hour',
          ),
        ],
      ),
      Task(
        title: 'Write Weekly Report',
        description: 'Summarize weekly progress and plan for next week.',
        time: '4:30 PM',
        status: TaskStatus.completed,
        createdAt: DateTime(2026, 1, 30, 8, 0),
        startTime: DateTime(2026, 1, 30, 16, 30),
        completedTime: DateTime(2026, 1, 30, 16, 30),
        totalSubtasks: 3,
        completedSubtasks: 3,
        subtasks: [
          SubTask(
            title: 'Collect team updates',
            isCompleted: true,
            duration: '30 min',
          ),
          SubTask(
            title: 'Compile metrics',
            isCompleted: true,
            duration: '45 min',
          ),
          SubTask(
            title: 'Write summary',
            isCompleted: true,
            duration: '1 hour',
          ),
        ],
      ),
      Task(
        title: 'Complete Math Homework',
        description: 'Solve algebra, geometry and calculus problems.',
        time: '10:30 AM',
        status: TaskStatus.completed,
        createdAt: DateTime(2026, 1, 30, 9, 50),
        startTime: DateTime(2026, 1, 30, 10, 30),
        completedTime: DateTime(2026, 1, 30, 12, 45),
        totalSubtasks: 5,
        completedSubtasks: 5,
        subtasks: [
          SubTask(
            title: 'Solve algebra problems',
            isCompleted: true,
            duration: '30 min',
          ),
          SubTask(
            title: 'Complete geometry worksheet',
            isCompleted: true,
            duration: '30 min',
          ),
          SubTask(
            title: 'Study calculus',
            isCompleted: true,
            duration: '45 min',
          ),
          SubTask(
            title: 'Review all solutions',
            isCompleted: true,
            duration: '20 min',
          ),
          SubTask(
            title: 'Submit homework',
            isCompleted: true,
            duration: '10 min',
          ),
        ],
      ),
      Task(
        title: 'Prepare Presentation',
        description: 'Create slides for tomorrow\'s meeting.',
        time: '2:00 PM',
        status: TaskStatus.completed,
        createdAt: DateTime(2026, 1, 30, 8, 0),
        startTime: DateTime(2026, 1, 30, 14, 0),
        completedTime: DateTime(2026, 1, 30, 16, 30),
        totalSubtasks: 6,
        completedSubtasks: 3,
        subtasks: [
          SubTask(
            title: 'Research topic',
            isCompleted: true,
            duration: '1 hour',
          ),
          SubTask(
            title: 'Create outline',
            isCompleted: true,
            duration: '30 min',
          ),
          SubTask(
            title: 'Design slides',
            isCompleted: true,
            duration: '2 hours',
          ),
          SubTask(
            title: 'Add content',
            isCompleted: false,
            duration: '1 hour',
          ),
          SubTask(
            title: 'Practice presentation',
            isCompleted: false,
            duration: '30 min',
          ),
          SubTask(
            title: 'Get feedback',
            isCompleted: false,
            duration: '15 min',
          ),
        ],
      ),
      Task(
        title: 'Team Meeting',
        description: 'Discuss project updates and next steps.',
        time: '3:30 PM',
        status: TaskStatus.completed,
        createdAt: DateTime(2026, 1, 30, 7, 30),
        startTime: DateTime(2026, 1, 30, 15, 30),
        completedTime: DateTime(2026, 1, 30, 16, 15),
        totalSubtasks: 0,
        completedSubtasks: 0,
        subtasks: const [],
      ),
      Task(
        title: 'Code Review',
        description: 'Review pull requests from team members.',
        time: '11:00 AM',
        status: TaskStatus.completed,
        createdAt: DateTime(2026, 1, 29, 10, 0),
        startTime: DateTime(2026, 1, 29, 11, 0),
        completedTime: DateTime(2026, 1, 29, 12, 30),
        totalSubtasks: 3,
        completedSubtasks: 3,
        subtasks: [
          SubTask(
            title: 'Review PR #123',
            isCompleted: true,
            duration: '20 min',
          ),
          SubTask(
            title: 'Review PR #124',
            isCompleted: true,
            duration: '15 min',
          ),
          SubTask(
            title: 'Review PR #125',
            isCompleted: true,
            duration: '25 min',
          ),
        ],
      ),
      Task(
        title: 'Write Documentation',
        description: 'Update API documentation for new screens.',
        time: '4:00 PM',
        status: TaskStatus.completed,
        createdAt: DateTime(2026, 1, 30, 9, 0),
        startTime: DateTime(2026, 1, 30, 16, 0),
        completedTime: DateTime(2026, 1, 30, 18, 45),
        totalSubtasks: 4,
        completedSubtasks: 1,
        subtasks: [
          SubTask(
            title: 'Document authentication API',
            isCompleted: true,
            duration: '1 hour',
          ),
          SubTask(
            title: 'Document payment API',
            isCompleted: false,
            duration: '1 hour',
          ),
          SubTask(
            title: 'Document user management API',
            isCompleted: false,
            duration: '45 min',
          ),
          SubTask(
            title: 'Review documentation',
            isCompleted: false,
            duration: '30 min',
          ),
        ],
      ),
      Task(
        title: 'Client Call',
        description: 'Discuss requirements for new project.',
        time: '1:00 PM',
        status: TaskStatus.completed,
        createdAt: DateTime(2026, 1, 30, 8, 30),
        startTime: DateTime(2026, 1, 30, 13, 0),
        completedTime: DateTime(2026, 1, 30, 13, 45),
        totalSubtasks: 0,
        completedSubtasks: 0,
        subtasks: const [],
      ),
    ];
  }
}