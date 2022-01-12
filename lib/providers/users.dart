import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sum/Models/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProvider with ChangeNotifier {
  bool _isLoading = false;

  UserModel _authenticatedUser;
  UserModel get authenticatedUser {
    return _authenticatedUser;
  }

  Future<void> initMyApp() async {
    await initFirebase();
    await updateToken();
  }

  Future<FirebaseApp> initFirebase() async {
    FirebaseApp response;
    response = await Firebase.initializeApp();
    return response;
  }

  Future<Map<String, dynamic>> register(Map<String, dynamic> user) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: user['email'], password: user['password']);

      user.remove('password');
      user.putIfAbsent("uid", () => userCredential.user.uid);
      await addUser(userCredential.user.uid, user);

      signOut();
      return {'success': true, 'message': "Created !"};
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return {
          'success': false,
          'message': "The password provided is too weak."
        };
      } else if (e.code == 'email-already-in-use') {
        return {
          'success': false,
          'message': "The account already exists for that email."
        };
      }
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>> signIn(Map<String, dynamic> user) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: user['email'], password: user['password']);

      String token = await userCredential.user.getIdToken();

      _authenticatedUser = UserModel(
          uid: userCredential.user.uid,
          email: userCredential.user.email,
          token: token);
      getUserDetails();

      return {'success': true, 'message': "Logged"};
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return {'success': false, 'message': "No user found for that email."};
      } else if (e.code == 'wrong-password') {
        return {
          'success': false,
          'message': "Wrong password provided for that user."
        };
      }
    }
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    _authenticatedUser = null;

    notifyListeners();
  }

  void currentUser() {
    User currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      _authenticatedUser = UserModel(
          uid: currentUser.uid,
          email: currentUser.email,
          token: currentUser.refreshToken);
    }

    notifyListeners();
  }

  Future<void> addUser(String uid, Map<String, dynamic> user) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .set(user)
        .catchError((e) {
      print(e);
    });
  }

  void getUserDetails() async {
    DocumentSnapshot userDetailsDSnapchot = await FirebaseFirestore.instance
        .collection("Users")
        .doc(_authenticatedUser.uid)
        .get();

    print(userDetailsDSnapchot.data());
    _authenticatedUser = UserModel.fromJson(userDetailsDSnapchot.data());

    notifyListeners();
  }

  Future<void> updateUser(String docId) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(docId)
        .update({'company': 'Stokes and Sons'})
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> deletUser(String docId) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(docId)
        .delete()
        .then((value) => print("User deleted"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future<void> deletAccount() async {
    try {
      await FirebaseAuth.instance.currentUser
          .delete()
          .then((value) => deletUser(authenticatedUser.uid));
      _authenticatedUser = null;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        print(
            'The user must reauthenticate before this operation can be executed.');
      }
    }
  }

  Future<User> signInWithGoogle(BuildContext context) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User user;

    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential =
            await auth.signInWithPopup(authProvider);

        user = userCredential.user;
      } catch (e) {
        print(e);
      }
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential =
              await auth.signInWithCredential(credential);

          user = userCredential.user;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            // ...
          } else if (e.code == 'invalid-credential') {
            // ...
          }
        } catch (e) {
          // ...
        }
      }
    }

    return user;
  }

  Future<void> updateToken() async {
    User currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      print("tess");
      String token = await currentUser.getIdToken(true);
        _authenticatedUser = UserModel(
            uid: currentUser.uid, email: currentUser.email, token: token);
        getUserDetails();

    } else {
      _authenticatedUser = null;
      return;
    }
    notifyListeners();
  }
}
