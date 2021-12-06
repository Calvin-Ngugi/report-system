import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:report_system/models/repo.dart';

class DatabaseService{

  //collection reference
  Future updateUserData(String email, String location, String name) async {
    return await reportCollection.doc(uid).set({
      'name': name,
      'location': location,
      'email': email,
    });
  }
  final String uid;

  DatabaseService({this.uid});

  final CollectionReference reportCollection = FirebaseFirestore.instance.collection('users');

  //report list from snapshot
  List<Report> _ListFromSnapShot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return Report(
          doc.data()['name'] ?? '',
          doc.data()['location'] ?? '',
          doc.data()['email'] ?? '',
      );
    }).toList();
  }

      //get reports stream
      Stream<List<Report>> get reports{
        return reportCollection.snapshots().map(_ListFromSnapShot);
  }
}