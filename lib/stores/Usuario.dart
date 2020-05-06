import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Usuario {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

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
