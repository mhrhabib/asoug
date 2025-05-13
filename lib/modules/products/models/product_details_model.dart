// To parse this JSON data, do
//
//     final productDetailsModel = productDetailsModelFromJson(jsonString);

import 'dart:convert';

ProductDetailsModel productDetailsModelFromJson(String str) => ProductDetailsModel.fromJson(json.decode(str));

String productDetailsModelToJson(ProductDetailsModel data) => json.encode(data.toJson());

class ProductDetailsModel {
  Data? data;

  ProductDetailsModel({
    this.data,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) => ProductDetailsModel(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
      };
}

class Data {
  int? id;
  String? productType;
  dynamic variationId;
  String? name;
  String? featuredImage;
  List<Image>? images;
  List<dynamic>? attributes;
  Company? company;
  String? hasBulkDiscount;
  dynamic minPrice;
  String? maxPrice;
  List<dynamic>? prices;
  String? minOrderQty;
  String? unit;
  String? hasVariations;
  String? isStockUnlimited;
  int? inStock;
  String? description;
  String? rating;
  List<dynamic>? reviews;
  Ratings? ratings;
  int? totalSales;
  int? totalWishlist;
  bool? inWishlist;
  bool? isShippable;
  dynamic shippingMethod;
  List<Product>? relatedProducts;
  String? slug;

  Data({
    this.id,
    this.productType,
    this.variationId,
    this.name,
    this.featuredImage,
    this.images,
    this.attributes,
    this.company,
    this.hasBulkDiscount,
    this.minPrice,
    this.maxPrice,
    this.prices,
    this.minOrderQty,
    this.unit,
    this.hasVariations,
    this.isStockUnlimited,
    this.inStock,
    this.description,
    this.rating,
    this.reviews,
    this.ratings,
    this.totalSales,
    this.totalWishlist,
    this.inWishlist,
    this.isShippable,
    this.shippingMethod,
    this.relatedProducts,
    this.slug,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        productType: json["product_type"],
        variationId: json["variation_id"],
        name: json["name"],
        featuredImage: json["featured_image"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        attributes: List<dynamic>.from(json["attributes"].map((x) => x)),
        company: Company.fromJson(json["company"]),
        hasBulkDiscount: json["has_bulk_discount"],
        minPrice: json["min_price"],
        maxPrice: json["max_price"],
        prices: List<dynamic>.from(json["prices"].map((x) => x)),
        minOrderQty: json["min_order_qty"],
        unit: json["unit"],
        hasVariations: json["has_variations"],
        isStockUnlimited: json["is_stock_unlimited"],
        inStock: json["in_stock"],
        description: json["description"],
        rating: json["rating"],
        reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
        ratings: Ratings.fromJson(json["ratings"]),
        totalSales: json["total_sales"],
        totalWishlist: json["total_wishlist"],
        inWishlist: json["in_wishlist"],
        isShippable: json["is_shippable"],
        shippingMethod: json["shipping_method"],
        relatedProducts: List<Product>.from(json["related_products"].map((x) => Product.fromJson(x))),
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_type": productType,
        "variation_id": variationId,
        "name": name,
        "featured_image": featuredImage,
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
        "attributes": List<dynamic>.from(attributes!.map((x) => x)),
        "company": company!.toJson(),
        "has_bulk_discount": hasBulkDiscount,
        "min_price": minPrice,
        "max_price": maxPrice,
        "prices": List<dynamic>.from(prices!.map((x) => x)),
        "min_order_qty": minOrderQty,
        "unit": unit,
        "has_variations": hasVariations,
        "is_stock_unlimited": isStockUnlimited,
        "in_stock": inStock,
        "description": description,
        "rating": rating,
        "reviews": List<dynamic>.from(reviews!.map((x) => x)),
        "ratings": ratings!.toJson(),
        "total_sales": totalSales,
        "total_wishlist": totalWishlist,
        "in_wishlist": inWishlist,
        "is_shippable": isShippable,
        "shipping_method": shippingMethod,
        "related_products": List<dynamic>.from(relatedProducts!.map((x) => x.toJson())),
        "slug": slug,
      };
}

class Company {
  String? name;
  String? country;
  String? rating;
  String? slug;
  List<Product>? products;

  Company({
    this.name,
    this.country,
    this.rating,
    this.slug,
    this.products,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        name: json["name"],
        country: json["country"],
        rating: json["rating"],
        slug: json["slug"],
        products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "country": country,
        "rating": rating,
        "slug": slug,
        "products": List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class Product {
  int? id;
  String? name;
  String? hasBulkDiscount;
  dynamic minPrice;
  String? maxPrice;
  String? rating;
  String? featuredImage;
  String? slug;

  Product({
    this.id,
    this.name,
    this.hasBulkDiscount,
    this.minPrice,
    this.maxPrice,
    this.rating,
    this.featuredImage,
    this.slug,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
        hasBulkDiscount: json["has_bulk_discount"],
        minPrice: json["min_price"],
        maxPrice: json["max_price"],
        rating: json["rating"],
        featuredImage: json["featured_image"],
        slug: json["slug"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "has_bulk_discount": hasBulkDiscount,
        "min_price": minPrice,
        "max_price": maxPrice,
        "rating": rating,
        "featured_image": featuredImage,
        "slug": slug,
      };
}

class Image {
  int? id;
  String? fileName;
  String? url;
  String? size;

  Image({
    this.id,
    this.fileName,
    this.url,
    this.size,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        fileName: json["file_name"],
        url: json["url"],
        size: json["size"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "file_name": fileName,
        "url": url,
        "size": size,
      };
}

class Ratings {
  int? rating1;
  int? rating2;
  int? rating3;
  int? rating4;
  int? rating5;

  Ratings({
    this.rating1,
    this.rating2,
    this.rating3,
    this.rating4,
    this.rating5,
  });

  factory Ratings.fromJson(Map<String, dynamic> json) => Ratings(
        rating1: json["rating1"],
        rating2: json["rating2"],
        rating3: json["rating3"],
        rating4: json["rating4"],
        rating5: json["rating5"],
      );

  Map<String, dynamic> toJson() => {
        "rating1": rating1,
        "rating2": rating2,
        "rating3": rating3,
        "rating4": rating4,
        "rating5": rating5,
      };
}
