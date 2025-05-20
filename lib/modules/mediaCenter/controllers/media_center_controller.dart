import 'package:asoug/modules/mediaCenter/models/our_goal_model.dart';
import 'package:asoug/modules/mediaCenter/repo/media_center_repo.dart';
import 'package:get/get.dart';

import '../models/course_program_model.dart';
import '../models/our_mission_model.dart';

class MediaCenterController extends GetxController {
  final isLoading = false.obs;
  final ourMissionData = Rxn<OurMissionModel>();
  final errorMessage = RxString('');
  final courseProgramData = Rxn<CourseProgramModel>();
  final ourGoalData = Rxn<OurGoalModel>();

  @override
  void onInit() {
    fetchOurMission();
    fetchCoursePrograms();
    fetchOurGoals();
    super.onInit();
  }

  Future<void> fetchOurMission() async {
    try {
      isLoading(true);
      errorMessage('');

      final data = await MediaCenterRepo().getOurMission();
      ourMissionData(data);
    } catch (e) {
      errorMessage('Failed to load our mission: ${e.toString()}');
      ourMissionData(null);
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchCoursePrograms() async {
    try {
      isLoading(true);
      errorMessage('');

      final data = await MediaCenterRepo().getCoursePrograms();
      courseProgramData(data);
    } catch (e) {
      errorMessage('Failed to load courses and programs: ${e.toString()}');
      courseProgramData(null);
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchOurGoals() async {
    try {
      isLoading(true);
      errorMessage('');

      final data = await MediaCenterRepo().getOurGoals();
      ourGoalData(data);
    } catch (e) {
      errorMessage('Failed to load courses and programs: ${e.toString()}');
      ourGoalData(null);
    } finally {
      isLoading(false);
    }
  }
}
