import 'package:task_master/features/profile/data/model/prof_info_model.dart';

/// [ProfileDataSource]
class ProfileDataSource {
  ///
  final List<ProfInfoModel> accountList = [
    ProfInfoModel(icon: 'assets/profile/user.png', text: 'My Work Profile'),
    ProfInfoModel(icon: 'assets/profile/folder.png', text: 'Office Assets'),
    ProfInfoModel(icon: 'assets/profile/money.png', text: 'Payroll & Task'),
    ProfInfoModel(icon: 'assets/profile/crown.png', text: 'Roles'),
  ];

  ///
  final List<ProfInfoModel> settingList = [
    ProfInfoModel(icon: 'assets/profile/settings.png', text: 'Change Password'),
    ProfInfoModel(icon: 'assets/profile/scroll.png', text: 'Versioning'),
    ProfInfoModel(icon: 'assets/profile/msg.png', text: 'FAQ an Help'),
    ProfInfoModel(icon: 'assets/profile/logout.png', text: 'Logout'),
  ];
}
