import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:task_master/core/theme/app_colors.dart';
import 'package:task_master/core/widget/gradient_button_widget.dart';
import 'package:task_master/features/leave/service/bloc/leave_bloc.dart';
import 'package:task_master/features/leave/widgets/header_widget.dart';
import 'package:task_master/features/leave/widgets/leave_category_widget.dart';
import 'package:task_master/features/leave/widgets/leave_info_widget.dart';
import 'package:task_master/features/leave/widgets/total_leave_widget.dart';

/// [LeaveSummaryScreen]
class LeaveSummaryScreen extends StatefulWidget {
  /// [LeaveSummaryScreen] constructor
  const LeaveSummaryScreen({super.key});

  @override
  State<LeaveSummaryScreen> createState() => _LeaveSummaryScreenState();
}

class _LeaveSummaryScreenState extends State<LeaveSummaryScreen> {
  int curPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey200,
      body: Stack(
        children: [
          const HeaderWidget(),
          Positioned.fill(
            top: 180,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 12.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const TotalLeaveWidget(),
                  const SizedBox(height: 16),
                  LeaveCategoryWidget(
                    curPage: curPage,
                    onTap: (val) {
                      setState(() {
                        curPage = val;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<LeaveBloc, LeaveState>(
                    builder: (_, state) {
                      return state is LeaveLoaded && state.leaves.isNotEmpty
                          ? Column(
                              children: [
                                ...List.generate(state.leaves.length, (i) {
                                  final data = state.leaves[i];

                                  final startLeave = DateFormat(
                                    'd MMMM',
                                  ).format(data.startLeave);

                                  final endLeave = DateFormat(
                                    'd MMMM',
                                  ).format(data.endLeave);

                                  final totalDays =
                                      data.endLeave
                                          .difference(data.startLeave)
                                          .inDays +
                                      1;

                                  return Container(
                                    width: double.infinity,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Column(
                                        spacing: 6,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                'assets/images/star.png',
                                              ),
                                            ],
                                          ),
                                          Container(
                                            width: double.infinity,
                                            height: 70,
                                            decoration: BoxDecoration(
                                              color: AppColors.grey100,
                                              border: Border.all(
                                                color: AppColors.grey200,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                8.0,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    spacing: 10,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        'Leave Date',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              AppColors.grey400,
                                                        ),
                                                      ),
                                                      Text(
                                                        '''$startLeave - $endLeave''',
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),

                                                  Column(
                                                    spacing: 10,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const Text(
                                                        'Total Leave',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              AppColors.grey400,
                                                        ),
                                                      ),
                                                      Text(
                                                        '$totalDays Days',
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ],
                            )
                          : const LeaveInfoWidget();
                    },
                  ),
                  const SizedBox(height: 20),
                  GradientButtonWidget(
                    btnText: 'Submit Leave',
                    onTap: () => context.pushNamed('submitLeave'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
