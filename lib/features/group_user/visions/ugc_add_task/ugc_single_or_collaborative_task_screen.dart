// import 'package:askfemi/utils/app_colors.dart';
// import 'package:askfemi/utils/app_texts_style.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import '../ugc_home/ugc_task_details/ugc_task_model/ugc_sub_task_model.dart';
//
// class UgcSingleOrCollaborativeTaskScreen extends StatefulWidget {
//   const UgcSingleOrCollaborativeTaskScreen({super.key});
//
//   @override
//   State<UgcSingleOrCollaborativeTaskScreen> createState() =>
//       _UgcSingleOrCollaborativeTaskScreenState();
// }
//
// class _UgcSingleOrCollaborativeTaskScreenState
//     extends State<UgcSingleOrCollaborativeTaskScreen> {
//   final TextEditingController titleController =
//   TextEditingController(text: 'UI/UX Design');
//   final TextEditingController descriptionController = TextEditingController(
//       text:
//       'Finish exercises 1–10 from chapter 5\nThis call is scheduled to align the design team on current progress.');
//   final TextEditingController dateTimeController = TextEditingController();
//
//   // List of members
//   List<Map<String, dynamic>> members = [
//     {'id': '1', 'name': 'Alex', 'role': 'Secondary'},
//     {'id': '2', 'name': 'John Doe', 'role': 'Primary'},
//     {'id': '3', 'name': 'Janex', 'role': 'Secondary'},
//     {'id': '4', 'name': 'Mike', 'role': 'Secondary'},
//   ];
//
//   // Available members for selection
//   List<Map<String, dynamic>> availableMembers = [
//     {'id': '5', 'name': 'Sarah Johnson', 'role': 'Primary'},
//     {'id': '6', 'name': 'Robert Wilson', 'role': 'Secondary'},
//     {'id': '7', 'name': 'Emily Brown', 'role': 'Secondary'},
//     {'id': '8', 'name': 'Michael Davis', 'role': 'Secondary'},
//     {'id': '9', 'name': 'Jessica Miller', 'role': 'Secondary'},
//   ];
//
//   // Subtask related variables
//   final List<UgcSubTask> _subTasks = [];
//   final List<TextEditingController> _subtaskControllers = [];
//   final List<FocusNode> _subtaskFocusNodes = [];
//
//   bool _isCollaborativeTask = true; // Track if it's collaborative or single
//   bool _showMembers = true; // Track if members section is expanded
//
//   @override
//   void dispose() {
//     titleController.dispose();
//     descriptionController.dispose();
//     dateTimeController.dispose();
//     for (final controller in _subtaskControllers) {
//       controller.dispose();
//     }
//     for (final node in _subtaskFocusNodes) {
//       node.dispose();
//     }
//     super.dispose();
//   }
//
//   // Toggle between collaborative and single task
//   void _toggleTaskType() {
//     setState(() {
//       _isCollaborativeTask = !_isCollaborativeTask;
//     });
//   }
//
//   // Toggle members visibility
//   void _toggleMembersVisibility() {
//     setState(() {
//       _showMembers = !_showMembers;
//     });
//   }
//
//   // Show Add Member Dialog
//   void _showAddMemberDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AddMemberDialog(
//           availableMembers: availableMembers,
//           onMembersAdded: (selectedMembers) {
//             // This callback will be called when members are added
//             _handleMembersAdded(selectedMembers);
//           },
//         );
//       },
//     );
//   }
//
//   // Handle members added from dialog
//   void _handleMembersAdded(List<Map<String, dynamic>> selectedMembers) {
//     setState(() {
//       // Add selected members to the main members list
//       for (var member in selectedMembers) {
//         // Check if member already exists
//         if (!members.any((m) => m['id'] == member['id'])) {
//           members.add(member);
//         }
//       }
//       // Remove from available members
//       availableMembers.removeWhere((member) =>
//           selectedMembers.any((selected) => selected['id'] == member['id']));
//       // Show members section
//       _showMembers = true;
//     });
//
//     // Show success message
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text('${selectedMembers.length} member(s) added successfully'),
//         backgroundColor: Colors.green,
//         duration: Duration(seconds: 2),
//       ),
//     );
//   }
//
//   // DATE & TIME METHODS COPIED FROM UgcPersonalTaskScreen - Modified to not auto-select
//   Future<void> _selectDateTime() async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2100),
//       builder: (context, child) {
//         return Theme(
//           data: Theme.of(context).copyWith(
//             colorScheme: ColorScheme.light(
//               primary: AppColors.primaryColor,
//               onPrimary: AppColors.black,
//               onSurface: AppColors.black,
//             ),
//             textButtonTheme: TextButtonThemeData(
//               style: TextButton.styleFrom(foregroundColor: AppColors.primaryColor),
//             ),
//           ),
//           child: child!,
//         );
//       },
//     );
//
//     if (pickedDate != null && mounted) {
//       final TimeOfDay? pickedTime = await showTimePicker(
//         context: context,
//         initialTime: TimeOfDay.now(),
//         builder: (context, child) {
//           return Theme(
//             data: Theme.of(context).copyWith(
//               colorScheme: ColorScheme.light(
//                 primary: AppColors.primaryColor,
//                 onPrimary: AppColors.black,
//                 onSurface: AppColors.black,
//               ),
//               textButtonTheme: TextButtonThemeData(
//                 style: TextButton.styleFrom(foregroundColor: AppColors.primaryColor),
//               ),
//             ),
//             child: child!,
//           );
//         },
//       );
//
//       if (pickedTime != null && mounted) {
//         setState(() {
//           dateTimeController.text =
//           '${pickedDate.day}/${pickedDate.month}/${pickedDate.year} ${pickedTime.format(context)}';
//         });
//       }
//     }
//   }
//
//   void _addNewSubTask() {
//     setState(() {
//       _subTasks.add(UgcSubTask(title: ''));
//       _subtaskControllers.add(TextEditingController());
//       _subtaskFocusNodes.add(FocusNode());
//     });
//   }
//
//   void _removeSubTask(int index) {
//     setState(() {
//       _subtaskControllers[index].dispose();
//       _subtaskFocusNodes[index].dispose();
//       _subTasks.removeAt(index);
//       _subtaskControllers.removeAt(index);
//       _subtaskFocusNodes.removeAt(index);
//     });
//   }
//
//   void _saveSubTask(int index) {
//     setState(() {
//       _subTasks[index] = _subTasks[index].copyWith(
//         title: _subtaskControllers[index].text.trim(),
//       );
//       _subtaskFocusNodes[index].unfocus();
//     });
//
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(
//         content: Text('Subtask saved'),
//         duration: Duration(seconds: 1),
//         backgroundColor: Colors.black,
//       ),
//     );
//   }
//
//   // Handle remove member
//   void _handleRemove(String memberId) {
//     setState(() {
//       final removedMember = members.firstWhere((member) => member['id'] == memberId);
//       members.removeWhere((member) => member['id'] == memberId);
//
//       // Add back to available members if not already there
//       if (!availableMembers.any((m) => m['id'] == removedMember['id'])) {
//         availableMembers.add(removedMember);
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundColor,
//       appBar: AppBar(
//         backgroundColor: AppColors.backgroundColor,
//         surfaceTintColor: AppColors.transparent,
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: Text(
//           'Create Task',
//           style: AppTextStyles.smallHeading.copyWith(fontSize: 22),
//         ),
//         centerTitle: false,
//       ),
//       body: SingleChildScrollView(
//         physics: const AlwaysScrollableScrollPhysics(
//           parent: BouncingScrollPhysics(),
//         ),
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Add New Task',
//               style: AppTextStyles.largeHeading,
//             ),
//             const SizedBox(height: 6),
//             Text(
//               'You can add 3 to 5 more tasks today!',
//               style: AppTextStyles.defaultTextStyle,
//             ),
//             const SizedBox(height: 24),
//
//             /// Task Title
//             _label('Task Title'),
//             _inputField(controller: titleController),
//
//             const SizedBox(height: 20),
//
//             /// Task Description
//             _label('Task Description'),
//             _inputField(
//               controller: descriptionController,
//               maxLines: 4,
//             ),
//
//             const SizedBox(height: 20),
//
//             /// Date Time - EMPTY INITIALLY, user must select manually
//             _label('Task Date & Time'),
//             const SizedBox(height: 12),
//             TextField(
//               controller: dateTimeController,
//               readOnly: true,
//               onTap: _selectDateTime,
//               cursorColor: AppColors.primaryColor,
//               decoration: InputDecoration(
//                 hintText: 'Select Date & Time',
//                 hintStyle: AppTextStyles.defaultTextStyle.copyWith(color: AppColors.grey),
//                 filled: true,
//                 fillColor: AppColors.backgroundColor,
//                 suffixIcon:  Icon(Icons.access_time, color: AppColors.iconColor),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: const BorderSide(color: AppColors.grey, width: 1),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: const BorderSide(color: AppColors.grey, width: 1),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                   borderSide: const BorderSide(color: AppColors.grey, width: 2),
//                 ),
//                 contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//               ),
//             ),
//
//             const SizedBox(height: 24),
//
//             /// Collaborative/Single Task Section - SWAPPABLE
//             Container(
//               padding: const EdgeInsets.all(14),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(
//                   color: Colors.blueAccent,
//                   style: BorderStyle.solid,
//                 ),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   /// Swappable Header
//                   Row(
//                     children: [
//                       Text(
//                         _isCollaborativeTask ? 'Collaborative Task' : 'Single Assignment',
//                         style: const TextStyle(
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       const Spacer(),
//                       GestureDetector(
//                         onTap: _toggleTaskType,
//                         child: Icon(
//                           _isCollaborativeTask
//                               ? Icons.swap_vert_outlined
//                               : Icons.swap_vert_outlined,
//                           color: AppColors.primaryColor,
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   // Always show Add Member button for both task types
//                   const SizedBox(height: 12),
//
//                   /// Members - Only shown when _showMembers is true (for both task types)
//                   if (_showMembers && members.isNotEmpty)
//                     Wrap(
//                       alignment: WrapAlignment.start,
//                       spacing: 8,
//                       runSpacing: 8,
//                       children: members.map((member) {
//                         return Container(
//                           constraints: const BoxConstraints(maxWidth: 140),
//                           child: _memberChip(
//                             key: ValueKey(member['id']),
//                             memberId: member['id'],
//                             name: member['name'],
//                             role: member['role'],
//                             onRemove: _handleRemove,
//                           ),
//                         );
//                       }).toList(),
//                     ),
//
//                   if (_showMembers && members.isEmpty)
//                     Container(
//                       padding: const EdgeInsets.symmetric(vertical: 12),
//                       child: Text(
//                         'No members added yet',
//                         style: TextStyle(
//                           fontSize: 14,
//                           color: Colors.grey[600],
//                           fontStyle: FontStyle.italic,
//                         ),
//                       ),
//                     ),
//
//                   const SizedBox(height: 12),
//
//                   /// Add Member Button - Always shown for both task types
//                   SizedBox(
//                     width: double.infinity,
//                     height: 44,
//                     child: ElevatedButton.icon(
//                       onPressed: _showAddMemberDialog,
//                       icon: const Icon(Icons.add, color: AppColors.white),
//                       label: Text(
//                         'Add Member',
//                         style: AppTextStyles.defaultTextStyle
//                             .copyWith(color: AppColors.white),
//                       ),
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: AppColors.primaryColor,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//
//             const SizedBox(height: 20),
//
//             /// Subtasks list
//             ...List.generate(_subTasks.length, (index) {
//               return Padding(
//                 padding: const EdgeInsets.only(bottom: 12),
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 14,
//                     vertical: 10,
//                   ),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: AppColors.grey),
//                   ),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Container(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 6,
//                               vertical: 3,
//                             ),
//                             decoration: BoxDecoration(
//                               color: AppColors.primaryColor.withOpacity(0.5),
//                               borderRadius: BorderRadius.circular(6),
//                             ),
//                             child: Text(
//                               'Sub Task',
//                               style: AppTextStyles.smallText.copyWith(
//                                 color: AppColors.black,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 8),
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Expanded(
//                             child: TextField(
//                               controller: _subtaskControllers[index],
//                               focusNode: _subtaskFocusNodes[index],
//                               maxLines: null,
//                               minLines: 1,
//                               decoration: const InputDecoration(
//                                 hintText: 'Enter Sub Task Details',
//                                 border: InputBorder.none,
//                                 hintStyle: TextStyle(color: AppColors.grey),
//                               ),
//                             ),
//                           ),
//                           ValueListenableBuilder<TextEditingValue>(
//                             valueListenable: _subtaskControllers[index],
//                             builder: (context, value, child) {
//                               final hasFocus = _subtaskFocusNodes[index].hasFocus;
//                               final hasText = value.text.isNotEmpty;
//
//                               return IconButton(
//                                 onPressed: () {
//                                   if (hasFocus && hasText) {
//                                     _saveSubTask(index);
//                                   } else {
//                                     _removeSubTask(index);
//                                   }
//                                 },
//                                 icon: Icon(
//                                   (hasFocus && hasText) ? Icons.check : CupertinoIcons.trash,
//                                   color: (hasFocus && hasText)
//                                       ? AppColors.primaryColor
//                                       : AppColors.iconColor,
//                                 ),
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             }),
//
//             /// Add Sub Task Button
//             GestureDetector(
//               onTap: _addNewSubTask,
//               child: Container(
//                 padding: const EdgeInsets.symmetric(vertical: 14),
//                 decoration: BoxDecoration(
//                   color: AppColors.mainBottomNavColor,
//                   borderRadius: BorderRadius.circular(12),
//                   border: Border.all(color: AppColors.lightGrey),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Icon(Icons.add, color: AppColors.black),
//                     const SizedBox(width: 6),
//                     Text(
//                       'Add Sub Task',
//                       style: AppTextStyles.defaultTextStyle.copyWith(
//                         fontWeight: FontWeight.bold,
//                         color: AppColors.black,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 24),
//
//             /// Create Task Button
//             SizedBox(
//               width: double.infinity,
//               height: 52,
//               child: ElevatedButton(
//                 onPressed: () {},
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF60A5FA),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child:  Text(
//                   'Create Task',
//                   style: AppTextStyles.defaultTextStyle.copyWith(
//                       color: AppColors.white,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 18
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   /// Helpers
//
//   Widget _label(String text) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: Text(
//         text,
//         style: AppTextStyles.smallHeading.copyWith(fontSize: 14),
//       ),
//     );
//   }
//
//   Widget _inputField({
//     required TextEditingController controller,
//     int maxLines = 1,
//   }) {
//     return TextField(
//       controller: controller,
//       maxLines: maxLines,
//       decoration: InputDecoration(
//         filled: true,
//         fillColor: Colors.white,
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.grey.shade300),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: BorderSide(color: Colors.grey.shade300),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//           borderSide: const BorderSide(color: AppColors.grey, width: 2),
//         ),
//       ),
//     );
//   }
//
//   // Updated _memberChip widget with internal removal logic
//   Widget _memberChip({
//     Key? key,
//     required String memberId,
//     required String name,
//     required String role,
//     required Function(String) onRemove,
//     String? imagePath,
//   }) {
//     return _MemberChipInternal(
//       key: key,
//       memberId: memberId,
//       name: name,
//       role: role,
//       imagePath: imagePath,
//       onRemove: onRemove,
//     );
//   }
// }
//
// // Internal stateful widget for handling removal animation
// class _MemberChipInternal extends StatefulWidget {
//   final String memberId;
//   final String name;
//   final String role;
//   final String? imagePath;
//   final Function(String) onRemove;
//
//   const _MemberChipInternal({
//     Key? key,
//     required this.memberId,
//     required this.name,
//     required this.role,
//     required this.onRemove,
//     this.imagePath,
//   }) : super(key: key);
//
//   @override
//   State<_MemberChipInternal> createState() => __MemberChipInternalState();
// }
//
// class __MemberChipInternalState extends State<_MemberChipInternal> {
//   bool _isRemoving = false;
//
//   void _handleRemove() {
//     if (_isRemoving) return;
//
//     setState(() {
//       _isRemoving = true;
//     });
//
//     // Wait for animation to complete, then notify parent
//     Future.delayed(const Duration(milliseconds: 300), () {
//       widget.onRemove(widget.memberId);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedOpacity(
//       duration: const Duration(milliseconds: 300),
//       opacity: _isRemoving ? 0 : 1,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 300),
//         padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4), // Reduced padding
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20), // Slightly smaller radius
//           border: Border.all(color: Colors.grey.shade300),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             CircleAvatar(
//               radius: 12, // Smaller avatar
//               backgroundImage: widget.imagePath != null
//                   ? AssetImage(widget.imagePath!)
//                   : const AssetImage("assets/images/dummy_child_user_image.png")
//               as ImageProvider,
//             ),
//             const SizedBox(width: 4), // Reduced spacing
//             Flexible(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Text(
//                     widget.name,
//                     style: const TextStyle(fontSize: 11), // Smaller font
//                     overflow: TextOverflow.ellipsis,
//                     maxLines: 1,
//                   ),
//                   Text(
//                     widget.role,
//                     style: const TextStyle(fontSize: 9, color: Colors.grey), // Smaller font
//                     overflow: TextOverflow.ellipsis,
//                     maxLines: 1,
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(width: 4), // Reduced spacing
//             GestureDetector(
//               onTap: _handleRemove,
//               child: const Icon(Icons.close, size: 14, color: Colors.red), // Smaller icon
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // Separate Dialog Widget
// class AddMemberDialog extends StatefulWidget {
//   final List<Map<String, dynamic>> availableMembers;
//   final Function(List<Map<String, dynamic>>) onMembersAdded;
//
//   const AddMemberDialog({
//     super.key,
//     required this.availableMembers,
//     required this.onMembersAdded,
//   });
//
//   @override
//   State<AddMemberDialog> createState() => _AddMemberDialogState();
// }
//
// class _AddMemberDialogState extends State<AddMemberDialog> {
//   List<Map<String, dynamic>> selectedMembers = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       actionsPadding: EdgeInsetsGeometry.all(8),
//       backgroundColor: AppColors.backgroundColor,
//       title: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Collaborative Task',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.blueAccent,
//             ),
//           ),
//           SizedBox(height: 4),
//           Text(
//             'Team Members (${widget.availableMembers.length})',
//             style: TextStyle(
//               fontSize: 14,
//               color: Colors.grey[600],
//             ),
//           ),
//         ],
//       ),
//       content: SizedBox(
//         width: 120,
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Search Bar
//             Container(
//               padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//               decoration: BoxDecoration(
//                 color: Colors.grey[100],
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(color: AppColors.grey),
//               ),
//               child: Row(
//                 children: [
//                   Icon(Icons.search, size: 20, color: Colors.grey[600]),
//                   SizedBox(width: 8),
//                   Expanded(
//                     child: TextField(
//                       decoration: InputDecoration(
//                         hintText: 'Search Member',
//                         border: InputBorder.none,
//                         hintStyle: TextStyle(color: Colors.grey[500]),
//                       ),
//                       style: TextStyle(fontSize: 14),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 16),
//
//             // Divider
//             Divider(color: Colors.grey[300]),
//             SizedBox(height: 8),
//
//             // Available Members List
//             SizedBox(
//               height: 250,
//               child: ListView.builder(
//                 itemCount: widget.availableMembers.length,
//                 itemBuilder: (context, index) {
//                   final member = widget.availableMembers[index];
//                   final isSelected = selectedMembers.any((m) => m['id'] == member['id']);
//
//                   return Column(
//                     children: [
//                       ListTile(
//                         contentPadding: EdgeInsets.zero,
//                         leading: CircleAvatar(
//                           radius: 20,
//                           backgroundColor: Colors.blue[100],
//                           foregroundImage: AssetImage("assets/images/dummy_child_user_image.png"),
//                         ),
//                         title: Text(
//                           member['name'],
//                           style: TextStyle(
//                             fontSize: 14,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                         subtitle: Text(
//                           member['role'],
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                         trailing: Checkbox(
//                           value: isSelected,
//                           onChanged: (value) {
//                             setState(() {
//                               if (value == true) {
//                                 selectedMembers.add(member);
//                               } else {
//                                 selectedMembers.removeWhere((m) => m['id'] == member['id']);
//                               }
//                             });
//                           },
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(4),
//                           ),
//                           activeColor: Colors.blueAccent,
//                         ),
//                       ),
//                       if (index < widget.availableMembers.length - 1)
//                         Divider(color: Colors.grey[200], height: 1),
//                     ],
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         TextButton(
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//           child: Text(
//             'CANCEL',
//             style: TextStyle(
//               color: Colors.grey[600],
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//         ElevatedButton(
//           onPressed: () {
//             if (selectedMembers.isNotEmpty) {
//               Navigator.of(context).pop(); // Close dialog first
//               // Call the callback to add members
//               widget.onMembersAdded(selectedMembers);
//             } else {
//               // Show warning if no members selected
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text('Please select at least one member'),
//                   backgroundColor: Colors.orange,
//                   duration: Duration(seconds: 2),
//                 ),
//               );
//             }
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.blueAccent,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(8),
//             ),
//           ),
//           child: Text(
//             'ADD',
//             style: TextStyle(
//               color: Colors.white,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//       ],
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//     );
//   }
// }







import 'package:askfemi/utils/app_colors.dart';
import 'package:askfemi/utils/app_texts_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../ugc_home/ugc_task_details/ugc_task_model/ugc_sub_task_model.dart';

class UgcSingleOrCollaborativeTaskScreen extends StatefulWidget {
  const UgcSingleOrCollaborativeTaskScreen({super.key});

  @override
  State<UgcSingleOrCollaborativeTaskScreen> createState() =>
      _UgcSingleOrCollaborativeTaskScreenState();
}

class _UgcSingleOrCollaborativeTaskScreenState
    extends State<UgcSingleOrCollaborativeTaskScreen> {
  final TextEditingController titleController =
  TextEditingController(text: 'UI/UX Design');
  final TextEditingController descriptionController = TextEditingController(
      text:
      'Finish exercises 1–10 from chapter 5\nThis call is scheduled to align the design team on current progress.');
  final TextEditingController dateTimeController = TextEditingController();

  // List of members
  List<Map<String, dynamic>> members = [
    {'id': '1', 'name': 'Alex', 'role': 'Secondary'},
    {'id': '2', 'name': 'John Doe', 'role': 'Primary'},
    {'id': '3', 'name': 'Janex', 'role': 'Secondary'},
    {'id': '4', 'name': 'Mike', 'role': 'Secondary'},
  ];

  // Available members for selection
  List<Map<String, dynamic>> availableMembers = [
    {'id': '5', 'name': 'Sarah Johnson', 'role': 'Primary'},
    {'id': '6', 'name': 'Robert Wilson', 'role': 'Secondary'},
    {'id': '7', 'name': 'Emily Brown', 'role': 'Secondary'},
    {'id': '8', 'name': 'Michael Davis', 'role': 'Secondary'},
    {'id': '9', 'name': 'Jessica Miller', 'role': 'Secondary'},
  ];

  // Subtask related variables
  final List<UgcSubTask> _subTasks = [];
  final List<TextEditingController> _subtaskControllers = [];
  final List<FocusNode> _subtaskFocusNodes = [];

  bool _isCollaborativeTask = true; // Track if it's collaborative or single
  bool _showMembers = true; // Track if members section is expanded

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    dateTimeController.dispose();
    for (final controller in _subtaskControllers) {
      controller.dispose();
    }
    for (final node in _subtaskFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  // Toggle between collaborative and single task
  void _toggleTaskType() {
    setState(() {
      _isCollaborativeTask = !_isCollaborativeTask;
    });
  }

  // Toggle members visibility
  void _toggleMembersVisibility() {
    setState(() {
      _showMembers = !_showMembers;
    });
  }

  // Show Add Member Dialog
  void _showAddMemberDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddMemberDialog(
          availableMembers: availableMembers,
          onMembersAdded: (selectedMembers) {
            // This callback will be called when members are added
            _handleMembersAdded(selectedMembers);
          },
        );
      },
    );
  }

  // Handle members added from dialog
  void _handleMembersAdded(List<Map<String, dynamic>> selectedMembers) {
    setState(() {
      // Add selected members to the main members list
      for (var member in selectedMembers) {
        // Check if member already exists
        if (!members.any((m) => m['id'] == member['id'])) {
          members.add(member);
        }
      }
      // Remove from available members
      availableMembers.removeWhere((member) =>
          selectedMembers.any((selected) => selected['id'] == member['id']));
      // Show members section
      _showMembers = true;
    });

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${selectedMembers.length} member(s) added successfully'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  // DATE & TIME METHODS COPIED FROM UgcPersonalTaskScreen - Modified to not auto-select
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
          dateTimeController.text =
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

  // Handle remove member
  void _handleRemove(String memberId) {
    setState(() {
      final removedMember = members.firstWhere((member) => member['id'] == memberId);
      members.removeWhere((member) => member['id'] == memberId);

      // Add back to available members if not already there
      if (!availableMembers.any((m) => m['id'] == removedMember['id'])) {
        availableMembers.add(removedMember);
      }
    });
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
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Create Task',
          style: AppTextStyles.smallHeading.copyWith(fontSize: 22),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add New Task',
              style: AppTextStyles.largeHeading,
            ),
            const SizedBox(height: 6),
            Text(
              'You can add 3 to 5 more tasks today!',
              style: AppTextStyles.defaultTextStyle,
            ),
            const SizedBox(height: 24),

            /// Task Title
            _label('Task Title'),
            _inputField(controller: titleController),

            const SizedBox(height: 20),

            /// Task Description
            _label('Task Description'),
            _inputField(
              controller: descriptionController,
              maxLines: 4,
            ),

            const SizedBox(height: 20),

            /// Date Time - EMPTY INITIALLY, user must select manually
            _label('Task Date & Time'),
            const SizedBox(height: 12),
            TextField(
              controller: dateTimeController,
              readOnly: true,
              onTap: _selectDateTime,
              cursorColor: AppColors.primaryColor,
              decoration: InputDecoration(
                hintText: 'Select Date & Time',
                hintStyle: AppTextStyles.defaultTextStyle.copyWith(color: AppColors.grey),
                filled: true,
                fillColor: AppColors.backgroundColor,
                suffixIcon:  Icon(Icons.access_time, color: AppColors.iconColor),
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
            ),

            const SizedBox(height: 24),

            /// Collaborative/Single Task Section - SWAPPABLE
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.blueAccent,
                  style: BorderStyle.solid,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Swappable Header
                  Row(
                    children: [
                      Text(
                        _isCollaborativeTask ? 'Collaborative Task' : 'Single Assignment',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: _toggleTaskType,
                        child: Icon(
                          _isCollaborativeTask
                              ? Icons.swap_vert_outlined
                              : Icons.swap_vert_outlined,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),

                  // Always show Add Member button for both task types
                  const SizedBox(height: 12),

                  /// Members - Only shown when _showMembers is true (for both task types)
                  if (_showMembers && members.isNotEmpty)
                    Wrap(
                      alignment: WrapAlignment.start,
                      spacing: 8,
                      runSpacing: 8,
                      children: members.map((member) {
                        return Container(
                          constraints: const BoxConstraints(maxWidth: 140),
                          child: _memberChip(
                            key: ValueKey(member['id']),
                            memberId: member['id'],
                            name: member['name'],
                            role: member['role'],
                            onRemove: _handleRemove,
                          ),
                        );
                      }).toList(),
                    ),

                  if (_showMembers && members.isEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'No members added yet',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),

                  const SizedBox(height: 12),

                  /// Add Member Button - Always shown for both task types
                  SizedBox(
                    width: double.infinity,
                    height: 44,
                    child: ElevatedButton.icon(
                      onPressed: _showAddMemberDialog,
                      icon: const Icon(Icons.add, color: AppColors.white),
                      label: Text(
                        'Add Member',
                        style: AppTextStyles.defaultTextStyle
                            .copyWith(color: AppColors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// Subtasks list
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

            /// Add Sub Task Button
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

            const SizedBox(height: 24),

            /// Create Task Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF60A5FA),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child:  Text(
                  'Create Task',
                  style: AppTextStyles.defaultTextStyle.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Helpers

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: AppTextStyles.smallHeading.copyWith(fontSize: 14),
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.backgroundColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.grey, width: 2),
        ),
      ),
    );
  }

  // Updated _memberChip widget with internal removal logic
  Widget _memberChip({
    Key? key,
    required String memberId,
    required String name,
    required String role,
    required Function(String) onRemove,
    String? imagePath,
  }) {
    return _MemberChipInternal(
      key: key,
      memberId: memberId,
      name: name,
      role: role,
      imagePath: imagePath,
      onRemove: onRemove,
    );
  }
}

// Internal stateful widget for handling removal animation with crown icon
class _MemberChipInternal extends StatefulWidget {
  final String memberId;
  final String name;
  final String role;
  final String? imagePath;
  final Function(String) onRemove;

  const _MemberChipInternal({
    Key? key,
    required this.memberId,
    required this.name,
    required this.role,
    required this.onRemove,
    this.imagePath,
  }) : super(key: key);

  @override
  State<_MemberChipInternal> createState() => __MemberChipInternalState();
}

class __MemberChipInternalState extends State<_MemberChipInternal> {
  bool _isRemoving = false;

  void _handleRemove() {
    if (_isRemoving) return;

    setState(() {
      _isRemoving = true;
    });

    // Wait for animation to complete, then notify parent
    Future.delayed(const Duration(milliseconds: 300), () {
      widget.onRemove(widget.memberId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: _isRemoving ? 0 : 1,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 12,
              backgroundImage: widget.imagePath != null
                  ? AssetImage(widget.imagePath!)
                  : const AssetImage("assets/images/dummy_child_user_image.png")
              as ImageProvider,
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(fontSize: 11),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  // Role row with crown SVG for Primary
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.role.toLowerCase() == 'primary')
                        Padding(
                          padding: const EdgeInsets.only(right: 2),
                          child: SvgPicture.asset(
                            'assets/icons/crown.svg',
                            width: 10,
                            height: 10,
                            // color: Colors.amber,
                          ),
                        ),
                      Text(
                        widget.role,
                        style: const TextStyle(fontSize: 9, color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
            GestureDetector(
              onTap: _handleRemove,
              child: const Icon(Icons.close, size: 14, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

// Updated Dialog Widget with crown icon for Primary role
class AddMemberDialog extends StatefulWidget {
  final List<Map<String, dynamic>> availableMembers;
  final Function(List<Map<String, dynamic>>) onMembersAdded;

  const AddMemberDialog({
    super.key,
    required this.availableMembers,
    required this.onMembersAdded,
  });

  @override
  State<AddMemberDialog> createState() => _AddMemberDialogState();
}

class _AddMemberDialogState extends State<AddMemberDialog> {
  List<Map<String, dynamic>> selectedMembers = [];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsPadding: const EdgeInsets.all(8),
      backgroundColor: AppColors.backgroundColor,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Collaborative Task',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Team Members (${widget.availableMembers.length})',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: AppColors.grey),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, size: 20, color: Colors.grey[600]),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search Member',
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey[500]),
                      ),
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Divider
            Divider(color: Colors.grey[300]),
            const SizedBox(height: 8),

            // Available Members List
            SizedBox(
              height: 250,
              child: ListView.builder(
                itemCount: widget.availableMembers.length,
                itemBuilder: (context, index) {
                  final member = widget.availableMembers[index];
                  final isSelected = selectedMembers.any((m) => m['id'] == member['id']);

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.blue[100],
                          foregroundImage: const AssetImage("assets/images/dummy_child_user_image.png"),
                        ),
                        title: Text(
                          member['name'],
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        subtitle: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (member['role'].toLowerCase() == 'primary')
                              Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: SvgPicture.asset(
                                  'assets/icons/crown.svg',
                                  width: 12,
                                  height: 12,
                                  // color: Colors.amber,
                                ),
                              ),
                            Text(
                              member['role'],
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        trailing: Checkbox(
                          value: isSelected,
                          onChanged: (value) {
                            setState(() {
                              if (value == true) {
                                selectedMembers.add(member);
                              } else {
                                selectedMembers.removeWhere((m) => m['id'] == member['id']);
                              }
                            });
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          activeColor: Colors.blueAccent,
                        ),
                      ),
                      if (index < widget.availableMembers.length - 1)
                        Divider(color: Colors.grey[200], height: 1),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'CANCEL',
            style: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (selectedMembers.isNotEmpty) {
              Navigator.of(context).pop(); // Close dialog first
              // Call the callback to add members
              widget.onMembersAdded(selectedMembers);
            } else {
              // Show warning if no members selected
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Please select at least one member'),
                  backgroundColor: Colors.orange,
                  duration: const Duration(seconds: 2),
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'ADD',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}