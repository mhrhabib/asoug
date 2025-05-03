import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/product_controller.dart';
import 'models/product_model.dart';
import 'product_details_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ProductController _controller = Get.put(ProductController());
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.fetchProducts();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_controller.isLoading.value && _controller.currentPage.value < _controller.totalPages.value) {
      _controller.loadMoreProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'Products',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_alt, color: Colors.white),
            onPressed: () => _showFilterDialog(context),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await _controller.fetchProducts();
        },
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              sliver: SliverToBoxAdapter(
                child: _buildSearchBar(),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              sliver: SliverToBoxAdapter(
                child: _buildActiveFiltersChips(),
              ),
            ),
            const SliverPadding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              sliver: SliverToBoxAdapter(),
            ),
            _buildProductGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search products...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        filled: true,
        fillColor: Colors.grey[100],
      ),
      onChanged: (value) {
        _controller.searchQuery.value = value;
        _controller.fetchProducts();
      },
    );
  }

  Widget _buildActiveFiltersChips() {
    return Obx(() {
      final hasFilters = _controller.selectedCategories.isNotEmpty || _controller.selectedBrand?.value.isNotEmpty == true || _controller.minPrice.value > 0 || _controller.maxPrice.value < 1000 || _controller.minRating.value > 0;

      if (!hasFilters) return const SizedBox();

      return SizedBox(
        height: 50,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            if (_controller.selectedCategories.isNotEmpty)
              ..._controller.selectedCategories.map((category) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Chip(
                      label: Text(category),
                      onDeleted: () {
                        _controller.selectedCategories.remove(category);
                        _controller.fetchProducts();
                      },
                    ),
                  )),
            if (_controller.selectedBrand?.value.isNotEmpty == true)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Chip(
                  label: Text(_controller.selectedBrand!.value),
                  onDeleted: () {
                    _controller.selectedBrand?.value = '';
                    _controller.fetchProducts();
                  },
                ),
              ),
            if (_controller.minPrice.value > 0 || _controller.maxPrice.value < 1000)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Chip(
                  label: Text('\$${_controller.minPrice.value.toInt()}-\$${_controller.maxPrice.value.toInt()}'),
                  onDeleted: () {
                    _controller.minPrice.value = 0;
                    _controller.maxPrice.value = 1000;
                    _controller.fetchProducts();
                  },
                ),
              ),
            if (_controller.minRating.value > 0)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Chip(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      Text('${_controller.minRating.value}+'),
                    ],
                  ),
                  onDeleted: () {
                    _controller.minRating.value = 0;
                    _controller.fetchProducts();
                  },
                ),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ActionChip(
                label: const Text('Clear all'),
                onPressed: _controller.resetFilters,
                backgroundColor: Colors.grey[200],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildProductGrid() {
    return Obx(() {
      if (_controller.isLoading.value && _controller.products.value == null) {
        return const SliverFillRemaining(
          child: Center(child: CircularProgressIndicator()),
        );
      }

      if (_controller.errorMessage.value.isNotEmpty) {
        return SliverFillRemaining(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _controller.errorMessage.value,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _controller.fetchProducts,
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        );
      }

      if (_controller.products.value?.data == null || _controller.products.value!.data!.isEmpty) {
        return const SliverFillRemaining(
          child: Center(child: Text('No products found')),
        );
      }

      return SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (index >= _controller.products.value!.data!.length) {
              return const Center(child: CircularProgressIndicator());
            }
            final product = _controller.products.value!.data![index];
            return _buildProductItem(product);
          },
          childCount: _controller.products.value!.data!.length + (_controller.isLoading.value ? 1 : 0),
        ),
      );
    });
  }

  Widget _buildProductItem(Product product) {
    final price = double.tryParse(product.minPrice?.toString() ?? '0') ?? 0;
    final hasDiscount = product.hasBulkDiscount == 1;

    return GestureDetector(
      onTap: () {
        // Navigate to product details
        Get.to(() => ProductDetailsScreen(product: product));
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
                    fit: BoxFit.cover,
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
                    '\$${price.toStringAsFixed(2)}',
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

  void _showFilterDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            // Ensure we have a valid initial value
            final initialSortValue = _controller.sortBy.value.isNotEmpty ? _controller.sortBy.value : 'name-asc';

            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Filter Products',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text('Price Range'),
                    RangeSlider(
                      values: RangeValues(
                        _controller.minPrice.value,
                        _controller.maxPrice.value,
                      ),
                      min: 0,
                      max: 1000,
                      divisions: 10,
                      labels: RangeLabels(
                        '\$${_controller.minPrice.value.toInt()}',
                        '\$${_controller.maxPrice.value.toInt()}',
                      ),
                      onChanged: (values) {
                        setState(() {
                          _controller.minPrice.value = values.start;
                          _controller.maxPrice.value = values.end;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text('Minimum Rating'),
                    Slider(
                      value: _controller.minRating.value,
                      min: 0,
                      max: 5,
                      divisions: 5,
                      label: _controller.minRating.value.toStringAsFixed(1),
                      onChanged: (value) {
                        setState(() {
                          _controller.minRating.value = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: initialSortValue, // Use the validated initial value
                      decoration: const InputDecoration(
                        labelText: 'Sort By',
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'name-asc',
                          child: Text('Name (A-Z)'),
                        ),
                        DropdownMenuItem(
                          value: 'name-desc',
                          child: Text('Name (Z-A)'),
                        ),
                        DropdownMenuItem(
                          value: 'max_price-asc',
                          child: Text('Price (Low to High)'),
                        ),
                        DropdownMenuItem(
                          value: 'max_price-desc',
                          child: Text('Price (High to Low)'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _controller.sortBy.value = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              _controller.resetFilters();
                              Navigator.pop(context);
                            },
                            child: const Text('Reset'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              _controller.fetchProducts();
                              Navigator.pop(context);
                            },
                            child: const Text('Apply Filters'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
