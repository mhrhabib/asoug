import 'package:asoug/modules/supplier/models/suppliers_details_model.dart';
import 'package:get/get.dart';
import '../models/supplier_product_model.dart';
import '../models/suppliers_model.dart';
import '../repo/suppliers_repo.dart';

class SupplierController extends GetxController {
  final SupplierRepository _repository = SupplierRepository();

  final isLoading = false.obs;
  final suppliersData = Rxn<SuppliersModel>();
  final errorMessage = RxString('');
  final currentPage = 1.obs;
  final hasMore = true.obs;

  @override
  void onInit() {
    fetchSuppliers();
    super.onInit();
  }

  // Supplier Products
  final supplierProducts = Rxn<SupplierProductModel>();
  final isLoadingProducts = false.obs;
  final productsError = RxString('');
  final currentProductPage = 1.obs;
  final hasMoreProducts = true.obs;
  Future<void> fetchSupplierProducts(String slug, {int page = 1}) async {
    try {
      isLoadingProducts(true);
      productsError('');

      final data = await _repository.getSupplierProducts(slug, page: page);
      supplierProducts(data);
      currentProductPage(page);
      hasMoreProducts(data.links?.next != null);
    } catch (e) {
      productsError('Failed to load products: ${e.toString()}');
      supplierProducts(null);
    } finally {
      isLoadingProducts(false);
    }
  }

  Future<void> fetchSuppliers({int page = 1}) async {
    try {
      isLoading(true);
      errorMessage('');

      final data = await _repository.getSuppliers(page: page);
      suppliersData(data);
      currentPage(page);
      hasMore(data.data?.nextPageUrl != null);
    } catch (e) {
      errorMessage('Failed to load suppliers: ${e.toString()}');
      suppliersData(null);
    } finally {
      isLoading(false);
    }
  }

  Future<void> loadMoreSuppliers() async {
    if (!hasMore.value || isLoading.value) return;

    try {
      isLoading(true);
      final nextPage = currentPage.value + 1;
      final data = await _repository.getSuppliers(page: nextPage);

      suppliersData.update((val) {
        val?.data?.data?.addAll(data.data?.data ?? []);
        val?.data?.currentPage = data.data?.currentPage;
        val?.data?.nextPageUrl = data.data?.nextPageUrl;
      });

      currentPage(nextPage);
      hasMore(data.data?.nextPageUrl != null);
    } catch (e) {
      errorMessage('Failed to load more suppliers: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  // Supplier Details
  final supplierDetails = Rxn<SupplierDetailsModel>();
  final isLoadingDetails = false.obs;
  final detailsError = RxString('');

  Future<void> fetchSupplierDetails(String slug) async {
    try {
      isLoadingDetails(true);
      detailsError('');

      final data = await _repository.getSupplierDetails(slug);
      supplierDetails(data);
    } catch (e) {
      detailsError('Failed to load supplier details: ${e.toString()}');
      supplierDetails(null);
    } finally {
      isLoadingDetails(false);
    }
  }
}
