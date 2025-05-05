class AddressModel {
  List<Address>? data;

  AddressModel({this.data});

  AddressModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Address>[];
      json['data'].forEach((v) {
        data!.add(Address.fromJson(v));
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

class Address {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? address;
  String? address2;
  int? country;
  String? countryName;
  int? state;
  String? stateName;
  String? city;
  String? zipCode;
  int? isDefault;

  Address({this.id, this.name, this.email, this.phone, this.address, this.address2, this.country, this.countryName, this.state, this.stateName, this.city, this.zipCode, this.isDefault});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    address2 = json['address_2'];
    country = json['country'];
    countryName = json['country_name'];
    state = json['state'];
    stateName = json['state_name'];
    city = json['city'];
    zipCode = json['zip_code'];
    isDefault = json['is_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    data['address_2'] = address2;
    data['country'] = country;
    data['country_name'] = countryName;
    data['state'] = state;
    data['state_name'] = stateName;
    data['city'] = city;
    data['zip_code'] = zipCode;
    data['is_default'] = isDefault;
    return data;
  }
}
