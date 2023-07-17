import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hifz_tracker_teacher/core_imports.dart';
import 'package:hifz_tracker_teacher/features/dashboard/widgets/annoucment_widget.dart';
import 'package:hifz_tracker_teacher/features/dashboard/widgets/class_widget.dart';
import 'package:hifz_tracker_teacher/features/dashboard/widgets/dashboard_widget.dart';
import 'package:hifz_tracker_teacher/features/dashboard/widgets/profile_widget.dart';
import 'package:hifz_tracker_teacher/features/dashboard/widgets/teachers_widget.dart';
import 'package:hifz_tracker_teacher/features/login/login_binding.dart';
import 'package:hifz_tracker_teacher/features/login/login_screen.dart';
import 'package:image_picker/image_picker.dart';

import '../features/dashboard/widgets/chat_widget.dart';
import '../features/dashboard/widgets/students_widget.dart';

class DashboardController extends BaseController {
  final _titles = <String>[
    'Dashboard',
    'List Murid',
    'Chat',
    'List Guru',
    'List Kelas',
    'Pengumuman',
    'Profile'
  ];

  final _widgets = <Widget>[
    const DashboardWidget(),
    const StudentsWidget(),
    const ChatWidget(),
    const TeachersWidget(),
    const ClassWidget(),
    const AnnouncmentWidget(),
    const ProfileWidget(),
  ];

  final currentIndex = 0.obs;
  final currentTitle = 'Setoran Terkini'.obs;
  final Rx<Widget> currentWidget = Rx(const DashboardWidget());

  final masterStudents = <Map<String, dynamic>>[].obs;
  final students = <Map<String, dynamic>>[].obs;
  final masterTeachers = <Map<String, dynamic>>[].obs;
  final teachers = <Map<String, dynamic>>[].obs;
  final chats = <Map<String, dynamic>>[].obs;

  final updatePasswordLoading = false.obs;
  final updatePasswordKey = GlobalKey<FormState>();
  final updatePasswordOldCtr = TextEditingController();
  final updatePasswordCtr = TextEditingController();
  final updatePasswordConfirmCtr = TextEditingController();

  final updateEmailLoading = false.obs;
  final updateEmailKey = GlobalKey<FormState>();
  final updateEmailCtr = TextEditingController();
  final updateEmailPasswordCtr = TextEditingController();

  String? userId = '';
  bool isAdmin = false;

  setCurrentIndex(int index) {
    currentIndex(index);
    currentTitle(_titles[index]);
    currentWidget(_widgets[index]);

    searchCtr.clear();
  }

  searchStudent() {
    search(
        query: searchCtr.text,
        transactionList: students,
        masterList: masterStudents,
        fieldName: 'fullName');
  }

  searchTeacher() {
    search(
        query: searchCtr.text,
        transactionList: teachers,
        masterList: teachers,
        fieldName: 'fullName');
  }

  getStudents() {
    isLoading(true);

    FirebaseUtils().listenFromFirestore(
        collection: Constants.studentRef,
        onListen: (event) {
          isLoading(false);
          masterStudents.clear();
          students.clear();

          for (var element in event.docs) {
            final data = element.data();
            data['id'] = element.id;

            masterStudents.add(data);
            students.add(data);
          }
        },
        onError: (e) {
          isLoading(false);
          Utils.showGetSnackbar(e.toString(), false);
        });
  }

  deleteStudent(String id) async {
    try {
      await FirebaseUtils().deleteFromFirestore(Constants.studentRef, id);
      Get.back();
    } catch (e) {
      Get.back();
      Utils.showGetSnackbar(e.toString(), false);
    }
  }

  getTeachers() {
    isLoading(true);

    FirebaseUtils().listenFromFirestoreWithArgNotEqual(
        collection: Constants.teacherRef,
        arg: 'email',
        value: userController.loggedInUser['email'],
        onListen: (event) {
          isLoading(false);
          masterTeachers.clear();
          teachers.clear();

          for (var element in event.docs) {
            final data = element.data();
            data['id'] = element.id;

            if (data['isAdmin'] == false) {
              masterTeachers.add(data);
              teachers.add(data);
            }
          }
        },
        onError: (e) {
          isLoading(false);
          Utils.showGetSnackbar(e.toString(), false);
        });
  }

  deleteTeacher(String id) async {
    try {
      await FirebaseUtils().deleteFromFirestore(Constants.teacherRef, id);
      Get.back();
    } catch (e) {
      Get.back();
      Utils.showGetSnackbar(e.toString(), false);
    }
  }

