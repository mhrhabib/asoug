class OrderModel {
  bool? success;
  String? message;
  List<Orders>? data;

  OrderModel({this.success, this.message, this.data});

  OrderModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Orders>[];
      json['data'].forEach((v) {
        data!.add(Orders.fromJson(v));
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

class Orders {
  int? id;
  int? orderId;
  String? subtotal;
  String? tax;
  String? total;
  int? status;
  List<Companies>? companies;

  Orders({this.id, this.orderId, this.subtotal, this.tax, this.total, this.status, this.companies});

  Orders.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    subtotal = json['subtotal'];
    tax = json['tax'];
    total = json['total'];
    status = json['status'];
    if (json['companies'] != null) {
      companies = <Companies>[];
      json['companies'].forEach((v) {
        companies!.add(Companies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['subtotal'] = subtotal;
    data['tax'] = tax;
    data['total'] = total;
    data['status'] = status;
    if (companies != null) {
      data['companies'] = companies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Companies {
  int? companyId;
  String? companyName;
  dynamic companyLogo;
  String? companyLogoPath;
  String? companySlug;
  List<Products>? products;

  Companies({this.companyId, this.companyName, this.companyLogo, this.companyLogoPath, this.companySlug, this.products});

  Companies.fromJson(Map<String, dynamic> json) {
    companyId = json['company_id'];
    companyName = json['company_name'];
    companyLogo = json['company_logo'];
    companyLogoPath = json['company_logo_path'];
    companySlug = json['company_slug'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['company_id'] = companyId;
    data['company_name'] = companyName;
    data['company_logo'] = companyLogo;
    data['company_logo_path'] = companyLogoPath;
    data['company_slug'] = companySlug;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? id;
  String? name;
  String? price;
  int? quantity;
  String? image;
  String? imagePath;
  String? total;

  Products({this.id, this.name, this.price, this.quantity, this.image, this.imagePath, this.total});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    quantity = json['quantity'];
    image = json['image'];
    imagePath = json['image_path'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['price'] = price;
    data['quantity'] = quantity;
    data['image'] = image;
    data['image_path'] = imagePath;
    data['total'] = total;
    return data;
  }
}
