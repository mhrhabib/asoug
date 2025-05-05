import 'package:get/get.dart';
import '../models/services_model.dart';
import '../repo/services_repo.dart';

class ServicesController extends GetxController {
  final ServicesRepository _repository = ServicesRepository();

  // Reactive state variables
  final Rx<ServicesModel?> services = Rx<ServicesModel?>(null);
  final RxBool isLoading = false.obs;
  final RxBool isLoadingMore = false.obs;
  final RxString errorMessage = ''.obs;
  final RxInt currentPage = 1.obs;

  @override
  void onInit() {
    fetchServices();
    super.onInit();
  }

  Future<void> fetchServices({int page = 1}) async {
    try {
      if (page == 1) {
        isLoading.value = true;
      } else {
        isLoadingMore.value = true;
      }

      errorMessage.value = '';
      final result = await _repository.getServices(page: page);

      if (page == 1) {
        services.value = result;
      } else {
        // Append new data to existing services
        services.update((val) {
          val?.data?.data?.addAll(result.data?.data ?? []);
          val?.data?.currentPage = result.data?.currentPage;
          val?.data?.nextPageUrl = result.data?.nextPageUrl;
          val?.data?.prevPageUrl = result.data?.prevPageUrl;
          val?.data?.lastPage = result.data?.lastPage;
        });
      }

      currentPage.value = page;
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', 'Failed to fetch services');
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  void loadMoreServices() {
    if (!isLoadingMore.value && services.value?.data!.nextPageUrl != null) {
      fetchServices(page: currentPage.value + 1);
    }
  }
}
