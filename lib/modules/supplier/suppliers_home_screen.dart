import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:asoug/modules/supplier/controllers/supplier_controller.dart';

import 'models/supplier_product_model.dart';

class SupplierHomePage extends StatefulWidget {
  final String slug;

  const SupplierHomePage({super.key, required this.slug});

  @override
  State<SupplierHomePage> createState() => _SupplierHomePageState();
}

class _SupplierHomePageState extends State<SupplierHomePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _queryController = TextEditingController();
  final SupplierController controller = Get.put(SupplierController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    controller.fetchSupplierDetails(widget.slug);
    controller.fetchSupplierProducts(widget.slug);
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _queryController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange) {
      //controller.loadMoreProducts(widget.slug);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
              controller.supplierDetails.value?.data?.name ?? 'Supplier Home',
            )),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: SupplierProductSearchDelegate(
                  products: controller.supplierProducts.value?.data ?? [],
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // Open menu
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoadingDetails.value && controller.supplierDetails.value == null) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.detailsError.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(controller.detailsError.value),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => controller.fetchSupplierDetails(widget.slug),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            // Supplier Profile Section
            _buildSupplierProfile(),

            // Tabs Section
            Container(
              color: Colors.white,
              child: TabBar(
                controller: _tabController,
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Theme.of(context).primaryColor,
                tabs: const [
                  Tab(text: 'Products'),
                  Tab(text: 'About Us'),
                  Tab(text: 'Contact'),
                ],
              ),
            ),

            // Tab Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Products Tab
                  _buildProductsTab(),

                  // About Us Tab
                  _buildAboutUsTab(),

                  // Contact Tab
                  _buildContactTab(),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildSupplierProfile() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(
                  controller.supplierDetails.value?.data?.logo ?? 'https://via.placeholder.com/150',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  controller.supplierDetails.value?.data?.name ?? 'Supplier Name',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    RatingBar.builder(
                      initialRating: double.tryParse(controller.supplierDetails.value?.data?.rating ?? '0') ?? 0,
                      itemSize: 16,
                      ignoreGestures: true,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {},
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'reviews',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      controller.supplierDetails.value?.data?.companySize ?? 'Location',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.map, size: 20),
                      onPressed: () {
                        // Open map
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsTab() {
    return Obx(() {
      if (controller.isLoadingProducts.value && controller.supplierProducts.value == null) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.productsError.value.isNotEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(controller.productsError.value),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => controller.fetchSupplierProducts(widget.slug),
                child: const Text('Retry'),
              ),
            ],
          ),
        );
      }

      final products = controller.supplierProducts.value?.data ?? [];

      return RefreshIndicator(
        onRefresh: () => controller.fetchSupplierProducts(widget.slug),
        child: ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.all(16),
          itemCount: products.length + (controller.hasMoreProducts.value ? 1 : 0),
          itemBuilder: (context, index) {
            if (index >= products.length) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }

            final product = products[index];
            return _buildProductCard(product);
          },
        ),
      );
    });
  }

  Widget _buildProductCard(SupplierProduct product) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(
                  product.featuredImage ?? 'https://via.placeholder.com/150',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name ?? 'Product Name',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'SAR ${product.minPrice ?? '0.00'}',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    RatingBar.builder(
                      initialRating: double.tryParse(product.rating ?? '0') ?? 0,
                      itemSize: 16,
                      ignoreGestures: true,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {},
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              // Add to cart
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAboutUsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About Us',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            controller.supplierDetails.value?.data?.companyDescription ?? 'No description available',
            style: const TextStyle(fontSize: 16, height: 1.5),
          ),
          const SizedBox(height: 24),
          const Text(
            'Business Information',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          _buildInfoRow('Business Type', controller.supplierDetails.value?.data?.businessType ?? 'N/A'),
          _buildInfoRow('Employees', controller.supplierDetails.value?.data?.numberOfEmployees ?? 'N/A'),
          _buildInfoRow('Established', controller.supplierDetails.value?.data?.yearOfEstablishment ?? 'N/A'),
          _buildInfoRow('Main Products', controller.supplierDetails.value?.data?.mainProducts ?? 'N/A'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget _buildContactTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Contact Us',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Have questions or need assistance? Send us a message and our team will get back to you within 24 hours.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _queryController,
            maxLines: 5,
            decoration: const InputDecoration(
              labelText: 'Your Query',
              border: OutlineInputBorder(),
              hintText: 'Type your question or message here...',
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Your Email',
              border: OutlineInputBorder(),
              hintText: 'example@email.com',
            ),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                // Send message
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Send Message',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 16),
          const Text(
            'Registration Information',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoRow('Commercial Reg.', controller.supplierDetails.value?.data?.commercialRegistrationNumber ?? 'N/A'),
          _buildInfoRow('Tax Number', controller.supplierDetails.value?.data?.taxNumber ?? 'N/A'),
        ],
      ),
    );
  }
}

class SupplierProductSearchDelegate extends SearchDelegate {
  final List<SupplierProduct> products;

  SupplierProductSearchDelegate({required this.products});

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
    final filteredProducts = products.where((product) => product.name?.toLowerCase().contains(query.toLowerCase()) ?? false).toList();

    return ListView.builder(
      itemCount: filteredProducts.length,
      itemBuilder: (context, index) {
        final product = filteredProducts[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              product.featuredImage ?? 'https://via.placeholder.com/150',
            ),
          ),
          title: Text(product.name ?? 'Product'),
          subtitle: Text('SAR ${product.minPrice ?? '0.00'}'),
          onTap: () {
            // Handle product selection
          },
        );
      },
    );
  }
}
