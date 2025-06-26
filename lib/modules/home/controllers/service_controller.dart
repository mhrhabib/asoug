import 'package:asoug/core/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/home_banner_model.dart';
import '../models/join_our_team_model.dart';
import '../models/media_center_model.dart';
import '../models/services_model.dart';
import '../repo/services_repo.dart';

class ServicesController extends GetxController {
  final ServicesRepository _repository = ServicesRepository();

  // Reactive state variables
  final Rx<ServicesModel?> services = Rx<ServicesModel?>(null);
  final RxBool isLoading = false.obs;
  final RxBool isLoadingMore = false.obs;
  final RxString errorMessage = ''.obs;
  final RxInt currentPage = 1.obs;

  @override
  void onInit() {
    fetchServices();
    fetchJoinOurTeamData();
    fetchMediaCenterData();
    fetchHomeBanner();
    super.onInit();
  }

  final bannerData = Rxn<HomeBannerModel>();

  Future<void> fetchHomeBanner() async {
    try {
      isLoading(true);
      errorMessage('');

      final data = await _repository.getHomeBanner();
      bannerData(data);
    } catch (e) {
      errorMessage('Failed to load banner data: ${e.toString()}');
      bannerData(null);
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchServices({int page = 1}) async {
    try {
      if (page == 1) {
        isLoading.value = true;
      } else {
        isLoadingMore.value = true;
      }

      errorMessage.value = '';
      final result = await _repository.getServices(page: page);

      if (page == 1) {
        services.value = result;
      } else {
        // Append new data to existing services
        services.update((val) {
          val?.data?.addAll(result.data ?? []);
        });
      }

      currentPage.value = page;
    } catch (e) {
      errorMessage.value = e.toString();
      Get.snackbar('Error', 'Failed to fetch services');
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  final isJoinLoading = false.obs;
  final joinOurTeamData = Rxn<JoinOurTeamModel>();

  Future<void> fetchJoinOurTeamData() async {
    try {
      isJoinLoading(true);
      errorMessage('');

      final data = await ServicesRepository().getJoinOurTeam();
      joinOurTeamData(data);
    } catch (e) {
      errorMessage('Failed to load data: $e');
      joinOurTeamData(null);
    } finally {
      isLoading(false);
    }
  }

  final mediaCenterData = Rxn<MediaCenterModel>();

  final featuredMedia = <Media>[].obs;
  final allMedia = <Media>[].obs;

  Future<void> fetchMediaCenterData() async {
    try {
      isLoading(true);
      errorMessage('');

      final data = await _repository.getMediaCenterData();
      mediaCenterData(data);

      if (data.data != null) {
        allMedia.assignAll(data.data!);
        featuredMedia.assignAll(data.data!.where((item) => item.isFeatured == "1").toList());
      }
    } catch (e) {
      errorMessage('Failed to load media data: ${e.toString()}');
      mediaCenterData(null);
      featuredMedia.clear();
      allMedia.clear();
    } finally {
      isLoading(false);
    }
  }

  // lacalization
  final List locale = [
    {
      'name': 'عربي',
      'locale': const Locale('ar', 'AR'),
    },
    {
      'name': 'English',
      'locale': const Locale('en', 'US'),
    },
  ];

  updateLanguage(Locale locale) {
    Get.back();
    LocalSettings().initialize();
    Get.updateLocale(locale);
  }

  buildDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (builder) {
        return AlertDialog(
          title: Text(
            'choose_a_language'.tr,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    debugPrint(index.toString());
                    storage.write('local', index);

                    updateLanguage(locale[index]['locale']);
                  },
                  child: Text(
                    locale[index]['name'],
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  color: Colors.blue,
                );
              },
              itemCount: locale.length,
            ),
          ),
        );
      },
    );
  }
}
