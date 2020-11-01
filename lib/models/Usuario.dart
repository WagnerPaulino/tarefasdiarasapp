import 'dart:convert';

Usuario userFromJson(String str) => Usuario.fromJson(json.decode(str));

String userToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  String id;
  String displayName;
  String email;
  String photoUrl;

  Usuario(var signIn, {this.id, this.displayName, this.email, this.photoUrl}) {
    if (signIn != null) {
      this.id = signIn.id;
      this.displayName = signIn.displayName;
      this.email = signIn.email;
      this.photoUrl = signIn.photoUrl;
    }
  }

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
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
