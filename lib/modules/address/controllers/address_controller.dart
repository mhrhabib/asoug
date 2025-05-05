import 'package:get/get.dart';
import '../models/address_model.dart';
import '../repo/address_repository.dart';

class AddressController extends GetxController {
  final AddressRepository _repository = AddressRepository();

  List<Address> addressModel = <Address>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    fetchAddresses();
    super.onInit();
  }

  Future<void> fetchAddresses() async {
    try {
      isLoading.value = true;
      final result = await _repository.getAddresses();
      addressModel = result;
      errorMessage.value = '';
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addAddress(Map<String, dynamic> addressData) async {
    try {
      isLoading.value = true;
      var response = await _repository.addAddress({
        'name': addressData['name'],
        'email': addressData['email'],
        'phone': addressData['phone'],
        'address': addressData['address1'],
        'address_2': addressData['address2'],
        'country': int.tryParse(addressData['country'] ?? '1') ?? 1,
        'state': int.tryParse(addressData['state'] ?? '1') ?? 1,
        'city': addressData['city'],
        'zip_code': addressData['zip'],
        'is_default': addressData['isDefault'] == 'true',
      });

      if (response != null) {
        await fetchAddresses();
      }

      errorMessage.value = '';
      Get.back();
      Get.snackbar('Success', 'Address added successfully');
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', 'Failed to add address');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateAddress(int id, Map<String, dynamic> addressData) async {
    try {
      isLoading.value = true;
      final updatedAddress = await _repository.updateAddress(id, {
        'name': addressData['name'],
        'email': addressData['email'],
        'phone': addressData['phone'],
        'address': addressData['address1'],
        'address_2': addressData['address2'],
        'country': int.tryParse(addressData['country'] ?? '1') ?? 1,
        'state': int.tryParse(addressData['state'] ?? '1') ?? 1,
        'city': addressData['city'],
        'zip_code': addressData['zip'],
        'is_default': addressData['isDefault'] == 'true',
      });

      await fetchAddresses();

      errorMessage.value = '';
      Get.back();
      Get.snackbar('Success', 'Address updated successfully');
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', 'Failed to update address');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteAddress(int id) async {
    try {
      isLoading.value = true;
      final success = await _repository.deleteAddress(id);
      if (success) {
        await fetchAddresses();
        Get.snackbar('Success', 'Address deleted successfully');
      }
      errorMessage.value = '';
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', 'Failed to delete address');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> setDefaultAddress(int id) async {
    try {
      isLoading.value = true;
      final success = await _repository.setDefaultAddress(id);
      if (success) {
        await fetchAddresses();
        Get.snackbar('Success', 'Default address updated');
      }
      errorMessage.value = '';
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', 'Failed to set default address');
    } finally {
      isLoading.value = false;
    }
  }
}
