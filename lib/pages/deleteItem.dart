import 'dart:convert';

import 'package:e_commerce_app/pages/tokenProvider.dart';
import 'package:e_commerce_app/util/appbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Deleteitem extends StatefulWidget {
  const Deleteitem({super.key});

  @override
  State<Deleteitem> createState() => _DeleteitemState();
}

class _DeleteitemState extends State<Deleteitem> {
  final GlobalKey<FormState> _deleteKey = GlobalKey<FormState>();
  final TextEditingController _productIDController = TextEditingController();

  void deleteitem() async {
    final String? token = Provider.of<Tokenprovider>(
      context,
      listen: false,
    ).token;
    if (_deleteKey.currentState!.validate()) {
      int prodID = int.parse(_productIDController.text);

      String addItemUrl = 'http://localhost:8081/api/products/${prodID}';
      var response = await http.delete(
        Uri.parse(addItemUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode != 200) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Something went wrong !")));
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Product Deleted Successfully")));
      }

      resetField();
    }
  }

  void resetField() {
    _productIDController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(title: 'Add Item'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _deleteKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _productIDController,
                decoration: InputDecoration(
                  labelText: 'Product ID',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter a Product ID";
                  }
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: deleteitem,
                    child: Text('Delete Item'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: resetField,
                    child: Text("Reset Fields"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
