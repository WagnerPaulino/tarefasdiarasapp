import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobx/mobx.dart';
import 'package:tarefasdiarasapp/models/User.dart';

part 'Usuario.g.dart';

// This is the class used by rest of your codebase
class UsuarioStore = UsuarioBase with _$UsuarioStore;

// The store-class

abstract class UsuarioBase with Store {

  @observable
  User user = null;
  
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  
  UsuarioStore() {
    firebaseAuth.onAuthStateChanged.listen((v) {
      user = User(v);
    });
    firebaseAuth.currentUser().then((v) {
      user = User(v);
    });
  }

  Future<GoogleSignInAccount> login() {
    return _googleSignIn.signIn();
  }

  Future<GoogleSignInAccount> logout() {
    return _googleSignIn.signOut();
  }

  GoogleSignIn getGoogleSignIn() {
    return _googleSignIn;
  }

  Future<bool> navTo(BuildContext context, String routeName) {
    _googleSignIn.isSignedIn().then((isLogged) {
      if (isLogged) {
        Navigator.pushNamed(context, routeName);
      } else {
        Navigator.pushReplacementNamed(context, "/loading");
      }
    });
  }
}
