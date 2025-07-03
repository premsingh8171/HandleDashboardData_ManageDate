import 'package:flutter/material.dart';
import 'package:provider/provider.dart';          // State management
import 'dart:convert';                            // For JSON decoding
import 'package:http/http.dart' as http;
import 'deatils_screen.dart';
import 'main.dart';          // API calls


class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late FoodProvider provider;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<FoodProvider>(context, listen: false);
    provider.fetchProduct(force: true);
  }

  Future<void> _refreshData() async {
    await provider.fetchProduct(force: true);
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<FoodProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Food Dashboard')),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: provider.isLoading
            ? ListView(children: [Center(child: Padding(padding: EdgeInsets.all(20), child: CircularProgressIndicator()))])
            : provider.product == null
            ? ListView(children: [Center(child: Padding(padding: EdgeInsets.all(20), child: Text('No data available')))])
            : ListView(
          children: [
            Card(
              margin: EdgeInsets.all(12),
              elevation: 3,
              child: ListTile(
                leading: provider.product!.imageThumbUrl != null
                    ? Image.network(provider.product!.imageThumbUrl!)
                    : Icon(Icons.fastfood),
                title: Text(
                  provider.product!.productName ?? 'Unnamed product',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Brand: ${provider.product!.brands ?? 'Unknown'}'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailScreen(item: provider.product!!),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}




/*class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late FoodProvider provider;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<FoodProvider>(context, listen: false);
    provider.fetchProduct();
  }

  Future<void> _refreshData() async {
    await provider.fetchProduct(force: true);
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<FoodProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Food Dashboard')),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: provider.isLoading
            ? ListView(
          children: [Center(child: Padding(
            padding: EdgeInsets.all(20),
            child: CircularProgressIndicator(),
          ))],
        )
            : provider.product == null
            ? ListView(
          children: [Center(child: Padding(
            padding: EdgeInsets.all(20),
            child: Text('No data available'),
          ))],
        )
            : ListView(
          children: [
            ListTile(
              title: Text('Product: ${provider.product!['product_name'] ?? 'Unknown'}'),
              subtitle: Text('Brand: ${provider.product!['brands'] ?? 'Unknown'}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailScreen(item: provider.product!),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}*/
