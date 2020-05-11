import 'package:flutter_modular/flutter_modular.dart';

class AuthGuard implements RouteGuard {

  @override
  bool canActivate(String url) {
    return true;
  }
}
