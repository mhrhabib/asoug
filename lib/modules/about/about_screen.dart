import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';
import './controller/about_controller.dart';
import 'package:html/parser.dart' show parse;

class AboutScreen extends StatelessWidget {
  final AboutController _controller = Get.put(AboutController());

  AboutScreen({super.key});

  String _stripHtml(String htmlString) {
    final document = parse(htmlString);
    return document.body?.text ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About Us',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Obx(() {
        if (_controller.isLoading.value && _controller.aboutData.value == null) {
          return const Center(child: CircularProgressIndicator());
        }

        if (_controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(_controller.errorMessage.value),
                const Gap(16),
                ElevatedButton(
                  onPressed: _controller.fetchAboutData,
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final about = _controller.aboutData.value?.data;
        if (about == null) {
          return const Center(child: Text('No about information available'));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (about.image_url != null && about.image_url!.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    about.image_url!,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 200,
                      color: Colors.grey[200],
                      child: const Icon(Icons.broken_image),
                    ),
                  ),
                ),
              const Gap(20),
              Text(
                about.title ?? 'About Us',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Gap(16),
              Text(
                _stripHtml(
                  about.description ?? 'No description available',
                ),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const Gap(30),
              _buildContactInfo(),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildContactInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color.fromARGB(255, 175, 146, 219), Color.fromARGB(255, 222, 161, 123)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Contact Us',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const Gap(12),
          _buildContactItem(Icons.email, 'email@example.com'),
          const Gap(8),
          _buildContactItem(Icons.phone, '+1 (123) 456-7890'),
          const Gap(8),
          _buildContactItem(Icons.location_on, '123 Main St, City, Country'),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        const Gap(8),
        Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
