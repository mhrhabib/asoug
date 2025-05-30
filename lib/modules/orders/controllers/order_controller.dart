import 'package:get/get.dart';
import '../models/order_model.dart';
import '../repo/order_repo.dart';

class OrderController extends GetxController {
  final OrderRepository _repository = OrderRepository();

  Rx<OrderModel?> orders = Rx<OrderModel?>(null);
  Rx<OrderModel?> buyerOrders = Rx<OrderModel?>(null);
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxBool isCreatingOrder = false.obs;

  @override
  void onInit() {
    fetchOrders();
    super.onInit();
  }

  Future<void> fetchOrders() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final result = await _repository.getOrders();
      orders.value = result;
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', 'Failed to fetch orders');
    } finally {
      isLoading.value = false;
    }
  }

  RxString selectedStatus = '0'.obs;

  List<Orders> get filteredOrders {
    if (selectedStatus.value == '0') {
      return orders.value?.data ?? [];
    } else {
      return orders.value?.data?.where((order) => order.status.toString() == selectedStatus.value).toList() ?? [];
    }
  }

  Future<void> fetchBuyerOrders() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final result = await _repository.getBuyerOrders();
      buyerOrders.value = result;
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', 'Failed to fetch buyer orders');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createOrder({
    required int shippingAddress,
    required int billingAddress,
    required int paymentMethod,
    required int shippingMethod,
    String couponCode = '',
  }) async {
    try {
      isCreatingOrder.value = true;
      errorMessage.value = '';

      final result = await _repository.createOrder(
        shippingAddress: 1,
        billingAddress: billingAddress,
        paymentMethod: paymentMethod,
        shippingMethod: shippingMethod,
        couponCode: couponCode,
      );

      // Add the new order to the orders list
      if (orders.value != null) {
        orders.value!.data = [...?orders.value?.data, ...?result.data];
      } else {
        orders.value = result;
      }

      Get.snackbar('Success', 'Order created successfully');
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', 'Failed to create order');
      rethrow;
    } finally {
      isCreatingOrder.value = false;
    }
  }

  // Helper to get order by ID
  // Orders? getOrderById(int orderId) {
  //   return orders.value?.orders?.firstWhere(
  //     (order) => order.id == orderId,
  //     orElse: () => null,
  //   );
  // }

  // // Helper to get buyer's order by ID
  // Orders? getBuyerOrderById(int orderId) {
  //   return buyerOrders.value?.orders?.firstWhere(
  //     (order) => order.id == orderId,
  //     orElse: () => null,
  //   );
  // }

  // Helper to get total number of orders
  int get totalOrders => orders.value?.data?.length ?? 0;

  // Helper to get total number of buyer's orders
  int get totalBuyerOrders => buyerOrders.value?.data?.length ?? 0;
}
