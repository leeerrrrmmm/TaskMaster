import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:task_master/core/theme/app_colors.dart';
import 'package:task_master/domain/auth/auth_facade.dart';
import 'package:task_master/domain/auth/auth_repository.dart';
import 'package:task_master/domain/auth/google_auth_service.dart';
import 'package:task_master/domain/user/user_repository.dart';
import 'package:task_master/features/profile/data/data_source/profile_data_source.dart';

/// [Profile]
class Profile extends StatefulWidget {
  /// [Profile] constructor
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final items = ProfileDataSource();

  final authFacade = AuthFacade(
    AuthRepository(),
    GoogleAuthService(),
    UserRepository(),
  );

  ///
  final List<String> contactList = [
    'assets/profile/sms.png',
    'assets/profile/fLoc.png',
  ];

  Map<String, dynamic>? userData;

  Future<void> loadUserData() async {
    final data = await authFacade.getAdditionalUserData();

    setState(() {
      userData = data;
    });
  }

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff795ffc),
      body: Stack(
        children: [
          Positioned(
            top: 60,
            left: 24,
            child: GestureDetector(
              onTap: () {
                context.goNamed('bottom');
              },
              child: Container(
                padding: const EdgeInsets.only(left: 5),
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),

                child: const Align(
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: AppColors.purple500,
                    size: 18,
                  ),
                ),
              ),
            ),
          ),

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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 70),
                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: (userData?['displayName']).toString(),
                            ),
                            const WidgetSpan(child: SizedBox(width: 10)),
                            TextSpan(text: (userData?['lastName']).toString()),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        (userData?['email']).toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.purple500,
                        ),
                      ),

                      TopElements(
                        blocText: 'CONTACT',
                        items: contactList,
                        userData: userData,
                      ),
                      CenterElements(blocText: 'ACCOUNT', items: items),
                      CenterElements(blocText: 'SETTINGS', items: items),
                    ],
                  ),
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
    final data = blocText == 'ACCOUNT' ? items.accountList : items.settingList;

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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                              blocText == 'ACCOUNT'
                                  ? items.accountList[i].text
                                  : items.settingList[i].text,
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

/// [TopElements]
class TopElements extends StatelessWidget {
  /// [TopElements] constructor
  const TopElements({
    required this.blocText,
    required this.items,
    required this.userData,
    super.key,
  });

  ///
  final String blocText;

  ///
  final List<String> items;

  ///
  final Map<String, dynamic>? userData;

  ///
  @override
  Widget build(BuildContext context) {
    final data = items;

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
            height: 90,
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  data.length,
                  (i) => InkWell(
                    onTap: () {
                      context.pushNamed('workProfile');
                    },
                    child: Row(
                      children: [
                        Image.asset(data[i], width: 24, height: 24),
                        const SizedBox(width: 10),
                        if (i == 0)
                          Text(
                            userData?['email'].toString() ??
                                'UserEmail@gmail.com',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                        if (i != 0)
                          Row(
                            children: [
                              Text(
                                userData?['displayName'].toString() ??
                                    'UserName',
                              ),
                              const SizedBox(width: 4),
                              Text(
                                userData?['lastName'].toString() ??
                                    'UserLastName',
                              ),
                            ],
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
