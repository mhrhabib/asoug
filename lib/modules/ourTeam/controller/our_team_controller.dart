import 'package:get/get.dart';
import '../model/our_team_model.dart';
import '../repo/our_team_repo.dart';

class OurTeamController extends GetxController {
  final OurTeamRepository _repository = OurTeamRepository();

  final isLoading = false.obs;
  final ourTeamData = Rxn<OurTeamModel>();
  final errorMessage = RxString('');
  final featuredMembers = <Team>[].obs;

  @override
  void onInit() {
    fetchOurTeam();
    super.onInit();
  }

  Future<void> fetchOurTeam() async {
    try {
      isLoading(true);
      errorMessage('');

      final data = await _repository.getOurTeam();
      ourTeamData(data);

      if (data.data != null) {
        featuredMembers.assignAll(data.data!.where((member) => member.isFeatured == "1").toList());
      }
    } catch (e) {
      errorMessage('Failed to load team data: ${e.toString()}');
      ourTeamData(null);
      featuredMembers.clear();
    } finally {
      isLoading(false);
    }
  }
}
