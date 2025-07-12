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

  void buildDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 4,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header with title and close button
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  color: Color(0xFF7B168B),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'choose_a_language'.tr,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),

              // Language list
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: locale.length,
                  separatorBuilder: (context, index) => const Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  itemBuilder: (context, index) {
                    final isSelected = storage.read('local') == index;
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 24.0,
                        vertical: 8.0,
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                        child: Text(
                          locale[index]['name'][0], // First letter of language name
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        locale[index]['name'],
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                      ),
                      trailing: isSelected
                          ? Icon(
                              Icons.check_circle,
                              color: Theme.of(context).primaryColor,
                            )
                          : null,
                      onTap: () {
                        storage.write('local', index);
                        updateLanguage(locale[index]['locale']);
                        // Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),

              // Footer with current selection info
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Theme.of(context).primaryColor,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'selected_language_will_apply'.tr,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
