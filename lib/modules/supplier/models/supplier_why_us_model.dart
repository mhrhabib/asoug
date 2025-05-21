class SupplierWhyUsModel {
  bool? success;
  Data? data;

  SupplierWhyUsModel({this.success, this.data});

  SupplierWhyUsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Heading? heading;
  List<Elements>? elements;

  Data({this.heading, this.elements});

  Data.fromJson(Map<String, dynamic> json) {
    heading = json['heading'] != null ? Heading.fromJson(json['heading']) : null;
    if (json['elements'] != null) {
      elements = <Elements>[];
      json['elements'].forEach((v) {
        elements!.add(Elements.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (heading != null) {
      data['heading'] = heading!.toJson();
    }
    if (elements != null) {
      data['elements'] = elements!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Heading {
  String? title;
  String? description;

  Heading({this.title, this.description});

  Heading.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    return data;
  }
}

class Elements {
  String? title;
  String? description;
  String? image;

  Elements({this.title, this.description, this.image});

  Elements.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['image'] = image;
    return data;
  }
}
