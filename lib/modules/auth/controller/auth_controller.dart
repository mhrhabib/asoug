import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/common/widgets/custom_snackbar.dart';
import '../../../core/utils/storage.dart';
import '../../../routes/app_routes.dart';
import '../models/sign_in_model.dart';
import '../repository/auth_repository.dart';

class AuthController extends GetxController {
  final imagePicker = ImagePicker();
  var imagePath = ''.obs;

  TextEditingController username = TextEditingController();

  TextEditingController password = TextEditingController();

  Rx<SignInModel> signInModel = SignInModel().obs;

  RxBool isLoading = false.obs;

  signInEvent() async {
    isLoading.value = true;
    var response = await AuthRepository().signIn(email: username.value.text, password: password.value.text);
    print(">>>>>>>$response");
    if (response.data!.token != null) {
      isUser = true;
      Get.toNamed(AppRoutes.homeScreen);
    }

    // storage.write('userId', response.data);
    storage.write('token', response.data!.token!);
    storage.write('userType', response.data!.type!);
    print("id user from login >>>>>>>>>>..$isUser");

    if (isUser) {
      print('>>>>>>>>>>>>yes');

      // Navigator.of(Get.context!).pushNamed(AppRoutes.navBar);
    }
    // Get.offAllNamed(AppRoutes.initialRoutes);
    //print(signInModel.value.user!.email);
    isLoading.value = false;
  }

  //signup
  Rx<bool> checkmark = false.obs;

  TextEditingController name = TextEditingController();
  var type = ''.obs;

  TextEditingController email = TextEditingController();

  TextEditingController phone = TextEditingController();

  TextEditingController password1 = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  RxBool isAgree = false.obs;
  var agreedText = 'yes'.obs;
  var country = 1.obs;
  var isSignUpLoading = false.obs;
  RxBool verifyEmailLoading = false.obs;

  signup() async {
    isSignUpLoading.value = true;

    try {
      // Call the API
      print("herer");
      var result = await AuthRepository.signUpApiCall(
        name: name.value.text.trim(),
        type: type.value,
        phone: phone.value.text.trim(),
        email: email.value.text.trim(),
        countryId: country.value.toString(),
        password: password1.value.text.trim(),
        confirmPassword: confirmPassword.value.text.trim(),
        agree: agreedText.value,
      );

      // Handle the Result without `when`
    } catch (e) {
      // Handle unexpected exceptions
      CustomSnackBar.showCustomErrorToast(message: "An unexpected error occurred");
      print("Unexpected error: $e");
    } finally {
      // Ensure the loading indicator is turned off
      isSignUpLoading.value = false;
    }
  }

  //verify email address
  var verifyIsLoading = false.obs;

  verifyEmailAddress({String? code}) async {
    verifyIsLoading.value = true;
    var response = await AuthRepository.verifyEmail(code: code);
    if (response['status'] == true) {
      CustomSnackBar.showCustomSnackBar(title: "Success", message: "${response['message']}");
      verifyIsLoading.value = false;
      // Get.to(() => UserDataScreen(
      //       type: storage.read('type'),
      //     ));
    } else {
      verifyIsLoading.value = false;
    }
  }

  //visibility
  var isVisible = true.obs;
  void visibilityCheck() {
    isVisible.value = !isVisible.value;
  }

  var isVisible1 = true.obs;
  void visibilityCheck1() {
    isVisible1.value = !isVisible1.value;
  }

  var isVisible2 = true.obs;
  void visibilityCheck2() {
    isVisible2.value = !isVisible2.value;
  }
}
