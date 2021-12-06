import 'package:firebase_auth/firebase_auth.dart';
import 'package:report_system/models/user.dart';
import 'package:report_system/services/auth/database.dart';

class Authenticate {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Users _userFromFirebaseUser(User user){
    return user != null ? Users(uid: user.uid) : null;
  }

  Stream<Users> get user{
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }
  //sign in anon
  // Future anon() async {
  //   try{
  //     UserCredential result = await _auth.signInAnonymously();
  //     User user = result.user;
  //     return _userFromFirebaseUser(user);
  //   }catch(e){
  //     print(e.toString());
  //     return null;
  //   }
  // }
  //sign in with email & pass
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password,);
      User user= result.user;
      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }


  //register with email &and pass
  Future registerWithEmailAndPassword(String name, String email, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password,);
      User user= result.user;

      //create a new doc
      await DatabaseService(uid: user.uid).updateUserData('$name', 'Kenya', '$email');
      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }
}