import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthenticationService{

  final FirebaseAuth _firebaseAuth;
  AuthenticationService(this._firebaseAuth);

  Stream <User> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signOut() async{
    await _firebaseAuth.signOut();
  }
 Future<String> signin({String email,String password}) async{

   String _isCompanyOwner;

    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password).whenComplete(() => _getUserData(email).then((value) {
        _isCompanyOwner = value?"CompanyOwner":"Individual";
      }));
          return _isCompanyOwner;


  } on FirebaseAuthException catch(e){

      return e.message;
    }
  }

  Future<String> signup({String email,String password}) async{

    try{
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return "signed Up";


    }on FirebaseAuthException catch(e){
      return e.message;
    }
  }



  Future<bool> _getUserData(String email) async {
    var dbRef = FirebaseDatabase.instance.reference().child("Companies");
    var _isCompanyOwner = true;

    await dbRef
        .orderByChild("email")
        .equalTo(email)
        .once()
        .then((DataSnapshot snapshot) {
          assert (snapshot != null);
      if (snapshot.value != null) {
        _isCompanyOwner = true;
      } else {
        _isCompanyOwner = false;
      }
    });
    print("Company Owner getUserDataMethod: $_isCompanyOwner");
    return _isCompanyOwner;
  }
}