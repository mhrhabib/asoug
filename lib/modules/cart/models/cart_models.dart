class CartModel {
  List<Cart>? data;

  CartModel({this.data});

  CartModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Cart>[];
      json['data'].forEach((v) {
        data!.add(Cart.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cart {
  int? id;
  String? productId;
  String? productName;
  String? featuredImage;
  String? quantity;
  dynamic price;
  String? variation;
  bool? inWishlist;
  dynamic hasBulkDiscount;
  dynamic minPrice;
  String? maxPrice;
  int? shippingMethod;
  dynamic checkoutShipping;
  String? slug;

  Cart({this.id, this.productId, this.productName, this.featuredImage, this.quantity, this.price, this.variation, this.inWishlist, this.hasBulkDiscount, this.minPrice, this.maxPrice, this.shippingMethod, this.checkoutShipping, this.slug});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    productName = json['product_name'];
    featuredImage = json['featured_image'];
    quantity = json['quantity'];
    price = json['price'];
    variation = json['variation'];
    inWishlist = json['in_wishlist'];
    hasBulkDiscount = json['has_bulk_discount'];
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
    shippingMethod = json['shipping_method'];
    checkoutShipping = json['checkout_shipping'];
    slug = json['slug'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_id'] = productId;
    data['product_name'] = productName;
    data['featured_image'] = featuredImage;
    data['quantity'] = quantity;
    data['price'] = price;
    data['variation'] = variation;
    data['in_wishlist'] = inWishlist;
    data['has_bulk_discount'] = hasBulkDiscount;
    data['min_price'] = minPrice;
    data['max_price'] = maxPrice;
    data['shipping_method'] = shippingMethod;
    data['checkout_shipping'] = checkoutShipping;
    data['slug'] = slug;
    return data;
  }
}
