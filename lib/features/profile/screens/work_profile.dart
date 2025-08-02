import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:task_master/core/theme/app_colors.dart';
import 'package:task_master/core/widget/border_btn_widget.dart';
import 'package:task_master/core/widget/gradient_button_widget.dart';
import 'package:task_master/core/widget/large_text_form_field_widget.dart';
import 'package:task_master/core/widget/text_form_widget.dart';
import 'package:task_master/domain/auth/auth_facade.dart';
import 'package:task_master/domain/auth/auth_repository.dart';
import 'package:task_master/domain/auth/google_auth_service.dart';
import 'package:task_master/domain/user/user_repository.dart';
import 'package:task_master/features/profile/widget/dotted_box_widgetrdart';

/// [WorkProfile]
class WorkProfile extends StatefulWidget {
  /// [WorkProfile] constructor
  const WorkProfile({super.key});

  @override
  State<WorkProfile> createState() => _WorkProfileState();
}

class _WorkProfileState extends State<WorkProfile> {
  bool isUpdateProfile = false;
  bool isLoading = false;

  final authFacade = AuthFacade(
    AuthRepository(),
    GoogleAuthService(),
    UserRepository(),
  );

  ///
  final TextEditingController nameController = TextEditingController();

  ///
  final TextEditingController lastNameController = TextEditingController();

  ///
  final TextEditingController birthController = TextEditingController();

  ///
  final TextEditingController posController = TextEditingController();

  ///
  final TextEditingController countryController = TextEditingController();

  ///
  final TextEditingController? stateController = TextEditingController();

  ///
  final TextEditingController cityController = TextEditingController();

  ///
  final TextEditingController addressController = TextEditingController();
  void _showUpdateModalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        bool localIsLoading = false;
        bool localIsUpdated = false;

