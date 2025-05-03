import 'package:asoug/modules/products/repo/product_repo.dart';
import 'package:get/get.dart';
import '../models/product_model.dart';

class ProductController extends GetxController {
  final ProductRepository _productRepository = ProductRepository();

  Rx<ProductModel?> products = Rx<ProductModel?>(null);
  Rx<ProductModel?> featuredProducts = Rx<ProductModel?>(null);
  Rx<ProductModel?> productDetails = Rx<ProductModel?>(null);
  Rx<ProductModel?> relatedProducts = Rx<ProductModel?>(null);
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  // For pagination
  RxInt currentPage = 1.obs;
  RxInt totalPages = 1.obs;
  RxInt perPage = 20.obs;

  // Filter variables
  RxString searchQuery = ''.obs;
  RxList<String> selectedCategories = <String>[].obs;
  RxString? selectedBrand = ''.obs;
  RxList<int> selectedBrandIds = <int>[].obs;
  RxDouble minPrice = 0.0.obs;
  RxDouble maxPrice = 0.0.obs;
  RxDouble minRating = 0.0.obs;
  RxString sortBy = ''.obs;

  Future<void> fetchProducts({bool loadMore = false}) async {
    try {
      if (!loadMore) {
        isLoading.value = true;
        currentPage.value = 1;
      }

      final response = await _productRepository.getProducts(
        searchQuery: searchQuery.value,
        categories: selectedCategories,
        brand: selectedBrand?.value,
        brandIds: selectedBrandIds,
        minPrice: minPrice.value == 0.0 ? null : minPrice.value,
        maxPrice: maxPrice.value == 0.0 ? null : maxPrice.value,
        minRating: minRating.value == 0.0 ? null : minRating.value,
        sortBy: sortBy.value,
        perPage: perPage.value,
        page: currentPage.value,
      );

      if (response is ProductModel) {
        if (loadMore && products.value != null) {
          // Append new products to existing list
          products.value!.data?.addAll(response.data ?? []);
          products.refresh();
        } else {
          products.value = response;
        }
        totalPages.value = response.meta?.lastPage ?? 1;
        errorMessage.value = '';
      } else {
        errorMessage.value = 'Failed to load products';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMoreProducts() async {
    if (currentPage.value < totalPages.value && !isLoading.value) {
      currentPage.value++;
      await fetchProducts(loadMore: true);
    }
  }

  Future<void> fetchFeaturedProducts() async {
    try {
      isLoading.value = true;
      final response = await _productRepository.getFeaturedProducts();
      if (response is ProductModel) {
        featuredProducts.value = response;
        errorMessage.value = '';
      } else {
        errorMessage.value = 'Failed to load featured products';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchProductDetails(String productId) async {
    try {
      isLoading.value = true;
      final response = await _productRepository.getProductDetails(productId);
      if (response is ProductModel) {
        productDetails.value = response;
        errorMessage.value = '';
      } else {
        errorMessage.value = 'Failed to load product details';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchRelatedProducts(String productId) async {
    try {
      isLoading.value = true;
      final response = await _productRepository.getRelatedProducts(productId);
      if (response is ProductModel) {
        relatedProducts.value = response;
        errorMessage.value = '';
      } else {
        errorMessage.value = 'Failed to load related products';
      }
    } catch (e) {
      errorMessage.value = 'Error: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void applyFilters({
    String? newSearchQuery,
    List<String>? newCategories,
    String? newBrand,
    List<int>? newBrandIds,
    double? newMinPrice,
    double? newMaxPrice,
    double? newMinRating,
    String? newSortBy,
    int? newPerPage,
  }) {
    if (newSearchQuery != null) searchQuery.value = newSearchQuery;
    if (newCategories != null) selectedCategories.value = newCategories;
    if (newBrand != null) selectedBrand?.value = newBrand;
    if (newBrandIds != null) selectedBrandIds.value = newBrandIds;
    if (newMinPrice != null) minPrice.value = newMinPrice;
    if (newMaxPrice != null) maxPrice.value = newMaxPrice;
    if (newMinRating != null) minRating.value = newMinRating;
    if (newSortBy != null) sortBy.value = newSortBy;
    if (newPerPage != null) perPage.value = newPerPage;

    fetchProducts();
  }

  void resetFilters() {
    searchQuery.value = '';
    selectedCategories.clear();
    selectedBrand?.value = '';
    selectedBrandIds.clear();
    minPrice.value = 0.0;
    maxPrice.value = 1000.0;
    minRating.value = 0.0;
    sortBy.value = 'name-asc';
    perPage.value = 10;

    fetchProducts();
  }
}
