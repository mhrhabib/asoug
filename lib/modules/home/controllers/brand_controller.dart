import 'package:get/get.dart';
import '../models/brand_model.dart';
import '../repo/brand_repo.dart';

class BrandController extends GetxController {
  final BrandRepo brandRepo;

  BrandController(this.brandRepo);

  var brandList = <BrandModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchBrands();
    super.onInit();
  }

  void fetchBrands() async {
    isLoading.value = true;
    try {
      final brands = await brandRepo.fetchBrands();
      brandList.value = brands;
    } catch (e) {
      print('Error fetching brands: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
