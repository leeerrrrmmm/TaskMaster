import 'package:flutter/material.dart';
import 'package:task_master/features/clock/clock_screen.dart';
import 'package:task_master/features/expense/presentation/expense_review_screen.dart';
import 'package:task_master/features/leave/presentation/leave_summary_screen.dart';
import 'package:task_master/features/main/screens/main_screen.dart/main_screen.dart';
import 'package:task_master/features/task/presentation/task_screen.dart';

/// Our Screen
const List<Widget> pages = [
  MainScreen(),
  ClockScreen(),
  TaskScreen(),
  ExpenseReviewScreen(),
  LeaveSummaryScreen(),
];

/// [BottomNavBar]
class BottomNavBar extends StatefulWidget {
  /// [BottomNavBar] constructor
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int curPage = 0;

  void onTabTapped(int index) {
    setState(() {
      curPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[curPage],
      bottomNavigationBar: Container(
        height: 90,
        decoration: const BoxDecoration(color: Color(0xff1c2020)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(5, (index) {
            final isSelected = index == curPage;

            final icons = [
              'assets/images/home.png',
              'assets/images/calendar.png',
              'assets/images/task.png',
              'assets/images/receip.png',
              'assets/images/last.png',
            ];

            final selectedIcons = [
              'assets/images/fHome.png',
              'assets/images/fCalendar.png',
              'assets/images/fTask.png',
              'assets/images/fReceip.png',
              'assets/images/fLayer.png',
            ];

            return Expanded(
              child: InkWell(
                onTap: () => onTabTapped(index),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      index == curPage ? selectedIcons[index] : icons[index],
                    ),

                    const SizedBox(height: 4),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 3,
                      width: isSelected ? 24 : 0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
