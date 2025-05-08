import 'package:get/get.dart';
import '../models/product_model.dart';
import '../repo/feature_prodcut_repo.dart';

class FeaturedProductController extends GetxController {
  final FeaturedProductRepository _repository = FeaturedProductRepository();

  Rx<ProductModel?> featuredProducts = Rx<ProductModel?>(null);
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  // Pagination
  RxInt currentPage = 1.obs;
  RxInt totalPages = 1.obs;
  RxInt perPage = 20.obs;

  // Filters
  RxString searchQuery = ''.obs;
  RxList<String> selectedCategories = <String>[].obs;
  RxString? selectedBrand = ''.obs;
  RxList<int> selectedBrandIds = <int>[].obs;
  RxDouble minPrice = 0.0.obs;
  RxDouble maxPrice = 0.0.obs;
  RxDouble minRating = 0.0.obs;
  RxString sortBy = ''.obs;

  Future<void> fetchFeaturedProducts({bool loadMore = false}) async {
    try {
      if (!loadMore) {
        isLoading.value = true;
        currentPage.value = 1;
      }

      final response = await _repository.getFeaturedProducts(
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
        if (loadMore && featuredProducts.value != null) {
          featuredProducts.value!.data?.addAll(response.data ?? []);
          featuredProducts.refresh();
        } else {
          featuredProducts.value = response;
        }
        totalPages.value = response.meta?.lastPage ?? 1;
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

  Future<void> loadMoreFeaturedProducts() async {
    print('inside loadMoreFeaturedProducts');
    print('currentPage: ${currentPage.value}');
    if (currentPage.value < totalPages.value && !isLoading.value) {
      print('inside if statement');
      currentPage.value++;
      await fetchFeaturedProducts(loadMore: true);
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

    fetchFeaturedProducts();
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

    fetchFeaturedProducts();
  }
}
