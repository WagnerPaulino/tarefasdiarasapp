import 'package:flutter_modular/flutter_modular.dart';

class AuthGuard implements RouteGuard {
  var user;
  
  AuthGuard(this.user);

  @override
  bool canActivate(String url) {
    print(user);
    return true;
  }
}
