import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as _fb_storage;

import 'package:mass_app/repositories/auth/model/auth_model.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthService({FirebaseAuth? firebaseAuth, FirebaseFirestore? firestore})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  Future<String> signInUser(String email, String password) async {
    var _userCre = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);

    return _userCre.user!.uid;
  }

  Future<String> registerUser(String email, String password, String username,
      String? phoneNumber) async {
    var _userCre = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);

    String _userId = _userCre.user!.uid;

    Massian _user = Massian(
      name: username,
      id: _userId,
      phoneNumber: phoneNumber ?? '',
      email: email,
    );

    await _firestore.collection('users').doc(_userId).set(_user.toMap());

    return _userId;
  }

  Future<Massian> getUserDetails(String userId) async {
    var _usersnap = await _firestore.collection('users').doc(userId).get();

    Massian _massian = Massian.fromMap(_usersnap);

    return _massian;
  }

  Future<void> updateMassian(String userId, Massian massian) async {
    await _firestore.collection('users').doc(userId).update(massian.toMap());
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String?> getUserId() async {
    return _firebaseAuth.currentUser?.uid;
  }

  Future<Massian> becomeV(String userId) async {
    var massian = _firestore.collection('users').doc(userId);
    await massian.set({'volunteer': true}, SetOptions(merge: true));

    return Massian.fromMap(await massian.get());
  }

  Future<Massian> beMember(String userId) async {
    var _usersnap = await _firestore.collection('users').doc(userId).get();

    Massian _massian = Massian.fromMap(_usersnap);

    await _firestore.collection('mem_register').doc(userId).set({
      'userId': _massian.id,
      'name': _massian.name,
      'phoneNo': _massian.phoneNumber,
      'email': _massian.email
    });

    return _massian;
  }

  Future<Massian> becomeDisc(String userId) async {
    var massian = _firestore.collection('users').doc(userId);
    await massian.set({'disciple': true}, SetOptions(merge: true));

    return Massian.fromMap(await massian.get());
  }

  Future<String> getImageUrl(String username, File image) async {
    _fb_storage.Reference reference =
        _fb_storage.FirebaseStorage.instance.ref().child('Massians/$username');
    _fb_storage.UploadTask uploadTask =
        reference.putData((await image.readAsBytes()).buffer.asUint8List());
    _fb_storage.TaskSnapshot snapshot = await uploadTask;

    String fileUrl = await snapshot.ref.getDownloadURL();
    return fileUrl;
  }

  Future resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
