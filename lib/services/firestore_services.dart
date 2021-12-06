import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  static final FireStoreService _fireStoreService =
      FireStoreService._internal();
  FirebaseFirestore _db = FirebaseFirestore.instance;

  FireStoreService._internal();

  factory FireStoreService() {
    return _fireStoreService;
  }

  ///////////Reports///////////////
  Stream retrieveReports() {
    return _db.collection('policeReports').snapshots();
  }
  Stream retriveReports() {
    return _db.collection('hospitalReports').snapshots();
  }
  Stream retrieveReport() {
    return _db.collection('fireReports').snapshots();
  }

  Future<void> addReports(
      var idNo, String incident, String county, String estate) {
    return _db.collection('policeReports').doc().set({
      "IdNo": idNo,
      "incident": incident,
      "county": county,
      "estate": estate
    });
  }
  Future<void> adReports(
      var idNo, String incident, String extent, String county, String estate) {
    return _db.collection('hospitalReports').doc().set({
      "IdNo": idNo,
      "incident": incident,
      "county": county,
      "estate": estate
    });
  }
  Future<void> adddReports(
      var idNo, String incident, String county, String estate) {
    return _db.collection('fireReports').doc().set({
      "IdNo": idNo,
      "incident": incident,
      "county": county,
      "estate": estate
    });
  }
}
