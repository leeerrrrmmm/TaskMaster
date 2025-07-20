// import 'package:flutter/material.dart';
// import 'package:task_master/core/theme/app_colors.dart';
// import 'package:task_master/features/widget/border_btn_widget.dart';
// import 'package:task_master/features/widget/gradient_button_widget.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';

// /// [MainModalSheetInfo]
// class MainModalSheetInfo extends StatelessWidget {
//   /// [MainModalSheetInfo] constructor
//   const MainModalSheetInfo({
//     required this.isUpdateProfile,
//     required this.isLoading,
//     required this.onTap,
//     super.key,
//   });

//   ///
//   final bool isUpdateProfile;

//   ///
//   final bool isLoading;

//   ///
//   final void Function()? onTap;
//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       clipBehavior: Clip.none,
//       child: Stack(
//         clipBehavior: Clip.none,
//         children: [
//           Container(
//             padding: const EdgeInsets.only(top: 52),
//             width: double.infinity,
//             height: 350,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 42.0),
//               child: !isUpdateProfile
//                   ? const Center(
//                       child: Text(
//                         'Привет',
//                         style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     )
//                   : Column(
//                       children: [
//                         const Text(
//                           'Update Profile',
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const Padding(
//                           padding: EdgeInsets.only(top: 18.0, bottom: 30.0),
//                           child: Text(
//                             textAlign: TextAlign.start,
//                             '''Are you sure you want to update your profile? This will help us improve your experience and provide personalized features.''',
//                             style: TextStyle(
//                               fontSize: 13,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                         if (!isLoading)
//                           Column(
//                             children: [
//                               GradientButtonWidget(
//                                 btnText: 'Yes, Update Profile',
//                                 onTap: onTap,
//                               ),
//                               const SizedBox(height: 18.0),
//                               BorderBtnWidget(
//                                 btnText: 'No, Let me check',
//                                 onTap: () => Navigator.pop(context),
//                               ),
//                             ],
//                           ),
//                         if (isLoading)
//                           LoadingAnimationWidget.discreteCircle(
//                             color: AppColors.purple400,
//                             size: 50,
//                           ),
//                       ],
//                     ),
//             ),
//           ),

//           // Top image stays the same
//           Positioned(
//             top: -50,
//             left: 0,
//             right: 0,
//             child: Center(
//               child: SizedBox(
//                 height: 100,
//                 child: Image.asset('assets/profile/updProf.png'),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
