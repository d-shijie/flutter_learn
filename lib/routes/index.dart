import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/index/index.dart';
import '../pages/playlist-detail/index.dart';
import '../pages/login/index.dart';

final routes = {
  '/': (context) => Index(),
  '/login': (context) => Login(),
  '/playlistDetail': (context) => PlayListDetail(),
};



// Route routeGenrator(RouteSettings setting) {
//   // final name = setting.name;
//   // var builder = routes[name];
//   // builder ?? (context) => NotFound();
//   // final route = MaterialPageRoute(builder: builder, settings: setting);
//   // return route;
// }
