class ServicesModel {
  bool? success;
  List<Services>? data;

  ServicesModel({this.success, this.data});

  ServicesModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Services>[];
      json['data'].forEach((v) {
        data!.add(Services.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Services {
  int? id;
  dynamic creatorId;
  String? title;
  String? slug;
  String? category;
  String? description;
  String? image;

  Services({this.id, this.creatorId, this.title, this.slug, this.category, this.description, this.image});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    creatorId = json['creator_id'];
    title = json['title'];
    slug = json['slug'];
    category = json['category'];
    description = json['description'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['creator_id'] = creatorId;
    data['title'] = title;
    data['slug'] = slug;
    data['category'] = category;
    data['description'] = description;
    data['image'] = image;
    return data;
  }
}
