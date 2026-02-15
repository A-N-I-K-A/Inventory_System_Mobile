import 'package:flutter/material.dart';

class Showdialog extends StatelessWidget {
  final int prodID;
  final String prodName;
  final int prodPrice;
  const Showdialog({
    super.key,
    required this.prodID,
    required this.prodName,
    required this.prodPrice,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Product Found", style: TextStyle(color: Colors.white)),
      shadowColor: Colors.blue[200],
      backgroundColor: Colors.blue[400],
      content: SizedBox(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product ID: ${prodID}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Product Name: ${prodName}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Product Price: ${prodPrice}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
