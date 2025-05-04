import 'package:asoug/core/network/urls.dart';
import '../../network/base_client.dart';
import './models/settings_model.dart';

class GeneralSettingsRepository {
  Future<SettingsModel?> fetchSettings() async {
    try {
      final response = await BaseClient.get(url: Urls.getSettingsUrl);
      if (response.statusCode == 200 && response.data != null) {
        return SettingsModel.fromJson(response.data);
      } else {
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception in fetchSettings: $e');
      return null;
    }
  }
}
