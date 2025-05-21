import 'package:asoug/core/network/base_client.dart';
import 'package:asoug/core/network/urls.dart';
import '../models/supplier_banner_model.dart';
import '../models/supplier_faq_model.dart';
import '../models/supplier_product_video_model.dart';
import '../models/supplier_why_us_model.dart';

class SupplierLoginRepository {
  Future<SupplierBannerModel> getSupplierBanner() async {
    try {
      final response = await BaseClient.get(url: Urls.supplierBanner);
      if (response.statusCode == 200) {
        return SupplierBannerModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load supplier banner');
      }
    } catch (e) {
      throw Exception('Failed to fetch supplier banner: $e');
    }
  }

  Future<SupplierWhyUsModel> getWhyUs() async {
    try {
      final response = await BaseClient.get(url: Urls.supplierWhyUs);
      if (response.statusCode == 200) {
        return SupplierWhyUsModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load why us content');
      }
    } catch (e) {
      throw Exception('Failed to fetch why us content: $e');
    }
  }

  Future<SupplierProductVideoModel> getProductVideo() async {
    try {
      final response = await BaseClient.get(url: Urls.supplierProductVideo);
      if (response.statusCode == 200) {
        return SupplierProductVideoModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load product video');
      }
    } catch (e) {
      throw Exception('Failed to fetch product video: $e');
    }
  }

  Future<SupplierFaqModel> getFaqs() async {
    try {
      final response = await BaseClient.get(url: Urls.supplierFaqs);
      if (response.statusCode == 200) {
        return SupplierFaqModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load FAQs');
      }
    } catch (e) {
      throw Exception('Failed to fetch FAQs: $e');
    }
  }
}
