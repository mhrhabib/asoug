import 'package:get/get.dart';
import './models/settings_model.dart';
import 'general_settings_repo.dart';

class GeneralSettingsController extends GetxController {
  final GeneralSettingsRepository _repo = GeneralSettingsRepository();

  var isLoading = false.obs;
  var settings = SettingsModel().obs;

  @override
  void onInit() {
    super.onInit();
    getSettings();
  }

  void getSettings() async {
    isLoading.value = true;
    var result = await _repo.fetchSettings();
    if (result != null) {
      settings.value = result;
    }
    isLoading.value = false;
  }
}
