class SuppliersModel {
  bool? success;
  Data? data;

  SuppliersModel({this.success, this.data});

  SuppliersModel.fromJson(Map<String, dynamic> json) {
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
  int? currentPage;
  List<Supplier>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  dynamic nextPageUrl;
  String? path;
  int? perPage;
  dynamic prevPageUrl;
  int? to;
  int? total;

  Data({this.currentPage, this.data, this.firstPageUrl, this.from, this.lastPage, this.lastPageUrl, this.links, this.nextPageUrl, this.path, this.perPage, this.prevPageUrl, this.to, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Supplier>[];
      json['data'].forEach((v) {
        data!.add(Supplier.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class Supplier {
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

  Supplier(
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

  Supplier.fromJson(Map<String, dynamic> json) {
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

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}
