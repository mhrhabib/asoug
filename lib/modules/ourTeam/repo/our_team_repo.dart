import 'package:asoug/core/network/base_client.dart';
import 'package:asoug/core/network/urls.dart';
import '../model/our_team_model.dart';

class OurTeamRepository {
  Future<OurTeamModel> getOurTeam() async {
    try {
      final response = await BaseClient.get(url: Urls.getOurTeam);

      if (response.statusCode == 200) {
        return OurTeamModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load our team data');
      }
    } catch (e) {
      throw Exception('Failed to fetch our team data: $e');
    }
  }
}
