import 'package:e_commerce_app/pages/home.dart';
import 'package:e_commerce_app/pages/index.dart';
import 'package:e_commerce_app/pages/tokenProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(debugShowCheckedModeBanner: false, home: Index());
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => Tokenprovider())],
      child: MaterialApp(debugShowCheckedModeBanner: false, home: Index()),
    );
  }
}
