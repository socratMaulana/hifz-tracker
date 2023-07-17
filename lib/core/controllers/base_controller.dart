import '../../core_imports.dart';

class BaseController extends GetxController {
  final isLoading = false.obs;

  final searchCtr = TextEditingController();
  final userController = Get.find<UserController>();

  Future<RxMap<String, dynamic>> getCurrentLoggedInUser() async {
    await userController.getCurrentLoggedInUser();
    return userController.loggedInUser;
  }

  setCurrentLoggedInUser(Map<String, dynamic> userData) {
    userController.setCurrentLoggedInUser(userData);
  }

    Future<String?> getUserId() {
    return Utils.readFromSecureStorage(key: Constants.token);
  }

  bool isLoggedIn() => userController.loggedInUser.isNotEmpty;

  search({
    required String query,
    required RxList<Map<String, dynamic>> transactionList,
    required RxList<Map<String, dynamic>> masterList,
    required String fieldName,
  }) {
    transactionList(
      masterList
          .where((p0) => p0[fieldName].toLowerCase().contains(
                query.toLowerCase(),
              ))
          .toList(),
    );
  }

  @override
  void onInit() async {
    await userController.getCurrentLoggedInUser();
    super.onInit();
  }
}
