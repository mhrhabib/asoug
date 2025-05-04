class OrderModel {
  List<Orders>? orders;

  OrderModel({this.orders});

  OrderModel.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = <Orders>[];
      json['orders'].forEach((v) {
        orders!.add(Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orders {
  int? id;
  int? userId;
  String? orderNumber;
  double? totalAmount;
  String? status;
  String? createdAt;

  Orders({this.id, this.userId, this.orderNumber, this.totalAmount, this.status, this.createdAt});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    orderNumber = json['order_number'];
    totalAmount = json['total_amount'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['order_number'] = orderNumber;
    data['total_amount'] = totalAmount;
    data['status'] = status;
    data['created_at'] = createdAt;
    return data;
  }
}