  changeImage() async {
    final result = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 25);
    if (result != null) {
      isLoading(true);

      try {
        final currentUser = await getCurrentLoggedInUser();
        final response = await FirebaseUtils()
            .storeFile(currentUser['email'], File(result.path));
        final downloadUrl = await response.ref.getDownloadURL();

        await FirebaseUtils().updateDataToFirestore(
            collection: Constants.teacherRef,
            docName: currentUser['id'],
            data: {'imageUrl': downloadUrl});

        currentUser['imageUrl'] = downloadUrl;
        setCurrentLoggedInUser(currentUser);

        isLoading(false);
      } catch (e) {
        isLoading(false);
        Utils.showGetSnackbar(e.toString(), false);
      }
    }
  }

  updatePassword() async {
    if (!updatePasswordKey.currentState!.validate()) return;
    if (updatePasswordCtr.text != updatePasswordConfirmCtr.text) {
      throw 'Password tidak sama!';
    }

    updatePasswordLoading(true);
    try {
      await FirebaseUtils().updatePassword(
        oldPassword: updatePasswordOldCtr.text,
        newPassword: updatePasswordConfirmCtr.text,
      );

      Get.back();

      updatePasswordLoading(false);
      Utils.showGetSnackbar('Password telah diubah!', true);
    } catch (e) {
      updatePasswordLoading(false);
      Utils.showGetSnackbar(e.toString(), false);
    }
  }

  updateEmail() async {
    if (!updateEmailKey.currentState!.validate()) return;

    updateEmailLoading(true);
    try {
      await FirebaseUtils().updateEmail(
        password: updateEmailPasswordCtr.text,
        newEmail: updateEmailCtr.text,
      );

      Get.back();

      final loggedInUser = await getCurrentLoggedInUser();
      loggedInUser['email'] = updateEmailCtr.text;

      await FirebaseUtils().updateDataToFirestore(
          collection: Constants.teacherRef,
          docName: loggedInUser['id'],
          data: {'email': updateEmailCtr.text});

      setCurrentLoggedInUser(loggedInUser);

      updateEmailLoading(false);
      Utils.showGetSnackbar('Email telah diubah!', true);
    } catch (e) {
      updateEmailLoading(false);
      Utils.showGetSnackbar(e.toString(), false);
    }
  }

  getChats() async {
    isLoading(true);

    final teacherId = await Utils.readFromSecureStorage(key: Constants.token);

    FirebaseUtils()
        .firestore
        .collection(Constants.chatRef)
        .where('teacherId', isEqualTo: teacherId)
        .orderBy('lastSent', descending: true)
        .snapshots()
        .listen((event) {
      isLoading(false);
      chats.clear();
      for (var element in event.docs) {
        final data = element.data();
        data['id'];

        final studentData = students
            .firstWhere((student) => student['id'] == data['studentId']);
        data['studentData'] = studentData;

        chats.add(data);
      }
    }).onError((e) {
      isLoading(false);
      Utils.showGetSnackbar(e.toString(), false);
    });
  }

  logout() async {
    await FirebaseUtils().auth.signOut();
    Utils.clearSecureStorage();

    Get.offAll(
      () => const LoginScreen(),
      binding: LoginBinding(),
    );
  }

  final classes = <Map<String, dynamic>>[].obs;
  final masterClassStudents = <Map<String, dynamic>>[].obs;
  final classStudents = <Map<String, dynamic>>[].obs;

  final classCtr = TextEditingController();
  final classSearchCtr = TextEditingController();
  final isBotSheetLoading = false.obs;

  getClasses() async {
    isLoading(true);

    try {
      final classResponse =
          await FirebaseUtils().getDataFromFirestore(collection: 'classes');

      classes.clear();
      for (var element in classResponse.docs) {
        final data = element.data();
        data['id'] = element.id;

        classes.add(data);
      }

      final studentsResponse =
          await FirebaseUtils().getDataFromFirestore(collection: 'students');

      classStudents.clear();
      masterClassStudents.clear();

      for (var element in studentsResponse.docs) {
        final data = element.data();
        data['id'] = element.id;

        classStudents.add(data);
        masterClassStudents.add(data);
      }

      isLoading(false);
    } catch (e) {
      isLoading(false);
      Utils.showGetSnackbar(e.toString(), false);
    }
  }

  addClass() async {
    final name = classCtr.text;

    if (name.isEmpty) return;

    try {
      isBotSheetLoading(true);

      await FirebaseUtils().saveDataToFirestore(
          collection: 'classes', data: {'className': name});

      Get.back();
      Utils.showGetSnackbar('Sukses menambah kelas!', true);

      isBotSheetLoading(false);
    } catch (e) {
      isBotSheetLoading(false);
      Utils.showGetSnackbar(e.toString(), false);
    }
  }

  deleteClass({required String id}) async {
    Get.back();

    try {
      isLoading(true);
      await FirebaseUtils().deleteFromFirestore('classes', id);
      getClasses();
    } catch (e) {
      isLoading(false);
      Utils.showGetSnackbar(e.toString(), false);
    }
  }

  @override
  void onInit() async {
    userId = await getUserId();
    isAdmin = (await getCurrentLoggedInUser())['isAdmin'] ?? false;

    await getCurrentLoggedInUser();
    await getStudents();
    await getTeachers();
    await getChats();
    super.onInit();
  }
}
