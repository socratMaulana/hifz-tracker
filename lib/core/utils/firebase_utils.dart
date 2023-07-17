import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../core_imports.dart';

class FirebaseUtils {
  final firestore = Get.find<FirebaseFirestore>();
  final auth = Get.find<FirebaseAuth>();
  final storage = FirebaseStorage.instance;

  Future<DocumentReference<Map<String, dynamic>>> saveDataToFirestore(
      {required String collection, required dynamic data}) async {
    try {
      return await firestore.collection(collection).add(data);
    } on FirebaseException catch (e) {
      throw '${e.message}';
    } catch (e) {
      rethrow;
    }
  }

  saveDataToFirestoreWithDoc(
      {required String collection,
      required dynamic docName,
      required dynamic data}) async {
    try {
      return await firestore.collection(collection).doc(docName).set(data);
    } on FirebaseException catch (e) {
      throw '${e.message}';
    } catch (e) {
      rethrow;
    }
  }

  updateDataToFirestore(
      {required String collection,
      required dynamic docName,
      required dynamic data}) async {
    try {
      return await firestore.collection(collection).doc(docName).update(data);
    } on FirebaseException catch (e) {
      throw '${e.message}';
    } catch (e) {
      rethrow;
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getDataFromFirestore(
      {required String collection}) async {
    try {
      return await firestore.collection(collection).get();
    } on FirebaseException catch (e) {
      throw '${e.message}';
    } catch (e) {
      rethrow;
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDataFromFirestoreById(
      {required String collection, required String id}) async {
    try {
      return await firestore.collection(collection).doc(id).get();
    } on FirebaseException catch (e) {
      throw '${e.message}';
    } catch (e) {
      rethrow;
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getDataFromFirestoreWithArg(
      {required String collection,
      required String arg,
      required String value}) async {
    try {
      return await firestore
          .collection(collection)
          .where(arg, isEqualTo: value)
          .get();
    } on FirebaseException catch (e) {
      throw '${e.message}';
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential> register(
      {required String email, required String password}) async {
    try {
      return await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseException catch (e) {
      final message = e.message;

      if (message!.contains('already in use')) {
        throw 'Email telah digunakan!';
      }

      throw '${e.message}';
    } catch (e) {
      rethrow;
    }
  }

  Future<UserCredential> loginWithEmail(
      {required String email, required String password}) async {
    try {
      return await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseException catch (e) {
      final message = e.message;

      if (message!.contains('password is invalid')) {
        throw 'Username / Password salah!';
      }

      throw '${e.message}';
    } catch (e) {
      rethrow;
    }
  }

  Future<TaskSnapshot> storeFile(String path, File file) async {
    try {
      return await storage.ref(path).putFile(file);
    } on FirebaseException catch (e) {
      throw '${e.message}';
    } catch (e) {
      rethrow;
    }
  }

  deleteFromFirestore(String collection, String id) async {
    await firestore.collection(collection).doc(id).delete();
  }

  deleteFromStorage(String path) async {
    await storage.ref(path).delete();
  }

  listenFromFirestore(
      {required String collection,
      required Function(QuerySnapshot<Map<String, dynamic>> event) onListen,
      required Function onError}) {
    firestore
        .collection(collection)
        .snapshots()
        .listen(
          (event) => onListen(event),
        )
        .onError(
          (e) => onError(e),
        );
  }

  listenFromFirestoreWithArg(
      {required String collection,
      required String arg,
      required dynamic value,
      required Function(QuerySnapshot<Map<String, dynamic>> event) onListen,
      required Function(String e) onError}) {
    firestore
        .collection(collection)
        .where(arg, isEqualTo: value)
        .snapshots()
        .listen(
          (event) => onListen(event),
        )
        .onError(
          (e) => onError(e),
        );
  }
  
  listenFromFirestoreWithArgNotEqual(
      {required String collection,
      required String arg,
      required dynamic value,
      required Function(QuerySnapshot<Map<String, dynamic>> event) onListen,
      required Function(String e) onError}) {
    firestore
        .collection(collection)
        .where(arg, isNotEqualTo: value)
        .snapshots()
        .listen(
          (event) => onListen(event),
        )
        .onError(
          (e) => onError(e),
        );
  }

  Future<void> updatePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      final currentUser = auth.currentUser;
      final cred = EmailAuthProvider.credential(
          email: currentUser!.email!, password: oldPassword);

      await currentUser.reauthenticateWithCredential(cred);
      await currentUser.updatePassword(newPassword);
    } on FirebaseException catch (e) {
      throw '${e.message}';
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateEmail({
    required String password,
    required String newEmail,
  }) async {
    try {
      final currentUser = auth.currentUser;
      final cred = EmailAuthProvider.credential(
          email: currentUser!.email!, password: password);

      await currentUser.reauthenticateWithCredential(cred);
      await currentUser.updateEmail(newEmail);
    } on FirebaseException catch (e) {
      throw '${e.message}';
    } catch (e) {
      rethrow;
    }
  }
}
