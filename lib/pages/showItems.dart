import 'dart:convert';
import 'package:e_commerce_app/pages/tokenProvider.dart';
import 'package:e_commerce_app/util/appBar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Showitems extends StatefulWidget {
  const Showitems({super.key});

  @override
  State<Showitems> createState() => _ShowitemsState();
}

class _ShowitemsState extends State<Showitems> {
  List<Map<String, dynamic>> itemList = [];
  void showItems() async {
    final String? token = Provider.of<Tokenprovider>(
      context,
      listen: false,
    ).token;

    print(token);

    String url = 'http://localhost:8081/api/products';
    var responseObj = await http.get(
      Uri.parse(url),
      headers: {'Authorization': 'Bearer $token'},
    );

    print(responseObj.statusCode);
    var response = jsonDecode(responseObj.body);

    setState(() {
      for (int i = 0; i < response.length; i++) {
        itemList.add(response[i]);
      }
      print(itemList);
    });
  }

  @override
  void initState() {
    super.initState();
    showItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(title: "List of all Items"),
      body: ListView.separated(
        scrollDirection: Axis.vertical,
        separatorBuilder: (context, index) => SizedBox(height: 20),
        itemCount: itemList.length,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.blue[200],
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 207, 205, 205),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Product ID: #${itemList[index]['prodID'].toString()}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Product Name: ${itemList[index]['prodName']}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Product Price: ${itemList[index]['prodPrice'].toString()}',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
