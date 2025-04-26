import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/ticket_controller.dart';

class CustomImagePickerForTicket extends StatelessWidget {
  final Function(String imagePath) onImagePicked;
  final String? imagePath;

  CustomImagePickerForTicket({super.key, required this.onImagePicked, required this.imagePath});

  final TicketController controller = Get.put(TicketController());

  void _pickImage(BuildContext context, ImageSource source, String imagePath) async {
    try {
      var image = await controller.imagePicker.pickImage(source: source);
      if (image != null) {
        imagePath = image.path;
        onImagePicked(imagePath); // Callback with the selected image path
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to pick image: $e");
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(
            onPressed: () => _pickImage(context, ImageSource.camera, imagePath!),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.camera),
                const Gap(12),
                Text(
                  "Capture Photo",
                  style: context.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () => _pickImage(context, ImageSource.gallery, imagePath!),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(FontAwesomeIcons.fileImage),
                const Gap(12),
                Text(
                  "Choose from Gallery",
                  style: context.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> show(BuildContext context, Function(String imagePath) onImagePicked, String imagePath) async {
    await showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (context) => CustomImagePickerForTicket(
        onImagePicked: onImagePicked,
        imagePath: imagePath,
      ),
    );
  }
}
