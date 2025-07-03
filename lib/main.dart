import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'dashboard_screen.dart';
import 'model/food_product.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => FoodProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Dashboard',
      home: DashboardScreen(),
    );
  }
}

class FoodProvider extends ChangeNotifier {
  FoodProduct? _product;
  bool _isLoading = false;

  FoodProduct? get product => _product;
  bool get isLoading => _isLoading;

  Future<void> fetchProduct({bool force = false}) async {
    if (_product != null && !force) return;

    _isLoading = true;
    notifyListeners();

    final response = await http.get(
      Uri.parse('https://world.openfoodfacts.org/api/v0/product/737628064502.json'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _product = FoodProduct.fromJson(data['product']);
    }

    _isLoading = false;
    notifyListeners();
  }
}

/*
class FoodProvider extends ChangeNotifier {
  Map<String, dynamic>? _product;
  bool _isLoading = false;

  Map<String, dynamic>? get product => _product;
  bool get isLoading => _isLoading;

  Future<void> fetchProduct({bool force = false}) async {
    if (_product != null && !force) return; // 🛑 Avoid unnecessary reload

    _isLoading = true;
    notifyListeners();

    final response = await http.get(
      Uri.parse('https://world.openfoodfacts.org/api/v0/product/737628064502.json'),
    );

    if (response.statusCode == 200) {
      _product = json.decode(response.body)['product'];
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearData() {
    _product = null;
    notifyListeners();
  }
}
*/
