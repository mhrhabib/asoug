import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'models/product_model.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  //int _selectedImageIndex = 0;
  int _quantity = 1;
  final List<String> productImages = [
    'https://picsum.photos/505',
    'https://picsum.photos/400',
    'https://picsum.photos/500',
    'https://picsum.photos/600',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final price = double.tryParse(widget.product.minPrice?.toString() ?? '0') ?? 0;
    final hasDiscount = widget.product.hasBulkDiscount == 1;
    final maxPrice = double.tryParse(widget.product.maxPrice?.replaceAll('৳', '').replaceAll(',', '').trim() ?? '0') ?? 0;

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
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Main product image
                  _MainProductImage(
                    images: widget.product.featuredImage != null ? [widget.product.featuredImage!] : productImages,
                  ),

                  // Product details
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.name ?? 'No name',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.product.slug?.replaceAll('-', ' ') ?? '',
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
                              initialRating: double.tryParse(widget.product.rating ?? '0') ?? 0,
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
                              widget.product.rating ?? '0.0',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              '(Reviews)',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
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
                                Tab(text: 'Specifications'),
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
                                      widget.product.name ?? 'No description available',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),

                                  // Reviews Tab
                                  ListView.builder(
                                    padding: const EdgeInsets.all(16),
                                    itemCount: 5,
                                    itemBuilder: (context, index) {
                                      return _buildReviewItem();
                                    },
                                  ),

                                  // Specifications Tab
                                  const Padding(
                                    padding: EdgeInsets.all(16.0),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          _SpecificationRow(title: 'Brand', value: 'N/A'),
                                          _SpecificationRow(title: 'Category', value: 'N/A'),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        _ProductActionBar(
                          onAddToCart: () {
                            // Handle add to cart with _quantity
                            Get.snackbar(
                              'Added to Cart',
                              '${widget.product.name} (Qty: $_quantity)',
                            );
                          },
                          quantity: _quantity,
                          onQuantityChanged: (newQuantity) {
                            setState(() {
                              _quantity = newQuantity;
                            });
                          },
                        ),
                        // ... rest of your existing widgets
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewItem() {
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
                backgroundImage: NetworkImage('https://picsum.photos/505'),
              ),
              const SizedBox(width: 8),
              const Text(
                'Customer',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              RatingBar.builder(
                initialRating: 4,
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
          const Text(
            'Great product! Would buy again.',
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 8),
          const Text(
            'Recently',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class _SpecificationRow extends StatelessWidget {
  final String title;
  final String value;

  const _SpecificationRow({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
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
            fit: BoxFit.fitWidth,
          ),
        ),
        const SizedBox(height: 16),
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
  final Function(int) onQuantityChanged;

  const _ProductActionBar({
    required this.onAddToCart,
    required this.quantity,
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
                    if (quantity > 1) {
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
