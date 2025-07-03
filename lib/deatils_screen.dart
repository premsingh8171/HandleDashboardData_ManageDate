import 'package:flutter/material.dart';

import 'model/food_product.dart';


class DetailScreen extends StatelessWidget {
  final FoodProduct item;

  DetailScreen({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(item.productName ?? 'Details'),
          backgroundColor: Colors.orangeAccent,
          actions: [
            IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                // Implement share functionality here
              },
            ),
            IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () {
                // Implement favorite functionality here
              },
            ),
          ]
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item.imageUrl != null)
              Center(child: Image.network(item.imageUrl!, height: 200)),
            SizedBox(height: 16),
            Text('Brand: ${item.brands ?? 'Unknown'}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Ingredients:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text(item.ingredientsText ?? 'No ingredients listed.', style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}



/*
class DetailScreen extends StatelessWidget {
  final Map<String, dynamic> item;

  DetailScreen({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(item['product_name'] ?? 'Details')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(
          'Ingredients: ${item['ingredients_text'] ?? 'No ingredients listed.'}',
        ),
      ),
    );
  }
}
*/
