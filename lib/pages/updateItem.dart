import 'dart:convert';

import 'package:e_commerce_app/pages/tokenProvider.dart';
import 'package:e_commerce_app/util/appbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Updateitem extends StatefulWidget {
  const Updateitem({super.key});

  @override
  State<Updateitem> createState() => _UpdateitemState();
}

class _UpdateitemState extends State<Updateitem> {
  final GlobalKey<FormState> _updateKey = GlobalKey<FormState>();
  final TextEditingController _productIDController = TextEditingController();
  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _productPriceController = TextEditingController();

  void updateitem() async {
    final String? token = Provider.of<Tokenprovider>(
      context,
      listen: false,
    ).token;

    if (_updateKey.currentState!.validate()) {
      int prodID = int.parse(_productIDController.text);
      int prodPrice = int.parse(_productPriceController.text);
      String prodName = _productNameController.text;

      String addItemUrl = 'http://localhost:8081/api/products';
      var response = await http.put(
        Uri.parse(addItemUrl),
        body: jsonEncode({
          'prodID': prodID,
          'prodName': prodName,
          'prodPrice': prodPrice,
        }),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode != 201) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Something went wrong !")));
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Product Updated Successfully")));
      }
      resetField();
    }
  }

  void resetField() {
    _productIDController.text = "";
    _productNameController.text = "";
    _productPriceController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(title: 'Update Item'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _updateKey,
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
              TextFormField(
                controller: _productNameController,
                decoration: InputDecoration(
                  labelText: "Updated Product Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter a Product Name";
                  }
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _productPriceController,
                decoration: InputDecoration(
                  labelText: "Updated Product Price",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please Enter a Product Price";
                  }
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: updateitem,
                    child: Text('Update Item'),
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
