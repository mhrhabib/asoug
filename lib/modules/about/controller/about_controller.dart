import 'package:get/get.dart';
import '../models/about_model.dart';
import '../repo/about_repo.dart';

class AboutController extends GetxController {
  final AboutRepository _repository = AboutRepository();

  final Rx<AboutModel?> aboutData = Rx<AboutModel?>(null);
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    fetchAboutData();
    super.onInit();
  }

  Future<void> fetchAboutData() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final result = await _repository.getAboutData();
      aboutData.value = result;
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', 'Failed to fetch about data');
    } finally {
      isLoading.value = false;
    }
  }
}
