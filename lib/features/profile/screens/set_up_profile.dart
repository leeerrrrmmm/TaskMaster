import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_master/core/theme/app_colors.dart';
import 'package:task_master/features/profile/data/data_source/profile_data_source.dart';

/// [SetUpProfile]
class SetUpProfile extends StatefulWidget {
  /// [SetUpProfile] constructor
  const SetUpProfile({super.key});

  @override
  State<SetUpProfile> createState() => _SetUpProfileState();
}

class _SetUpProfileState extends State<SetUpProfile> {
  final items = ProfileDataSource();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff795ffc),
      body: Stack(
        children: [
          /// Container
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: const BoxDecoration(
                color: AppColors.white,

                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Column(
                  children: [
                    const SizedBox(height: 70),
                    const Text(
                      'Tonald Drump',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Text(
                      'Tonald@work.com',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.purple500,
                      ),
                    ),

                    CenterElements(blocText: 'Account', items: items),
                    CenterElements(blocText: 'Settings', items: items),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            top: 170,
            left: 150,
            right: 150,
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Image.asset('assets/profile/pImg.png'),
            ),
          ),
        ],
      ),
    );
  }
}

/// [CenterElements]
class CenterElements extends StatelessWidget {
  /// [CenterElements] constructor
  const CenterElements({
    required this.blocText,
    required this.items,
    super.key,
  });

  ///
  final String blocText;

  ///
  final ProfileDataSource items;

  @override
  Widget build(BuildContext context) {
    final data = blocText == 'Account' ? items.accountList : items.settingList;

    return Padding(
      padding: const EdgeInsets.only(top: 40.0, bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            blocText,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          Container(
            width: double.infinity,
            height: 170,
            decoration: BoxDecoration(
              color: const Color(0xfff4f6f9),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 6.5,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  data.length,
                  (i) => InkWell(
                    onTap: () {
                      context.pushNamed('workProfile');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(data[i].icon, width: 24, height: 24),
                            const SizedBox(width: 10),
                            Text(
                              items.accountList[i].text,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
