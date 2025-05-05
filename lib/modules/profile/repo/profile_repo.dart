import 'dart:io';

import 'package:asoug/core/network/urls.dart';
import '../../../core/network/base_client.dart';
import '../models/profile_model.dart';
import 'package:dio/dio.dart' as dio;

class ProfileRepository {
  Future<ProfileModel?> fetchProfile() async {
    try {
      final response = await BaseClient.get(url: Urls.getUserUrl);
      if (response.statusCode == 200 && response.data != null) {
        return ProfileModel.fromJson(response.data);
      } else {
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Exception in fetchProfile: $e');
      return null;
    }
  }

  Future<bool> updateProfile(Map<String, dynamic> data) async {
    try {
      final response = await BaseClient.put(url: Urls.updateProfileURl, payload: data);
      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to update profile: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Exception in updateProfile: $e');
      return false;
    }
  }

  Future<bool> updatePassword({required String currentPassword, required String password, required String passwordConfirmation}) async {
    try {
      final payload = {
        "current_password": currentPassword,
        "password": password,
        "password_confirmation": passwordConfirmation,
      };
      print(payload);
      final response = await BaseClient.put(url: Urls.updatePasswordUrl, payload: payload);
      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to update password: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('Exception in updatePassword: $e');
      return false;
    }
  }

  Future<bool> updateAvatar(File? avatarFile) async {
    try {
      final formData = dio.FormData.fromMap({
        // Make sure the key 'avatar' matches the backend expectation
        "avatar": await dio.MultipartFile.fromFile(
          avatarFile!.path,
          filename: avatarFile.path.split('/').last,
        ),
      });

      final response = await BaseClient.put(
        url: Urls.updateAvatarUrl,
        payload: formData,
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print('Failed to update avatar: ${response.statusCode}');
        print('Response data: ${response.data}');
        return false;
      }
    } catch (e) {
      print('Exception in updateAvatar: $e');
      return false;
    }
  }
}
