import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../address/add_new_address_screen.dart';
import 'controllers/ticket_controller.dart';
import 'widgets/custom_image_picker_for_ticket.dart';

class CreateTicketScreen extends StatefulWidget {
  const CreateTicketScreen({super.key});

  @override
  State<CreateTicketScreen> createState() => _CreateTicketScreenState();
}

class _CreateTicketScreenState extends State<CreateTicketScreen> {
  final TicketController controller = Get.put(TicketController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Ticket'),
        actions: [
          SvgPicture.asset('assets/icons/settings.svg'),
          Gap(12),
        ],
      ),
      body: Column(
        children: [
          LabeledTextField(
            label: 'Issue',
            hintText: 'type here',
          ),
          LabeledTextField(label: 'Issue Description', hintText: 'type here'),
          Gap(12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: [
                _buildTitle(title: "License"),
                _buildFilePicker(
                  context: context,
                  filePath: controller.attachmentImagePath,
                  onPick: (imagePath) {
                    controller.attachmentImagePath.value = imagePath;
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildTitle({required String title}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          Text(title),
          const Text(
            "*",
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget _buildFilePicker({
    required BuildContext context,
    required RxString filePath,
    required Function(String) onPick,
  }) {
    return Column(
      children: [
        Row(
          children: [
            InkWell(
              onTap: () => CustomImagePickerForTicket.show(context, onPick, filePath.value),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    topLeft: Radius.circular(12),
                  ),
                ),
                child: const Text("Choose File"),
              ),
            ),
            const SizedBox(width: 12),
            Obx(
              () => Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                ),
                width: MediaQuery.of(context).size.width * .60,
                height: 45,
                child: filePath.value.isEmpty
                    ? const Text('No file selected')
                    : Text(
                        path.basename(filePath.value),
                        overflow: TextOverflow.ellipsis,
                      ),
              ),
            ),
          ],
        ),
        Obx(
          () => filePath.value.isEmpty
              ? const SizedBox.shrink()
              : Container(
                  height: 80,
                  margin: const EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width * .30,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      File(filePath.value),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Get.to(() => CreateTicketScreen());
              },
              child: Text('Create '),
            ),
          ),
        ),
      ],
    );
  }
}