        return StatefulBuilder(
          builder: (context, setModalState) {
            Future<void> localStartFakeLoader() async {
              setModalState(() {
                localIsLoading = true;
              });

              await authFacade.updateDisplayName(
                nameController.text,
                lastNameController.text,
                posController.text,
                countryController.text,
                stateController?.text ?? '',
                cityController.text,
              );
              setModalState(() {
                localIsLoading = false;
                localIsUpdated = true;
              });
            }

            return ClipRRect(
              clipBehavior: Clip.none,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 52),
                    width: double.infinity,
                    height: localIsUpdated ? 263 : 350,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 42.0),
                      child: localIsUpdated
                          ? Column(
                              children: [
                                const Text(
                                  'Profile Updated!',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                    top: 18.0,
                                    bottom: 24.0,
                                  ),
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    '''Your profile has been successfully updated. We’re excited to see you take this step!''',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                GradientButtonWidget(
                                  btnText: 'Visit My Profile',
                                  onTap: () => context.goNamed('profile'),
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                Text(
                                  localIsLoading
                                      ? 'Accept your changes'
                                      : 'Update Profile',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 14),
                                if (localIsLoading)
                                  const Text(
                                    '"Small changes lead to big results."',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontStyle: FontStyle.italic,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                    top: 18.0,
                                    bottom: 30.0,
                                  ),
                                  child: Text(
                                    textAlign: TextAlign.center,
                                    '''Are you sure you want to update your profile? This will help us improve your experience and provide personalized features.''',
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                if (!localIsLoading)
                                  Column(
                                    children: [
                                      GradientButtonWidget(
                                        btnText: 'Yes, Update Profile',
                                        onTap: localStartFakeLoader,
                                      ),
                                      const SizedBox(height: 18.0),
                                      BorderBtnWidget(
                                        btnText: 'No, Let me check',
                                        onTap: () => Navigator.pop(context),
                                      ),
                                    ],
                                  )
                                else
                                  LoadingAnimationWidget.discreteCircle(
                                    color: AppColors.purple400,
                                    secondRingColor: AppColors.purple500,
                                    thirdRingColor: AppColors.purple600,
                                    size: 50,
                                  ),
                              ],
                            ),
                    ),
                  ),
                  Positioned(
                    top: -50,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: SizedBox(
                        height: 100,
                        child: Image.asset('assets/profile/updProf.png'),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height * 0.7;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.grey200,
        title: const Text(
          'My work Profile',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        leading: InkWell(
          onTap: context.pop,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0, left: 16.0),
            child: Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                color: AppColors.purple50,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: AppColors.purple500,
                ),
              ),
            ),
          ),
        ),
      ),
      backgroundColor: AppColors.grey300,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 16.0,
              ),
              child: WorkProfileForm(
                screenHeight: screenHeight,
                nameController: nameController,
                lastNameController: lastNameController,
                birthController: birthController,
                posController: posController,
                stateController: stateController,
                countryController: countryController,
                cityController: cityController,
                addressController: addressController,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 90,
              decoration: const BoxDecoration(color: AppColors.white),
              child: Center(
                child: GradientButtonWidget(
                  btnText: 'Update Profile',
                  onTap: () => _showUpdateModalSheet(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// [WorkProfileForm]
class WorkProfileForm extends StatelessWidget {
  /// [WorkProfileForm] constructor
  const WorkProfileForm({
    required this.nameController,
    required this.lastNameController,
    required this.birthController,
    required this.posController,
    required this.countryController,
    required this.cityController,
    required this.addressController,
    required this.screenHeight,
    this.stateController,
    super.key,
  });

  ///
  final double screenHeight;

  ///
  final TextEditingController nameController;

  ///
  final TextEditingController lastNameController;

  ///
  final TextEditingController birthController;

  ///
  final TextEditingController posController;

  ///
  final TextEditingController countryController;

  ///
  final TextEditingController? stateController;

  ///
  final TextEditingController cityController;

  ///
  final TextEditingController addressController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PersonalDataInfoWidget(
          height: screenHeight,
          nameController: nameController,
          lastNameController: lastNameController,
          birthController: birthController,
          posController: posController,
        ),
        const SizedBox(height: 16),
        AddressInfoWidget(
          countryController: countryController,
          stateController: stateController ?? '' as TextEditingController,
          cityController: cityController,
          addressController: addressController,
        ),
        const SizedBox(height: 100),
      ],
    );
  }
}

/// [PersonalDataInfoWidget]
class PersonalDataInfoWidget extends StatelessWidget {
  /// [PersonalDataInfoWidget] constructor
  const PersonalDataInfoWidget({
    required this.height,
    required this.nameController,
    required this.lastNameController,
    required this.birthController,
    required this.posController,
    super.key,
  });

  ///
  final double height;

  ///
  final TextEditingController nameController;

  ///
  final TextEditingController lastNameController;

  ///
  final TextEditingController birthController;

  ///
  final TextEditingController posController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.grey200,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Personal Data Information',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'Your personal data information',
                    style: TextStyle(fontSize: 14, color: AppColors.grey500),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DottedBoxWidget(
                  onTap: () {
                    // TODO Make upload photo logic
                  },
                ),
                const Text(
                  'Upload Photo',
                  style: TextStyle(fontSize: 12, color: AppColors.grey600),
                ),
                const Text(
                  textAlign: TextAlign.center,
                  '''Format should be in .jpeg .png at least\n800x800px and less than 5MB''',
                  style: TextStyle(fontSize: 10, color: AppColors.grey500),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          TextFormWidget(
            text: 'First Name',
            hintText: 'UserName',
            controller: nameController,
            prefixIcon: Image.asset('assets/profile/rUser.png'),
          ),
          const SizedBox(height: 16),
          TextFormWidget(
            text: 'Last Name',
            hintText: 'User LastName',
            controller: lastNameController,
            prefixIcon: Image.asset('assets/profile/rUser.png'),
          ),
          const SizedBox(height: 16),
          TextFormWidget(
            text: 'Date of Birth',
            hintText: 'Date of Birth',
            controller: birthController,
            prefixIcon: Image.asset('assets/profile/calendar.png'),
          ),
          const SizedBox(height: 16),
          TextFormWidget(
            text: 'Position',
            hintText: 'Enter your position',
            controller: posController,
            prefixIcon: Image.asset('assets/profile/keyboard.png'),
          ),
        ],
      ),
    );
  }
}

/// [AddressInfoWidget]
class AddressInfoWidget extends StatelessWidget {
  /// [PersonalDataInfoWidget] constructor
  const AddressInfoWidget({
    required this.countryController,
    required this.stateController,
    required this.cityController,
    required this.addressController,
    super.key,
  });

  ///
  final TextEditingController countryController;

  ///
  final TextEditingController stateController;

  ///
  final TextEditingController cityController;

  ///
  final TextEditingController addressController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.grey200,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Address', style: TextStyle(fontWeight: FontWeight.bold)),
          const Text(
            'Your current domiclie',
            style: TextStyle(color: AppColors.grey500),
          ),
          const SizedBox(height: 16),
          TextFormWidget(
            text: 'Country',
            hintText: 'Ukraine',
            controller: countryController,
            prefixIcon: Image.asset('assets/profile/location.png'),
          ),
          const SizedBox(height: 16),
          TextFormWidget(
            text: 'State',
            hintText: 'Kharkiv obl.',
            controller: stateController,
            prefixIcon: Image.asset('assets/profile/location.png'),
          ),
          const SizedBox(height: 16),
          TextFormWidget(
            text: 'City',
            hintText: 'Kharkiv',
            controller: cityController,
            prefixIcon: Image.asset('assets/profile/location.png'),
          ),
          const SizedBox(height: 16),
          LargeTextFormFieldWidget(
            addressController: addressController,
            text: 'Full address',
            hintText: 'Enter your Full Address',
          ),
        ],
      ),
    );
  }
}
