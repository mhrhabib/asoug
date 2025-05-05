import 'dart:io';

import 'package:get/get.dart';
import '../models/profile_model.dart';
import '../repo/profile_repo.dart';

class ProfileController extends GetxController {
  final ProfileRepository _repo = ProfileRepository();

  var isLoading = false.obs;
  var isUpdating = false.obs;
  var profile = ProfileModel().obs;

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  void getProfile() async {
    isLoading.value = true;
    var result = await _repo.fetchProfile();
    if (result != null) {
      profile.value = result;
    }
    isLoading.value = false;
  }

  Future<bool> updateProfile({required String name, required String email, required String phone}) async {
    isUpdating.value = true;
    final success = await _repo.updateProfile({
      "name": name,
      "email": email,
      "phone": phone,
    });
    if (success) {
      getProfile(); // Refresh data
    }
    isUpdating.value = false;
    return success;
  }

  Future<bool> updatePassword(String currentPassword, String password, String passwordConfirmation) async {
    isLoading.value = true;
    final success = await _repo.updatePassword(
      currentPassword: currentPassword,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
    isLoading.value = false;
    return success;
  }

  Future<bool> updateAvatar(File avatarUrl) async {
    isUpdating.value = true;
    final success = await _repo.updateAvatar(avatarUrl);
    if (success) {
      getProfile(); // Refresh data
    }
    isUpdating.value = false;
    return success;
  }
}
