class SettingsModel {
  bool? success;
  Data? data;

  SettingsModel({this.success, this.data});

  SettingsModel.fromJson(Map<String, dynamic> json) {
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
  String? logo;
  String? appName;
  String? appDescription;
  String? appEmail;
  String? appPhone;
  String? appVersion;

  Data({this.logo, this.appName, this.appDescription, this.appEmail, this.appPhone, this.appVersion});

  Data.fromJson(Map<String, dynamic> json) {
    logo = json['logo'];
    appName = json['app_name'];
    appDescription = json['app_description'];
    appEmail = json['app_email'];
    appPhone = json['app_phone'];
    appVersion = json['app_version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['logo'] = logo;
    data['app_name'] = appName;
    data['app_description'] = appDescription;
    data['app_email'] = appEmail;
    data['app_phone'] = appPhone;
    data['app_version'] = appVersion;
    return data;
  }
}
