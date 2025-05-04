import 'package:get/get.dart';
import '../models/address_model.dart';
import '../repo/address_repository.dart';

class AddressController extends GetxController {
  final AddressRepository _repository = AddressRepository();

  RxList<AddressModel> addresses = <AddressModel>[].obs;
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
      addresses.assignAll(result);
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
      // addresses.add(newAddress);
      if (response != null) {
        await fetchAddresses();
      }

      errorMessage.value = '';
      Get.back(); // Close add/edit screen
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
      final index = addresses.indexWhere((a) => a.id == id);
      if (index != -1) {
        addresses[index] = updatedAddress;
      }
      errorMessage.value = '';
      Get.back(); // Close add/edit screen
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
        addresses.removeWhere((a) => a.id == id);
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
        // Update all addresses' isDefault status
        for (var address in addresses) {
          address.isDefault = address.id == id;
        }
        addresses.refresh();
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
