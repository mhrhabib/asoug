import 'package:asoug/modules/supplier/supplier_login_screen.dart';
import 'package:asoug/modules/supplier/suppliers_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupplierListScreen extends StatefulWidget {
  const SupplierListScreen({super.key});

  @override
  State<SupplierListScreen> createState() => _SupplierListScreenState();
}

class _SupplierListScreenState extends State<SupplierListScreen> {
  // Sample list of suppliers
  final List<Supplier> suppliers = [
    Supplier(
      name: 'ABC Suppliers',
      rating: 4.5,
      imageUrl: 'https://picsum.photos/601',
    ),
    Supplier(
      name: 'XYZ Distributors',
      rating: 4.2,
      imageUrl: 'https://picsum.photos/602',
    ),
    Supplier(
      name: 'Global Trading',
      rating: 4.8,
      imageUrl: 'https://picsum.photos/603',
    ),
    Supplier(
      name: 'Premium Goods Co.',
      rating: 4.0,
      imageUrl: 'https://picsum.photos/604',
    ),
    Supplier(
      name: 'Quality Products Ltd.',
      rating: 4.7,
      imageUrl: 'https://picsum.photos/605',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Suppliers'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor, shape: StadiumBorder()),
            child: Text(
              'login',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Get.to(() => SupplierLoginScreen());
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: suppliers.length,
        itemBuilder: (context, index) {
          final supplier = suppliers[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      // Supplier image
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(supplier.imageUrl),
                      ),
                      const SizedBox(width: 16),
                      // Supplier name and rating
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              supplier.name,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text('Rating:'),
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  supplier.rating.toString(),
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Visit Company button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => SupplierHomePage());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Visit Company',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Supplier model class
class Supplier {
  final String name;
  final double rating;
  final String imageUrl;

  Supplier({
    required this.name,
    required this.rating,
    required this.imageUrl,
  });
}

// Placeholder for the search delegate
class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(); // Implement search results
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(); // Implement search suggestions
  }
}
