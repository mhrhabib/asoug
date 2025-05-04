import 'package:get/get.dart';
import '../models/cart_models.dart';
import '../repo/cart_repo.dart';

class CartController extends GetxController {
  final CartRepository _repository = CartRepository();

  Rx<CartModel?> cart = Rx<CartModel?>(null);
  Rx<CartModel?> cartSummary = Rx<CartModel?>(null);
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    fetchCart();
    super.onInit();
  }

  Future<void> fetchCart() async {
    try {
      isLoading.value = true;
      final result = await _repository.getCart();
      cart.value = result;
      errorMessage.value = '';
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addToCart(Map<String, dynamic> cartData) async {
    try {
      isLoading.value = true;
      final result = await _repository.addToCart(cartData);
      cart.value = result;
      errorMessage.value = '';
      Get.snackbar('Success', 'Item added to cart');
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', 'Failed to add item to cart');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateCartItem(int cartId, Map<String, dynamic> cartData) async {
    try {
      isLoading.value = true;
      final result = await _repository.updateCartItem(cartId, cartData);
      cart.value = result;
      errorMessage.value = '';
      Get.snackbar('Success', 'Cart item updated');
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', 'Failed to update cart item');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removeFromCart(int cartId) async {
    try {
      isLoading.value = true;
      final success = await _repository.removeFromCart(cartId);
      if (success) {
        await fetchCart(); // Refresh the cart after removal
        Get.snackbar('Success', 'Item removed from cart');
      }
      errorMessage.value = '';
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', 'Failed to remove item from cart');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchCartSummary() async {
    try {
      isLoading.value = true;
      final result = await _repository.getCartSummary();
      cartSummary.value = result;
      errorMessage.value = '';
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // Helper method to calculate total items in cart
  int get totalItems {
    if (cart.value?.data == null || cart.value!.data!.isEmpty) return 0;
    return cart.value!.data!.fold(0, (sum, item) => sum + (item.quantity ?? 0));
  }

  // Helper method to calculate total price
  double get totalPrice {
    if (cart.value?.data == null || cart.value!.data!.isEmpty) return 0.0;
    return cart.value!.data!.fold(0.0, (sum, item) => sum + (item.total ?? 0.0));
  }
}
