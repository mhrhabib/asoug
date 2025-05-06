import 'package:asoug/core/network/base_client.dart';
import 'package:asoug/core/network/urls.dart';

import '../models/about_model.dart';

class AboutRepository {
  Future<AboutModel> getAboutData() async {
    try {
      final response = await BaseClient.get(url: Urls.aboutUsUrl);

      if (response.statusCode == 200) {
        return AboutModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load about data');
      }
    } catch (e) {
      throw Exception('Failed to fetch about data: $e');
    }
  }
}
