// import 'dart:async';
//
// import 'package:blood_drive/model/app_user_model.dart';
// import 'package:blood_drive/model/blood_drive_model.dart';
// import 'package:blood_drive/model/blood_request_model.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/widgets.dart';
// import 'package:blood_drive/routeGenerator.dart';
//
// class FireStoreService {
//   static final FireStoreService _fireStoreService =
//       FireStoreService._internal();
//   FirebaseFirestore _db = FirebaseFirestore.instance;
//
//   FireStoreService._internal();
//
//   factory FireStoreService() {
//     return _fireStoreService;
//   }
//
//   /////////////BLOOD REQUESTS/////////////////
//   Stream<List<BloodRequest>> getBloodRequests() {
//     return _db.collection('bloodRequests').snapshots().map((snapshot) =>
//         snapshot.docs
//             .map((doc) => BloodRequest.fromMap(doc.data(), doc.id))
//             .toList());
//   }
//
//   Future<void> addBloodRequest(BloodRequest bloodRequest) {
//     // _db.collection('farmerReports').document().setData({"searchIndex" : indexList});
//     return _db.collection('bloodRequests').add(bloodRequest.toMap());
//   }
//
//   ///////////BLOOD DRIVES///////////////
//   Stream<List<BloodDrive>> getBloodDrives() {
//     return _db.collection('bloodDrives').snapshots().map((snapshot) => snapshot
//         .docs
//         .map((doc) => BloodDrive.fromMap(doc.data(), doc.id))
//         .toList());
//   }
//
//   Future<void> addBloodDrive(BloodDrive bloodDrive) {
//     var _currentUser = UserManagement().getCurrentUserID();
//     return _db.collection('bloodDrives').add(bloodDrive.toMap()).then((value) {
//       _db
//           .collection('bloodDrives')
//           .doc(value.id)
//           .collection('attendingUsers').doc(_currentUser)
//           .set({"UserName": "Default"});
//     });
//   }
//
//   Stream getSpecificBloodDrive(bloodDriveId) {
//     return _db.collection(
//         'bloodDrives').doc(
//         bloodDriveId).snapshots();
//   }
//   //---------------------blood request sub-collection---------------//
//   Future<void> addBloodDriveAttendee(docId, userName) {
//     var _currentUser = UserManagement().getCurrentUserID();
//     return _db
//         .collection('bloodDrives')
//         .doc(docId)
//         .collection('attendingUsers').doc(_currentUser)
//         .set({"UserName": userName}).then(
//             (value) {
//                print("addBloodRequestAttendee clicked");
//                return _db
//                    .collection('users')
//                    .doc(_currentUser)
//                    .collection('bloodDrivesAttending').doc(docId)
//                    .set({"BloodDrive": "Blood drive Location", "BloodDriveId": docId});
//             });
//   }
//
//   Stream retrieveBloodDriveAttendees(bloodDriveId) {
//     var _currentUser = UserManagement().getCurrentUserID();
//     return _db.collection(
//         'bloodDrives').doc(
//         bloodDriveId).collection('attendingUsers').doc(_currentUser).snapshots();
//   }
//   Future deleteBloodDriveAttendee (bloodDriveId) {
//     var _currentUser = UserManagement().getCurrentUserID();
//     return _db.collection(
//         'bloodDrives').doc(
//         bloodDriveId).collection('attendingUsers').doc(_currentUser).delete().then((value) {
//       _db.collection(
//           'users').doc(
//           _currentUser).collection('bloodDrivesAttending').doc(bloodDriveId).delete();
//       print("User Blood drive attending deleted successfully");
//     });
//   }
//
//   ///////////USERS///////////////
//
//   Stream<List<AppUser>> getAppUser() {
//     return _db.collection('users').snapshots().map((snapshot) => snapshot.docs
//         .map((doc) => AppUser.fromMap(doc.data(), doc.id))
//         .toList());
//   }
//
//   // Stream<List<AppUser>> getSpecificUserDetails() {
//   //   var _userEmail = 'vincemwaniki@gmail.com';
//   //   return _db.collection('users').where('email', isEqualTo: _userEmail).snapshots().map(
//   //           (snapshot) => snapshot.docs.map(
//   //               (doc) => AppUser.fromMap(doc.data(), doc.id)
//   //       ).toList()
//   //   );
//   // }
//
//   Stream<DocumentSnapshot> getSpecificUserDetails() {
//     var _currentUser = UserManagement().getCurrentUserID();
//
//     return FirebaseFirestore.instance
//         .collection("users")
//         .doc(_currentUser)
//         .snapshots();
//   }
//
//
//
//   Future<void> addAppUser(AppUser user, uid) {
//     return _db.collection('users').doc(uid).set(user.toMap());
//   }
//
//   //------------user Blood drives attending------------//
//   Stream retrieveUserBloodDrivesAttending() {
//     var _currentUser = UserManagement().getCurrentUserID();
//     return _db.collection(
//         'users').doc(
//         _currentUser).collection('bloodDrivesAttending').snapshots();
//   }
// //
// //
// // }
//
// }
//
// ///////////////////User Management///////////////////
// class UserManagement {
//   ///////////////////Authentication///////////////////
//   FirebaseAuth auth = FirebaseAuth.instance;
//
//   ///Getting current User/////////
//   getAuthState() async {
//     var theUser;
//     FirebaseAuth.instance.authStateChanges().listen((User user) {
//       if (user == null) {
//         print('User is currently signed out!');
//         theUser = null;
//       } else {
//         print('User is signed in!');
//         theUser = user;
//       }
//     });
//     return theUser;
//   }
//
//   Future<String> getCurrentUser() async {
//     var currentUser;
//     if (auth.currentUser != null) {
//       currentUser = auth.currentUser.email;
//       // print("The user id is:" + auth.currentUser.email);
//     }
//     return currentUser;
//   }
//
//   String getCurrentUserID() {
//     var currentUserID;
//     if (auth.currentUser != null) {
//       currentUserID = auth.currentUser.uid;
//       // print("The user id is:" + auth.currentUser.uid);
//     }
//     return currentUserID;
//   }
//
// ////Signing up new user (Email and Password )////////
//
//   createUser(email, password) async {
//     try {
//       UserCredential userCredential = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(email: email, password: password);
//       final User user = userCredential.user;
//       return user.uid;
//     } on FirebaseAuthException catch (e) {
//       if (e != null) {
//         return throw new CustomException(
//             "Firebase user creation error Exception");
//       }
//       if (e.code == 'weak-password') {
//         print('The password provided is too weak.');
//       } else if (e.code == 'email-already-in-use') {
//         print('The account already exists for that email.');
//       }
//     } catch (e) {
//       print(e);
//     }
//   }
//
// ////Logging in user////////
//
//   loginUser(email, password) async {
//     try {
//       UserCredential userCredential = await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: email, password: password);
//     } on FirebaseAuthException catch (e) {
//       if (e != null) {
//         return throw new CustomException("Firebase user login error Exception");
//       }
//       if (e.code == 'user-not-found') {
//         print('No user found for that email.');
//       } else if (e.code == 'wrong-password') {
//         print('Wrong password provided for that user.');
//       }
//     }
//   }
//
//   /////////Logout//////////
//   signOut() async {
//     return await FirebaseAuth.instance.signOut();
//   }
// }
//
// ///Custom Exception creation////////////
// class CustomException implements Exception {
//   String cause;
//
//   CustomException(this.cause);
// }
