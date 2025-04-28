import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CreateTicketScreen extends StatefulWidget {
  const CreateTicketScreen({super.key});

  @override
  State<CreateTicketScreen> createState() => _CreateTicketScreenState();
}

class _CreateTicketScreenState extends State<CreateTicketScreen> {
  final TicketController controller = Get.put(TicketController());
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _issueController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _issueController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;
    final buttonWidth = screenWidth * 0.9;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Ticket',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/settings.svg',
              width: 24,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Issue Field
              _buildLabeledTextField(
                label: 'Issue',
                hintText: 'Type your issue here',
                controller: _issueController,
                validator: (value) => value?.isEmpty ?? true ? 'Please enter the issue' : null,
              ),
              const Gap(16),

              // Description Field
              _buildLabeledTextField(
                label: 'Issue Description',
                hintText: 'Describe your issue in detail',
                controller: _descriptionController,
                validator: (value) => value?.isEmpty ?? true ? 'Please enter description' : null,
                maxLines: 4,
              ),
              const Gap(24),

              // License Attachment Section
              _buildTitle(title: "License"),
              const Gap(8),
              _buildFilePicker(context),
              const Gap(24),

              // Submit Button
              Center(
                child: SizedBox(
                  width: buttonWidth,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    onPressed: _submitTicket,
                    child: Text(
                      'Create Ticket',
                      style: TextStyle(
                        fontSize: isSmallScreen ? 16 : 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const Gap(24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabeledTextField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const Gap(4),
        TextFormField(
          controller: controller,
          validator: validator,
          maxLines: maxLines,
          decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              )),
        ),
      ],
    );
  }

  Widget _buildTitle({required String title}) {
    return RichText(
      text: TextSpan(
        text: title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        children: const [
          TextSpan(
            text: " *",
            style: TextStyle(color: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget _buildFilePicker(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 360;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: InkWell(
                onTap: () => _pickFile(context),
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      bottomLeft: Radius.circular(8),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      "Choose File",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Obx(
                () => Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: controller.attachmentImagePath.value.isEmpty
                      ? Text(
                          'No file selected',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        )
                      : Text(
                          path.basename(controller.attachmentImagePath.value),
                          overflow: TextOverflow.ellipsis,
                        ),
                ),
              ),
            ),
          ],
        ),
        const Gap(8),
        Obx(
          () => controller.attachmentImagePath.value.isEmpty
              ? const SizedBox.shrink()
              : Container(
                  height: isSmallScreen ? 100 : 150,
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      File(controller.attachmentImagePath.value),
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Center(
                        child: Icon(Icons.error, color: Colors.red),
                      ),
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  Future<void> _pickFile(BuildContext context) async {
    // Implement your file picking logic here
    // For example:
    // final result = await FilePicker.platform.pickFiles();
    // if (result != null) {
    //   controller.attachmentImagePath.value = result.files.single.path!;
    // }

    // For now, we'll just simulate picking a file
    await Future.delayed(const Duration(milliseconds: 300));
    controller.attachmentImagePath.value = '/path/to/sample/file.jpg';
  }

  void _submitTicket() {
    if (_formKey.currentState?.validate() ?? false) {
      if (controller.attachmentImagePath.value.isEmpty) {
        Get.snackbar(
          'Required',
          'Please attach a license file',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      // Submit ticket logic
      Get.snackbar(
        'Success',
        'Ticket created successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Clear form
      _issueController.clear();
      _descriptionController.clear();
      controller.attachmentImagePath.value = '';
    }
  }
}

class TicketController extends GetxController {
  RxString attachmentImagePath = ''.obs;
}
