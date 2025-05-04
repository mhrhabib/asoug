class CartModel {
  bool? success;
  String? message;
  List<Data>? data;

  CartModel({this.success, this.message, this.data});

  CartModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? productId;
  String? productName;
  int? quantity;
  double? price;
  double? total;
  int? shippingCost;
  String? shippingMethod;
  String? shippingAddress;
  String? createdAt;
  String? updatedAt;

  Data({this.id, this.productId, this.productName, this.quantity, this.price, this.total, this.shippingCost, this.shippingMethod, this.shippingAddress, this.createdAt, this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    productName = json['product_name'];
    quantity = json['quantity'];
    price = json['price'];
    total = json['total'];
    shippingCost = json['shipping_cost'];
    shippingMethod = json['shipping_method'];
    shippingAddress = json['shipping_address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['quantity'] = quantity;
    data['price'] = price;
    data['total'] = total;
    data['shipping_cost'] = shippingCost;
    data['shipping_method'] = shippingMethod;
    data['shipping_address'] = shippingAddress;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
