import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'app.dart';

void main() {
  GoRouter.optionURLReflectsImperativeAPIs = true;
  runApp(const App());
}