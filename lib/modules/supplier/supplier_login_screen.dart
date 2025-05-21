import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'controllers/supplier_login_controller.dart';

class SupplierLoginScreen extends StatelessWidget {
  final SupplierLoginController controller = Get.put(SupplierLoginController());

  SupplierLoginScreen({super.key});

  String _stripHtml(String htmlString) {
    final document = parse(htmlString);
    return document.body?.text ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Supplier Login'),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),
      body: Obx(() {
        final isLoading = controller.isLoadingBanner.value || controller.isLoadingWhyUs.value || controller.isLoadingProductVideo.value || controller.isLoadingFaqs.value;

        if (isLoading && controller.bannerData.value == null && controller.whyUsData.value == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              // Hero Section
              _buildHeroSection(isSmallScreen),

              // Login Card
              _buildLoginCard(),

              // Why AsougExpress Section
              _buildWhyUsSection(),

              // Sell Your Product Video Section
              _buildProductVideoSection(context),

              // How to Start Selling Section
              _buildHowToSellSection(),

              // FAQ Section
              _buildFaqSection(),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildHeroSection(bool isSmallScreen) {
    return Obx(() {
      final banner = controller.bannerData.value?.data;

      return Container(
        width: double.infinity,
        height: isSmallScreen ? 250 : 350,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              banner?.imageUrl ?? 'https://images.unsplash.com/photo-1556740738-b6a63e27c4df',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          color: Colors.black.withOpacity(0.5),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                banner?.title ?? 'Syaanah it\'s arabian marketplace',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isSmallScreen ? 22 : 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(16),
              Text(
                banner?.description ?? 'Create a Asougexpress seller account within just 5 minutes',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: isSmallScreen ? 14 : 16,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildLoginCard() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Create your Account',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(10),
          const Text(
            'Welcome! Millions of Asouge users are waiting to buy your product.',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
          const Gap(20),
          const Text(
            'Phone',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(8),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: '+966 0121 102 00 00',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const Gap(12),
              SizedBox(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF6606),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {},
                  child: const Text('Send'),
                ),
              ),
            ],
          ),
          const Gap(20),
          const Text(
            'Verification',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(8),
          TextFormField(
            decoration: InputDecoration(
              hintText: '459875468',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const Gap(16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF340F6A),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () {},
              child: const Text('Login'),
            ),
          ),
          const Gap(20),
          Center(
            child: TextButton(
              onPressed: () {},
              child: const Text(
                'Create global Seller account',
                style: TextStyle(
                  color: Color(0xFFFF6606),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhyUsSection() {
    return Obx(() {
      final whyUs = controller.whyUsData.value?.data;

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              whyUs?.heading?.title ?? 'Why AsougExpress?',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(8),
            Text(
              whyUs?.heading?.description ?? 'AsougExpress is the best place for selling your product',
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
            const Gap(20),
            if (whyUs?.elements != null) ...[
              Wrap(
                spacing: 20,
                runSpacing: 20,
                children: whyUs!.elements!
                    .map((element) => _buildBenefitCard(
                          context: Get.context!,
                          icon: _getIconForTitle(element.title ?? ''),
                          title: element.title ?? '',
                          description: element.description ?? '',
                        ))
                    .toList(),
              ),
            ] else ...[
              const Text('No benefits information available'),
            ],
          ],
        ),
      );
    });
  }

  IconData _getIconForTitle(String title) {
    if (title.toLowerCase().contains('registration')) return Icons.app_registration;
    if (title.toLowerCase().contains('selling')) return Icons.shopping_cart;
    if (title.toLowerCase().contains('delivery')) return Icons.local_shipping;
    if (title.toLowerCase().contains('marketing')) return Icons.ads_click;
    if (title.toLowerCase().contains('support')) return Icons.support_agent;
    return Icons.business;
  }

  Widget _buildProductVideoSection(BuildContext context) {
    return Obx(() {
      final videoData = controller.productVideoData.value?.data;

      return Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 40),
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        decoration: const BoxDecoration(
          color: Color(0xFFF5F5F5),
        ),
        child: Column(
          children: [
            Text(
              videoData?.title ?? 'Sell Your Product',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(10),
            Text(
              videoData?.description ?? 'Learn how to sell your products on our platform',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
            const Gap(30),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Icon(
                  Icons.play_circle_fill,
                  size: 60,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildHowToSellSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'How to start selling your product?',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(30),
          _buildStepCard(
            number: '1',
            title: 'Sign up',
            description: 'Create your seller account in just a few minutes',
          ),
          _buildStepCard(
            number: '2',
            title: 'Complete Your Profile',
            description: 'Add your business information and verification documents',
          ),
          _buildStepCard(
            number: '3',
            title: 'Add Bank Information',
            description: 'Set up your payment details for receiving funds',
          ),
          _buildStepCard(
            number: '4',
            title: 'List your Product',
            description: 'Add your products with details and pricing',
          ),
        ],
      ),
    );
  }

  Widget _buildFaqSection() {
    return Obx(() {
      final faqs = controller.faqsData.value?.data;

      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 40),
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        decoration: const BoxDecoration(
          color: Color(0xFFF5F5F5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              faqs?.heading?.title ?? 'FAQ\'s',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Gap(30),
            if (faqs?.elements != null) ...[
              ...faqs!.elements!
                  .asMap()
                  .entries
                  .map((entry) => _buildFaqItem(
                        number: '${entry.key + 1}'.padLeft(2, '0'),
                        question: entry.value.question ?? '',
                        answer: entry.value.answer ?? '',
                      ))
                  .toList(),
            ] else ...[
              const Text('No FAQs available'),
            ],
          ],
        ),
      );
    });
  }

  Widget _buildBenefitCard({
    required IconData icon,
    required String title,
    required String description,
    required BuildContext context,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, size: 40, color: const Color(0xFF340F6A)),
          const Gap(16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(8),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text(
                  _stripHtml(description),
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildStepCard({
    required String number,
    required String title,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFFF6606),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(8),
                Text(
                  description,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFaqItem({
    required String number,
    required String question,
    required String answer,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                number,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF6606),
                ),
              ),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      question,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(8),
                    Text(
                      _stripHtml(answer),
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(16),
          const Divider(height: 1, color: Colors.grey),
        ],
      ),
    );
  }
}
