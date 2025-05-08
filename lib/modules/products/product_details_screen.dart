import 'package:asoug/modules/products/models/product_details_model.dart' as productDetailsModel;
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../cart/controller/cart_controller.dart';
import 'controller/product_controller.dart';

class ProductDetailsScreen extends StatefulWidget {
  final String productSlug;

  const ProductDetailsScreen({super.key, required this.productSlug});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ProductController productController = Get.put(ProductController());
  final CartController cartController = Get.put(CartController());
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    Future.microtask(() => productController.fetchProductDetails(widget.productSlug));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _addToCart() {
    final product = productController.productDetails.value?.data;
    if (product != null) {
      cartController.addToCart(
        productId: product.id!,
        quantity: _quantity,
        variationId: product.variationId,
        temporaryId: DateTime.now().millisecondsSinceEpoch.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: Obx(() {
        if (productController.isLoading.value && productController.productDetails.value == null) {
          return const Center(child: CircularProgressIndicator());
        }

        if (productController.errorMessage.value.isNotEmpty) {
          return Center(child: Text(productController.errorMessage.value));
        }

        final product = productController.productDetails.value?.data;
        if (product == null) {
          return const Center(child: Text('Product not found'));
        }

        final price = double.tryParse(product.minPrice?.toString() ?? '0') ?? 0;
        final hasDiscount = product.hasBulkDiscount == 1;
        final maxPrice = double.tryParse(product.maxPrice?.replaceAll('৳', '').replaceAll(',', '').trim() ?? '0') ?? 0;

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Main product image
                    _MainProductImage(
                      images: product.images?.map((img) => img.url ?? '').toList() ?? [product.featuredImage ?? ''],
                    ),

                    // Product details
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name ?? 'No name',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          if (product.company?.name != null)
                            Text(
                              'By ${product.company!.name}',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                              ),
                            ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Text(
                                '৳ ${price.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              if (hasDiscount) ...[
                                const SizedBox(width: 8),
                                Text(
                                  '৳ ${maxPrice.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: const Text(
                                    'DISCOUNT',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              RatingBar.builder(
                                initialRating: double.tryParse(product.rating ?? '0') ?? 0,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemSize: 20,
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {},
                              ),
                              const SizedBox(width: 8),
                              Text(
                                product.rating ?? '0.0',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '(${product.totalSales ?? 0} sold)',
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          // Attributes
                          if (product.attributes?.isNotEmpty ?? false)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Specifications',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ...product.attributes!.map((attr) => Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 4),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 120,
                                            child: Text(
                                              attr.attributeName ?? '',
                                              style: const TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(attr.value ?? ''),
                                          ),
                                        ],
                                      ),
                                    )),
                                const SizedBox(height: 16),
                              ],
                            ),

                          // Tabs
                          Column(
                            children: [
                              TabBar(
                                controller: _tabController,
                                labelColor: Theme.of(context).primaryColor,
                                unselectedLabelColor: Colors.grey,
                                indicatorColor: Theme.of(context).primaryColor,
                                tabs: const [
                                  Tab(text: 'Description'),
                                  Tab(text: 'Reviews'),
                                  Tab(text: 'Shipping'),
                                ],
                              ),
                              SizedBox(
                                height: 200,
                                child: TabBarView(
                                  controller: _tabController,
                                  children: [
                                    // Description Tab
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        product.description ?? 'No description available',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          height: 1.5,
                                        ),
                                      ),
                                    ),

                                    // Reviews Tab
                                    _buildReviewsTab(product),

                                    // Shipping Tab
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Shipping Information',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context).primaryColor,
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          Text(
                                            product.isShippable == 1 ? 'This product is shippable' : 'This product is not shippable',
                                            style: const TextStyle(fontSize: 16),
                                          ),
                                          if (product.shippingMethod != null)
                                            Padding(
                                              padding: const EdgeInsets.only(top: 8),
                                              child: Text(
                                                'Method: ${product.shippingMethod}',
                                                style: const TextStyle(fontSize: 16),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          // Quantity and Add to Cart
                          _ProductActionBar(
                            onAddToCart: _addToCart,
                            quantity: _quantity,
                            minOrderQty: product.minOrderQty ?? 1,
                            onQuantityChanged: (newQuantity) {
                              setState(() {
                                _quantity = newQuantity;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    // Related Products Section
                    if (product.relatedProducts?.isNotEmpty ?? false)
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'You may also like',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              height: 250,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: product.relatedProducts!.length,
                                itemBuilder: (context, index) {
                                  final relatedProduct = product.relatedProducts![index];
                                  return GestureDetector(
                                    onTap: () {
                                      Get.to(() => ProductDetailsScreen(productSlug: relatedProduct.slug!));
                                    },
                                    child: Container(
                                      width: 160,
                                      margin: const EdgeInsets.only(right: 16),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 150,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              image: DecorationImage(
                                                image: NetworkImage(relatedProduct.featuredImage ?? ''),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            relatedProduct.name ?? '',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '৳ ${double.tryParse(relatedProduct.minPrice?.toString() ?? '0')?.toStringAsFixed(2) ?? '0.00'}',
                                            style: TextStyle(
                                              color: Theme.of(context).primaryColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildReviewsTab(productDetailsModel.Data? product) {
    if (product!.reviews?.isEmpty ?? true) {
      return const Center(
        child: Text('No reviews yet'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: product.reviews!.length,
      itemBuilder: (context, index) {
        final review = product.reviews![index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 16,
                    child: Icon(Icons.person),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Customer',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  RatingBar.builder(
                    initialRating: review.rating?.toDouble() ?? 0,
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
              const SizedBox(height: 8),
              Text(
                review.comment ?? 'No comment',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 8),
              const Text(
                'Recently',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _MainProductImage extends StatefulWidget {
  final List<String> images;

  const _MainProductImage({required this.images});

  @override
  State<_MainProductImage> createState() => _MainProductImageState();
}

class _MainProductImageState extends State<_MainProductImage> {
  int _selectedImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Image.network(
            widget.images[_selectedImageIndex],
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported),
          ),
        ),
        const SizedBox(height: 16),
        if (widget.images.length > 1)
          SizedBox(
            height: 80,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.images.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedImageIndex = index;
                    });
                  },
                  child: Container(
                    width: 80,
                    margin: const EdgeInsets.only(right: 2, left: 8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _selectedImageIndex == index ? Theme.of(context).primaryColor : Colors.transparent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        widget.images[index],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }
}

class _ProductActionBar extends StatelessWidget {
  final Function() onAddToCart;
  final int quantity;
  final int minOrderQty;
  final Function(int) onQuantityChanged;

  const _ProductActionBar({
    required this.onAddToCart,
    required this.quantity,
    required this.minOrderQty,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    if (quantity > minOrderQty) {
                      onQuantityChanged(quantity - 1);
                    }
                  },
                ),
                Text(
                  '$quantity',
                  style: const TextStyle(fontSize: 18),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    onQuantityChanged(quantity + 1);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: onAddToCart,
              child: const Text(
                'Add to Cart',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
