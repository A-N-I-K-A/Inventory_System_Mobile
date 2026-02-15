import 'dart:convert';

import 'package:e_commerce_app/pages/tokenProvider.dart';
import 'package:e_commerce_app/util/appbar.dart';
import 'package:e_commerce_app/util/showDialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final GlobalKey<FormState> _searchKey = GlobalKey<FormState>();
  final TextEditingController _productIDController = TextEditingController();

  void deleteitem() async {
    final String? token = Provider.of<Tokenprovider>(
      context,
      listen: false,
    ).token;
    if (_searchKey.currentState!.validate()) {
      int prodID = int.parse(_productIDController.text);

      String addItemUrl = 'http://localhost:8081/api/products/${prodID}';
      var response = await http.get(
        Uri.parse(addItemUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      print(response.statusCode);

      if (response.body.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Something went wrong !")));
      } else {
        var responseObj = jsonDecode(response.body);
        showDialog(
          context: context,
          builder: (context) {
            return Showdialog(
              prodID: responseObj['prodID'],
              prodName: responseObj['prodName'],
              prodPrice: responseObj['prodPrice'],
            );
          },
        );
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
      body: Scaffold(
        appBar: Appbar(title: 'Search Item'),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _searchKey,
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
                      child: Text('Search Item'),
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
      ),
    );
  }
}
