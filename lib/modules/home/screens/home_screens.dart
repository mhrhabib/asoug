import 'package:asoug/modules/products/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../models/list_item.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/home_screen_drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<ProductItem> fashionItems = [
    ProductItem(
      imageUrl: 'https://picsum.photos/300',
      name: 'Summer T-Shirt',
      title: 'Cotton Comfort Fit',
      price: 29.99,
      hasDiscount: true,
    ),
    ProductItem(
      imageUrl: 'https://picsum.photos/301',
      name: 'Denim Jeans',
      title: 'Slim Fit Blue Jeans',
      price: 49.99,
      hasDiscount: false,
    ),

    ProductItem(
      imageUrl: 'https://picsum.photos/303',
      name: 'Summer T-Shirt',
      title: 'Cotton Comfort Fit',
      price: 29.99,
      hasDiscount: true,
    ),
    ProductItem(
      imageUrl: 'https://picsum.photos/302',
      name: 'Denim Jeans',
      title: 'Slim Fit Blue Jeans',
      price: 49.99,
      hasDiscount: true,
    ),
    // Add more fashion items...
  ];

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.grey.shade100,
      appBar: CustomAppBar(
        skey: scaffoldKey,
      ),
      drawer: HomeScreenWithDrawer(),
      body: Column(
        children: [
          Gap(12),
          SizedBox(
            height: 35,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Image.asset(
                  'assets/Group 2.png',
                  height: 28,
                  width: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0.0),
                  child: Text(
                    "All",
                    style: TextStyle(fontSize: 22, color: Colors.blue),
                  ),
                ),
                Gap(12),
                Container(
                  // alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'Food',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Gap(12),
                Container(
                  // alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'Apparel',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Gap(12),
                Container(
                  // alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'Fashion',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Gap(12),
                Container(
                  // alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    'Electronics',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          Gap(12),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Gap(12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Brand'),
                        Text('View all'),
                      ],
                    ),
                    TwoRowListView(items: items),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      color: Colors.white,
                      child: Column(
                        children: [
                          const Gap(16),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Fashion', style: TextStyle(fontWeight: FontWeight.bold)),
                              Text('View all', style: TextStyle(color: Colors.blue)),
                            ],
                          ),
                          const Gap(12),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12,
                              mainAxisSpacing: 12,
                              childAspectRatio: 0.7,
                            ),
                            itemCount: fashionItems.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () {
                                    //Get.to(() => ProductDetailsScreen(product: fashionItems,));
                                  },
                                  child: _buildProductItem(fashionItems[index]));
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductItem(ProductItem item) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  item.imageUrl,
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              if (item.hasDiscount)
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      '15% OFF',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  item.title,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  '\$${item.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
                if (item.hasDiscount)
                  Text(
                    '\$${(item.price * 1.15).toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[400],
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TwoRowListView extends StatelessWidget {
  final List<ListItem> items;

  const TwoRowListView({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160, // Fixed height for two rows
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: (items.length / 2).ceil(), // Group into pairs
        itemBuilder: (context, groupIndex) {
          return SizedBox(
            width: 240, // Width for two items side by side
            child: Column(
              children: [
                // First item in pair
                _buildItem(items[groupIndex * 2]),
                const SizedBox(height: 8),
                // Second item (if exists)
                if (groupIndex * 2 + 1 < items.length) _buildItem(items[groupIndex * 2 + 1]),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildItem(ListItem item) {
    return Container(
      height: 70, // Half of parent height (since two rows)
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(item.imageUrl),
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              Text(
                item.subtitle,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ProductItem {
  final String imageUrl;
  final String name;
  final String title;
  final double price;
  final bool hasDiscount;

  ProductItem({
    required this.imageUrl,
    required this.name,
    required this.title,
    required this.price,
    required this.hasDiscount,
  });
}
