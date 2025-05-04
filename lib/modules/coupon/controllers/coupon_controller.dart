import 'package:get/get.dart';
import '../repo/coupon_repo.dart';

class CouponController extends GetxController {
  final CouponRepository _repository = CouponRepository();

  RxString appliedCoupon = RxString('');
  RxBool isCouponLoading = false.obs;
  RxString couponErrorMessage = ''.obs;
  RxDouble couponDiscount = RxDouble(0.0);

  Future<void> applyCoupon(String couponCode) async {
    try {
      isCouponLoading.value = true;
      couponErrorMessage.value = '';

      final result = await _repository.applyCoupon(couponCode);

      // Update the cart with new coupon details
      appliedCoupon.value = couponCode;

      // You might want to update your cart controller here
      // For example: Get.find<CartController>().updateCartWithCoupon(result);

      Get.snackbar('Success', 'Coupon applied successfully');
    } catch (e) {
      couponErrorMessage.value = e.toString();
      Get.snackbar('Error', 'Failed to apply coupon: ${e.toString()}');
    } finally {
      isCouponLoading.value = false;
    }
  }

  Future<void> removeCoupon() async {
    try {
      isCouponLoading.value = true;
      couponErrorMessage.value = '';

      final result = await _repository.removeCoupon();

      // Clear coupon details
      appliedCoupon.value = '';
      couponDiscount.value = 0.0;

      // You might want to update your cart controller here
      // For example: Get.find<CartController>().updateCartAfterCouponRemoval(result);

      Get.snackbar('Success', 'Coupon removed successfully');
    } catch (e) {
      couponErrorMessage.value = e.toString();
      Get.snackbar('Error', 'Failed to remove coupon: ${e.toString()}');
    } finally {
      isCouponLoading.value = false;
    }
  }

  // Helper to check if a coupon is applied
  bool get hasCouponApplied => appliedCoupon.value.isNotEmpty;
}
