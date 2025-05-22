class PostSupportsModel {
  bool? success;
  Data? data;

  PostSupportsModel({this.success, this.data});

  PostSupportsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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
  int? userId;
  String? issue;
  String? ticket;
  dynamic attachment;
  String? description;
  String? status;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? attachmentUrl;

  Data({this.userId, this.issue, this.ticket, this.attachment, this.description, this.status, this.updatedAt, this.createdAt, this.id, this.attachmentUrl});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    issue = json['issue'];
    ticket = json['ticket'];
    attachment = json['attachment'];
    description = json['description'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    attachmentUrl = json['attachment_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['issue'] = issue;
    data['ticket'] = ticket;
    data['attachment'] = attachment;
    data['description'] = description;
    data['status'] = status;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['attachment_url'] = attachmentUrl;
    return data;
  }
}
