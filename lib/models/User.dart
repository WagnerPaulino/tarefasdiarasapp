import 'package:google_sign_in/google_sign_in.dart';
import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  String id;
  String displayName;
  String email;
  String photoUrl;

  User(var signIn, {this.id, this.displayName, this.email, this.photoUrl}) {
    if (signIn != null) {
      this.id = signIn.id;
      this.displayName = signIn.displayName;
      this.email = signIn.email;
      this.photoUrl = signIn.photoUrl;
    }
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        null,
        id: json["id"],
        displayName: json["displayName"],
        email: json["email"],
        photoUrl: json["photoUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "displayName": displayName,
        "email": email,
        "photoUrl": photoUrl,
      };
}
