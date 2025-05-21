class SupplierDetailsModel {
  bool? success;
  Data? data;

  SupplierDetailsModel({this.success, this.data});

  SupplierDetailsModel.fromJson(Map<String, dynamic> json) {
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
  int? id;
  dynamic companyId;
  dynamic companyUid;
  String? logo;
  String? name;
  dynamic arabicName;
  String? mainProducts;
  String? businessType;
  String? numberOfEmployees;
  String? yearOfEstablishment;
  dynamic averageLeadTime;
  String? companySize;
  String? commercialRegistrationNumber;
  String? taxNumber;
  dynamic tradeLicense;
  dynamic nid;
  String? commercialRegisterDocument;
  dynamic website;
  String? companyDescription;
  String? slug;
  String? isVerified;
  String? isApproved;
  String? isActive;
  String? rating;
  String? holidayMode;
  String? holyDateStartDate;
  String? holyDateEndDate;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.companyId,
      this.companyUid,
      this.logo,
      this.name,
      this.arabicName,
      this.mainProducts,
      this.businessType,
      this.numberOfEmployees,
      this.yearOfEstablishment,
      this.averageLeadTime,
      this.companySize,
      this.commercialRegistrationNumber,
      this.taxNumber,
      this.tradeLicense,
      this.nid,
      this.commercialRegisterDocument,
      this.website,
      this.companyDescription,
      this.slug,
      this.isVerified,
      this.isApproved,
      this.isActive,
      this.rating,
      this.holidayMode,
      this.holyDateStartDate,
      this.holyDateEndDate,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    companyUid = json['company_uid'];
    logo = json['logo'];
    name = json['name'];
    arabicName = json['arabic_name'];
    mainProducts = json['main_products'];
    businessType = json['business_type'];
    numberOfEmployees = json['number_of_employees'];
    yearOfEstablishment = json['year_of_establishment'];
    averageLeadTime = json['average_lead_time'];
    companySize = json['company_size'];
    commercialRegistrationNumber = json['commercial_registration_number'];
    taxNumber = json['tax_number'];
    tradeLicense = json['trade_license'];
    nid = json['nid'];
    commercialRegisterDocument = json['commercial_register_document'];
    website = json['website'];
    companyDescription = json['company_description'];
    slug = json['slug'];
    isVerified = json['is_verified'];
    isApproved = json['is_approved'];
    isActive = json['is_active'];
    rating = json['rating'];
    holidayMode = json['holiday_mode'];
    holyDateStartDate = json['holy_date_start_date'];
    holyDateEndDate = json['holy_date_end_date'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['company_id'] = companyId;
    data['company_uid'] = companyUid;
    data['logo'] = logo;
    data['name'] = name;
    data['arabic_name'] = arabicName;
    data['main_products'] = mainProducts;
    data['business_type'] = businessType;
    data['number_of_employees'] = numberOfEmployees;
    data['year_of_establishment'] = yearOfEstablishment;
    data['average_lead_time'] = averageLeadTime;
    data['company_size'] = companySize;
    data['commercial_registration_number'] = commercialRegistrationNumber;
    data['tax_number'] = taxNumber;
    data['trade_license'] = tradeLicense;
    data['nid'] = nid;
    data['commercial_register_document'] = commercialRegisterDocument;
    data['website'] = website;
    data['company_description'] = companyDescription;
    data['slug'] = slug;
    data['is_verified'] = isVerified;
    data['is_approved'] = isApproved;
    data['is_active'] = isActive;
    data['rating'] = rating;
    data['holiday_mode'] = holidayMode;
    data['holy_date_start_date'] = holyDateStartDate;
    data['holy_date_end_date'] = holyDateEndDate;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
