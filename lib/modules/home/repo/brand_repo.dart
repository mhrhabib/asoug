import 'package:asoug/core/network/base_client.dart';
import 'package:asoug/core/network/urls.dart';
import '../models/brand_model.dart';

class BrandRepo {
  Future<List<BrandModel>> fetchBrands() async {
    final response = await BaseClient.get(url: Urls.getBrandsUrl);
    if (response.statusCode == 200) {
      List data = response.data['data'];
      return data.map((e) => BrandModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load brands');
    }
  }
}
