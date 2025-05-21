import 'package:get/get.dart';
import '../models/supplier_banner_model.dart';
import '../models/supplier_faq_model.dart';
import '../models/supplier_product_video_model.dart';
import '../models/supplier_why_us_model.dart';
import '../repo/supplier_login_repo.dart';

class SupplierLoginController extends GetxController {
  final SupplierLoginRepository _repository = SupplierLoginRepository();

  // Banner Section
  final bannerData = Rxn<SupplierBannerModel>();
  final isLoadingBanner = false.obs;
  final bannerError = RxString('');

  // Why Us Section
  final whyUsData = Rxn<SupplierWhyUsModel>();
  final isLoadingWhyUs = false.obs;
  final whyUsError = RxString('');

  // Product Video Section
  final productVideoData = Rxn<SupplierProductVideoModel>();
  final isLoadingProductVideo = false.obs;
  final productVideoError = RxString('');

  // FAQs Section
  final faqsData = Rxn<SupplierFaqModel>();
  final isLoadingFaqs = false.obs;
  final faqsError = RxString('');

  @override
  void onInit() {
    fetchAllData();
    super.onInit();
  }

  Future<void> fetchAllData() async {
    await Future.wait([
      fetchBannerData(),
      fetchWhyUsData(),
      fetchProductVideoData(),
      fetchFaqsData(),
    ]);
  }

  Future<void> fetchBannerData() async {
    try {
      isLoadingBanner(true);
      bannerError('');
      final data = await _repository.getSupplierBanner();
      bannerData(data);
    } catch (e) {
      bannerError('Failed to load banner: ${e.toString()}');
      bannerData(null);
    } finally {
      isLoadingBanner(false);
    }
  }

  Future<void> fetchWhyUsData() async {
    try {
      isLoadingWhyUs(true);
      whyUsError('');
      final data = await _repository.getWhyUs();
      whyUsData(data);
    } catch (e) {
      whyUsError('Failed to load why us content: ${e.toString()}');
      whyUsData(null);
    } finally {
      isLoadingWhyUs(false);
    }
  }

  Future<void> fetchProductVideoData() async {
    try {
      isLoadingProductVideo(true);
      productVideoError('');
      final data = await _repository.getProductVideo();
      productVideoData(data);
    } catch (e) {
      productVideoError('Failed to load product video: ${e.toString()}');
      productVideoData(null);
    } finally {
      isLoadingProductVideo(false);
    }
  }

  Future<void> fetchFaqsData() async {
    try {
      isLoadingFaqs(true);
      faqsError('');
      final data = await _repository.getFaqs();
      faqsData(data);
    } catch (e) {
      faqsError('Failed to load FAQs: ${e.toString()}');
      faqsData(null);
    } finally {
      isLoadingFaqs(false);
    }
  }
}
