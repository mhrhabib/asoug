import 'package:asoug/core/network/base_client.dart';
import 'package:asoug/core/network/urls.dart';
import 'package:asoug/modules/home/models/join_our_team_model.dart';

import '../models/home_banner_model.dart';
import '../models/media_center_model.dart';
import '../models/services_model.dart';

class ServicesRepository {
  Future<ServicesModel> getServices({int page = 1}) async {
    try {
      final response = await BaseClient.get(url: Urls.getServicesUrl);

      if (response.statusCode == 200) {
        return ServicesModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load services');
      }
    } catch (e) {
      throw Exception('Failed to fetch services: $e');
    }
  }

  Future<Services> getServiceDetails(int id) async {
    try {
      final response = await BaseClient.get(
        url: Urls.getServicesUrl + '/$id',
      );

      if (response.statusCode == 200) {
        return Services.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to load service details');
      }
    } catch (e) {
      throw Exception('Failed to fetch service details: $e');
    }
  }

  Future<JoinOurTeamModel> getJoinOurTeam() async {
    try {
      final response = await BaseClient.get(url: Urls.getJoinOurTeamUrl);

      if (response.statusCode == 200) {
        return JoinOurTeamModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load services');
      }
    } catch (e) {
      throw Exception('Failed to fetch services: $e');
    }
  }

  Future<MediaCenterModel> getMediaCenterData() async {
    try {
      final response = await await BaseClient.get(url: Urls.getMediaUrl);

      if (response.statusCode == 200) {
        return MediaCenterModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load media center data');
      }
    } catch (e) {
      throw Exception('Failed to fetch media center data: $e');
    }
  }

  // Add this method to your existing ServicesRepository class
  Future<HomeBannerModel> getHomeBanner() async {
    try {
      final response = await BaseClient.get(url: Urls.homeBannerUrl);

      if (response.statusCode == 200) {
        return HomeBannerModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load home banner');
      }
    } catch (e) {
      throw Exception('Failed to fetch home banner: $e');
    }
  }
}
