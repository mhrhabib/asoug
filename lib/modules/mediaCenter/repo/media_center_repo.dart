import 'package:asoug/modules/mediaCenter/models/our_goal_model.dart';

import '../../../core/network/base_client.dart';
import '../../../core/network/urls.dart';
import '../models/course_program_model.dart';
import '../models/our_mission_model.dart';

class MediaCenterRepo {
  Future<OurMissionModel> getOurMission() async {
    try {
      final response = await BaseClient.get(url: Urls.getOurMission);

      if (response.statusCode == 200) {
        return OurMissionModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load our mission data');
      }
    } catch (e) {
      throw Exception('Failed to fetch our mission data: $e');
    }
  }

  Future<CourseProgramModel> getCoursePrograms() async {
    try {
      final response = await BaseClient.get(url: Urls.courseAndPrograms);

      if (response.statusCode == 200) {
        return CourseProgramModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load courses and programs');
      }
    } catch (e) {
      throw Exception('Failed to fetch courses and programs: $e');
    }
  }

  Future<OurGoalModel> getOurGoals() async {
    try {
      final response = await BaseClient.get(url: Urls.getOurGoals);

      if (response.statusCode == 200) {
        return OurGoalModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load courses and programs');
      }
    } catch (e) {
      throw Exception('Failed to fetch courses and programs: $e');
    }
  }
}
