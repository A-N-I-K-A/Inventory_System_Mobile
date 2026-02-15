import 'package:e_commerce_app/pages/inventory.dart';
import 'package:e_commerce_app/pages/search.dart';
import 'package:e_commerce_app/util/appbar.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(title: 'E-Commerce Home'),
      body: Center(child: Text("Welcome to the E-Commerce App")),
    );
  }
}
