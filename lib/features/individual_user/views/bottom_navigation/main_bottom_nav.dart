// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import '../../../../utils/app_colors.dart';
// import '../add_task/add_task_screen.dart';
// import '../history/history_screen.dart';
// import '../home/home_screen.dart';
// import '../profile/profile_screen.dart';
//
// class MainBottomNav extends StatefulWidget {
//   const MainBottomNav({super.key});
//
//   @override
//   State<MainBottomNav> createState() => _MainBottomNavState();
// }
//
// class _MainBottomNavState extends State<MainBottomNav> {
//   int _selectedIndex = 0;
//
//   /// Screens list
//   final List<Widget> _screens = [
//     const HomeScreen(),
//     const AddTaskScreen(),
//     const HistoryScreen(),
//     const ProfileScreen(),
//   ];
//
//   /// Custom navigation items data
//   final List<Map<String, dynamic>> _navItems = [
//     {
//       'icon': 'assets/icons/home_inactive.svg',
//       'activeIcon': 'assets/icons/home_active.svg',
//       'label': 'Home',
//     },
//     {
//       'icon': 'assets/icons/add_inactive.svg',
//       'activeIcon': 'assets/icons/add_active.svg',
//       'label': 'Add',
//     },
//     {
//       'icon': 'assets/icons/history.svg',
//       'activeIcon': 'assets/icons/history.svg',
//       'label': 'History',
//     },
//     {
//       'icon': 'assets/icons/profile_inactive.svg',
//       'activeIcon': 'assets/icons/profile_active.svg',
//       'label': 'Profile',
//     },
//
//   ];
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.backgroundColor,
//       body: IndexedStack(
//         index: _selectedIndex,
//         children: _screens,
//       ),
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
//         child: Container(
//           height: 90.0,
//           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
//           decoration: BoxDecoration(
//             color: AppColors.mainBottomNavColor,
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: Row(
//             children: List.generate(_navItems.length, (index) {
//               final item = _navItems[index];
//               final isSelected = _selectedIndex == index;
//
//               return Expanded(
//                 child: GestureDetector(
//                   onTap: () => _onItemTapped(index),
//                   child: Container(
//                     margin: const EdgeInsets.symmetric(horizontal: 2),
//                     decoration: BoxDecoration(
//                       color: isSelected ? AppColors.primaryColor : Colors.transparent,
//                       borderRadius: BorderRadius.circular(6),
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           item['label'],
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w500,
//                             color: isSelected ? AppColors.white : Colors.grey,
//                             fontFamily: 'Plus Jakarta Sans',
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         SvgPicture.asset(
//                           isSelected ? item['activeIcon'] : item['icon'],
//                           width: 30,
//                           height: 30,
//                           colorFilter: ColorFilter.mode(
//                             isSelected ? AppColors.white : Colors.grey,
//                             BlendMode.srcIn,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             }),
//           ),
//         ),
//       ),
//     );
//   }
//
// }









import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../utils/app_colors.dart';
import '../add_task/add_task_screen.dart';
import '../history/history_screen.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';

class MainBottomNav extends StatefulWidget {
  const MainBottomNav({super.key});

  @override
  State<MainBottomNav> createState() => _MainBottomNavState();
}

class _MainBottomNavState extends State<MainBottomNav> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const AddTaskScreen(),
    const HistoryScreen(),
    const ProfileScreen(),
  ];

  final List<Map<String, dynamic>> _navItems = [
    {
      'icon': 'assets/icons/home_inactive.svg',
      'activeIcon': 'assets/icons/home_active.svg',
      'label': 'Home',
    },
    {
      'icon': 'assets/icons/add_inactive.svg',
      'activeIcon': 'assets/icons/add_active.svg',
      'label': 'Add',
    },
    {
      'icon': 'assets/icons/history.svg',
      'activeIcon': 'assets/icons/history.svg',
      'label': 'History',
    },
    {
      'icon': 'assets/icons/profile_inactive.svg',
      'activeIcon': 'assets/icons/profile_active.svg',
      'label': 'Profile',
    },
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 8, 14, 8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.mainBottomNavColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: List.generate(_navItems.length, (index) {
                final item = _navItems[index];
                final isSelected = _selectedIndex == index;

                return Expanded(
                  child: GestureDetector(
                    onTap: () => _onItemTapped(index),
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primaryColor
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item['label'],
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: isSelected
                                  ? AppColors.white
                                  : Colors.grey,
                              fontFamily: 'Plus Jakarta Sans',
                            ),
                          ),
                          const SizedBox(height: 4),
                          SvgPicture.asset(
                            isSelected
                                ? item['activeIcon']
                                : item['icon'],
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(
                              isSelected
                                  ? AppColors.white
                                  : Colors.grey,
                              BlendMode.srcIn,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}