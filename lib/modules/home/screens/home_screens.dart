import 'package:asoug/modules/home/repo/brand_repo.dart';
import 'package:asoug/modules/products/controller/product_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../products/models/product_model.dart';
import '../../products/product_details_screen.dart';
import '../controllers/brand_controller.dart';
import '../models/list_item.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/home_screen_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BrandController brandController = Get.put(BrandController(BrandRepo()));

  final ProductController productController = Get.put(ProductController());

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.purple,
        statusBarIconBrightness: Brightness.light,
      ));
    });
    productController.fetchProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.purple, // Your desired status bar color
      statusBarIconBrightness: Brightness.light, // For dark status bars
    ));

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Theme.of(context).colorScheme.primary, // Set to transparent or your desired color
        statusBarIconBrightness: Brightness.light, // Set icon brightness
      ),
      child: Scaffold(
          key: scaffoldKey,
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            skey: scaffoldKey,
          ),
          drawer: HomeScreenWithDrawer(),
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                // Horizontal categories section
                // SliverToBoxAdapter(
                //   child: SizedBox(
                //     height: 35,
                //     child: ListView(
                //       scrollDirection: Axis.horizontal,
                //       children: [
                //         Image.asset(
                //           'assets/Group 2.png',
                //           height: 28,
                //           width: 40,
                //         ),
                //         Padding(
                //           padding: const EdgeInsets.only(top: 0.0),
                //           child: Text(
                //             "All",
                //             style: TextStyle(fontSize: 22, color: Colors.blue),
                //           ),
                //         ),
                //         Gap(12),
                //         Container(
                //           padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                //           decoration: BoxDecoration(
                //             color: Colors.white,
                //             borderRadius: BorderRadius.circular(5),
                //           ),
                //           child: Text(
                //             'Food',
                //             style: TextStyle(fontSize: 16),
                //           ),
                //         ),
                //         Gap(12),
                //         Container(
                //           padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                //           decoration: BoxDecoration(
                //             color: Colors.white,
                //             borderRadius: BorderRadius.circular(5),
                //           ),
                //           child: Text(
                //             'Apparel',
                //             style: TextStyle(fontSize: 16),
                //           ),
                //         ),
                //         Gap(12),
                //         Container(
                //           padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                //           decoration: BoxDecoration(
                //             color: Colors.white,
                //             borderRadius: BorderRadius.circular(5),
                //           ),
                //           child: Text(
                //             'Fashion',
                //             style: TextStyle(fontSize: 16),
                //           ),
                //         ),
                //         Gap(12),
                //         Container(
                //           padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                //           decoration: BoxDecoration(
                //             color: Colors.white,
                //             borderRadius: BorderRadius.circular(5),
                //           ),
                //           child: Text(
                //             'Electronics',
                //             style: TextStyle(fontSize: 16),
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                SliverPadding(
                  padding: EdgeInsets.all(12),
                ),
                // Brand section
                SliverToBoxAdapter(
                  child: Obx(() {
                    if (brandController.isLoading.value) {
                      return Center(child: const CircularProgressIndicator());
                    } else {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text('Brand', style: TextStyle(fontWeight: FontWeight.bold)),
                                Text('View all', style: TextStyle(color: Colors.blue)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            TwoRowListView(
                              items: brandController.brandList
                                  .map((e) => ListItem(
                                        name: e.name ?? '',
                                        subtitle: 'no subtitle',
                                        imageUrl: 'https://picsum.photos/seed/${e.id}/50',
                                      ))
                                  .toList(),
                            ),
                          ],
                        ),
                      );
                    }
                  }),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Products', style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('View all', style: TextStyle(color: Colors.blue)),
                      ],
                    ),
                  ),
                ),
                // Fashion section
                SliverPadding(
                  padding: EdgeInsets.symmetric(vertical: 2),
                ),
                Obx(() {
                  if (productController.isLoading.value && productController.products.value == null) {
                    return SliverToBoxAdapter(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  if (productController.errorMessage.value.isNotEmpty) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(productController.errorMessage.value),
                            ElevatedButton(
                              onPressed: productController.fetchProducts,
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  if (productController.products.value?.data == null || productController.products.value!.data!.isEmpty) {
                    return SliverToBoxAdapter(
                      child: Center(child: Text('No products found')),
                    );
                  }

                  return SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index >= productController.products.value!.data!.length) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        final product = productController.products.value!.data![index];
                        return _buildProductItem(product);
                      },
                      childCount: productController.products.value!.data!.length + (productController.isLoading.value && productController.currentPage.value > 1 ? 1 : 0),
                    ),
                  );
                }),
              ],
            ),
          )),
    );
  }

  Widget _buildProductItem(Product product) {
    final price = double.tryParse(product.maxPrice!) ?? 0;
    final hasDiscount = int.parse(product.hasBulkDiscount!) == 1;

    return GestureDetector(
      onTap: () {
        Get.to(() => ProductDetailsScreen(productSlug: product.slug!));
      },
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  child: Image.network(
                    product.featuredImage ?? '',
                    height: 120,
                    width: double.infinity,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 120,
                      color: Colors.grey[200],
                      child: const Icon(Icons.image_not_supported),
                    ),
                  ),
                ),
                if (hasDiscount)
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
                        'DISCOUNT',
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
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name ?? 'No name',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        product.rating ?? '0.0',
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${product.maxPrice}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                  if (hasDiscount)
                    Text(
                      '\$${(price * 1.15).toStringAsFixed(2)}',
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
            color: Colors.grey.withValues(alpha: 0.1),
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
