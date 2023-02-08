import 'package:flutter/material.dart';
import 'package:hamro_app/features/auth/screens/signInScreen.dart';
import 'package:hamro_app/screens/form_screen.dart';
import 'package:hamro_app/screens/home.dart';
import 'package:routemaster/routemaster.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: SignInScreen()),
});

final loggedInRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: HomePage()),
  '/create-note/:authid': (route) =>
      MaterialPage(child: FormScreen(authId: route.pathParameters['authid']!))
});
