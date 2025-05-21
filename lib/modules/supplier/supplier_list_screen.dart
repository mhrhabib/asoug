import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/supplier_controller.dart';
import 'models/suppliers_model.dart';
import 'supplier_login_screen.dart';
import 'suppliers_home_screen.dart';

class SupplierListScreen extends StatefulWidget {
  const SupplierListScreen({super.key});

  @override
  State<SupplierListScreen> createState() => _SupplierListScreenState();
}

class _SupplierListScreenState extends State<SupplierListScreen> {
  final SupplierController controller = Get.put(SupplierController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange) {
      controller.loadMoreSuppliers();
    }
  }

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
                delegate: SupplierSearchDelegate(controller: controller),
              );
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              shape: const StadiumBorder(),
            ),
            child: const Text(
              'Login',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              Get.to(() => SupplierLoginScreen());
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.suppliersData.value == null) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(controller.errorMessage.value),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => controller.fetchSuppliers(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final suppliers = controller.suppliersData.value?.data?.data ?? [];

        return RefreshIndicator(
          onRefresh: () => controller.fetchSuppliers(),
          child: ListView.builder(
            controller: _scrollController,
            itemCount: suppliers.length + (controller.hasMore.value ? 1 : 0),
            itemBuilder: (context, index) {
              if (index >= suppliers.length) {
                return const Center(
                    child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ));
              }

              final supplier = suppliers[index];
              return SupplierCard(supplier: supplier);
            },
          ),
        );
      }),
    );
  }
}

class SupplierCard extends StatelessWidget {
  final Supplier supplier;

  const SupplierCard({required this.supplier, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                // Supplier logo
                CircleAvatar(
                  radius: 30,
                  backgroundImage: supplier.logo != null ? NetworkImage('https://demo.asoug.com/uploads/all/${supplier.logo!}') : const NetworkImage('https://via.placeholder.com/150'),
                ),
                const SizedBox(width: 16),
                // Supplier info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        supplier.name ?? 'No Name',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      if (supplier.businessType != null)
                        Text(
                          supplier.businessType!,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      const SizedBox(height: 4),
                      if (supplier.rating != null)
                        Row(
                          children: [
                            const Text('Rating:'),
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              supplier.rating!,
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
                  Get.to(() => SupplierHomePage(slug: supplier.slug!));
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
  }
}

class SupplierSearchDelegate extends SearchDelegate {
  final SupplierController controller;

  SupplierSearchDelegate({required this.controller});

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
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    final filteredSuppliers = controller.suppliersData.value?.data?.data?.where((supplier) => supplier.name?.toLowerCase().contains(query.toLowerCase()) ?? false).toList() ?? [];

    return ListView.builder(
      itemCount: filteredSuppliers.length,
      itemBuilder: (context, index) {
        final supplier = filteredSuppliers[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: supplier.logo != null ? NetworkImage(supplier.logo!) : const NetworkImage('https://via.placeholder.com/150'),
          ),
          title: Text(supplier.name ?? 'No Name'),
          subtitle: Text(supplier.businessType ?? ''),
          onTap: () {
            close(context, null);
            Get.to(() => SupplierHomePage(slug: supplier.slug!));
          },
        );
      },
    );
  }
}
