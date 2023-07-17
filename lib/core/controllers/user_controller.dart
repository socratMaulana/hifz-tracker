import 'dart:convert';

import '../../core_imports.dart';

class UserController extends GetxController {
  final loggedInUser = <String, dynamic>{}.obs;

  Future<void> getCurrentLoggedInUser() async {
    final userJson = await Utils.readFromSecureStorage(key: Constants.userData);

    if (userJson != null) {
      loggedInUser(jsonDecode(userJson));
    }
  }

  setCurrentLoggedInUser(Map<String, dynamic> userData) async {
    await Utils.storeToSecureStorage(
      key: Constants.userData,
      data: jsonEncode(userData),
    );

    await getCurrentLoggedInUser();
  }

  @override
  void onInit() {
    getCurrentLoggedInUser();
    super.onInit();
  }
}
