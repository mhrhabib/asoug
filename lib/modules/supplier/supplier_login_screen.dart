import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SupplierLoginScreen extends StatelessWidget {
  const SupplierLoginScreen({super.key});

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            Container(
              width: double.infinity,
              height: isSmallScreen ? 250 : 350,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1556740738-b6a63e27c4df?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                color: Colors.black.withValues(alpha: 0.5),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Syaanah it\'s arabian marketplace',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isSmallScreen ? 22 : 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(16),
                    Text(
                      'Create a Asougexpress seller account within just 5 minutes and reach millions of customers today!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isSmallScreen ? 14 : 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Login Card
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
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
            ),

            // Why AsougExpress Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Why AsougExpress?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(8),
                  const Text(
                    'AsougExpress is the best place for selling your product with less selling commission and fastest payout',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  const Gap(20),
                  const Text(
                    'Largest Market in Saudi',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(30),
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      _buildBenefitCard(
                        context: context,
                        icon: Icons.app_registration,
                        title: 'Free Registration',
                        description: 'Lorem ipsum dolor sit amet consectetur. Nisl vitae cras metus platea maecenas.',
                      ),
                      _buildBenefitCard(
                        context: context,
                        icon: Icons.shopping_cart,
                        title: 'Easy Product selling',
                        description: 'Lorem ipsum dolor sit amet consectetur. Nisl vitae cras metus platea maecenas.',
                      ),
                      _buildBenefitCard(
                        context: context,
                        icon: Icons.local_shipping,
                        title: 'Fastest Delivery',
                        description: 'Lorem ipsum dolor sit amet consectetur. Nisl vitae cras metus platea maecenas.',
                      ),
                      _buildBenefitCard(
                        context: context,
                        icon: Icons.ads_click,
                        title: 'Free Marketing',
                        description: 'Lorem ipsum dolor sit amet consectetur. Nisl vitae cras metus platea maecenas.',
                      ),
                      _buildBenefitCard(
                        context: context,
                        icon: Icons.support_agent,
                        title: '24/7 Support & Training',
                        description: 'Lorem ipsum dolor sit amet consectetur. Nisl vitae cras metus platea maecenas.',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Sell Your Product Video Section
            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 40),
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              decoration: const BoxDecoration(
                color: Color(0xFFF5F5F5),
              ),
              child: Column(
                children: [
                  const Text(
                    'Sell Your Product',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(10),
                  const Text(
                    'Lorem ipsum dolor sit amet consectetur. Feugiat proin facilisis fermentum faucibus mattis sed morbi.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
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
                    child: const Center(
                      child: Icon(
                        Icons.play_circle_fill,
                        size: 60,
                        color: Color(0xFFFF6606),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // How to Start Selling Section
            Padding(
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
                    description: 'Lorem ipsum dolor sit amet consectetur. Quis malesuada interdum amet a enim.',
                  ),
                  _buildStepCard(
                    number: '2',
                    title: 'Complete Your Profile',
                    description: 'Lorem ipsum dolor sit amet consectetur. Quis malesuada interdum amet a enim.',
                  ),
                  _buildStepCard(
                    number: '3',
                    title: 'Add Bank Information',
                    description: 'Lorem ipsum dolor sit amet consectetur. Quis malesuada interdum amet a enim.',
                  ),
                  _buildStepCard(
                    number: '4',
                    title: 'List your Product',
                    description: 'Lorem ipsum dolor sit amet consectetur. Quis malesuada interdum amet a enim.',
                  ),
                ],
              ),
            ),

            // FAQ Section
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 40),
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              decoration: const BoxDecoration(
                color: Color(0xFFF5F5F5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'FAQ\'s',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(30),
                  _buildFaqItem(
                    number: '01',
                    question: 'How Asoug Commission?',
                    answer: 'Lorem ipsum dolor sit amet consectetur. Aliquam erat nec sed fringilla ultrices interdum. Eget ac faucibus orci sed odio in bibendum. Est nisl nunc nisi urna tellus tortor.',
                  ),
                  _buildFaqItem(
                    number: '02',
                    question: 'What documents are need to create seller account?',
                    answer: 'Lorem ipsum dolor sit amet consectetur. Aliquam erat nec sed fringilla ultrices interdum. Eget ac faucibus orci sed odio in bibendum. Est nisl nunc nisi urna tellus tortor.',
                  ),
                  _buildFaqItem(
                    number: '03',
                    question: 'How many days need to payment?',
                    answer: 'Lorem ipsum dolor sit amet consectetur. Aliquam erat nec sed fringilla ultrices interdum. Eget ac faucibus orci sed odio in bibendum. Est nisl nunc nisi urna tellus tortor.',
                  ),
                  _buildFaqItem(
                    number: '04',
                    question: 'What categories can i sell my product?',
                    answer: 'Lorem ipsum dolor sit amet consectetur. Aliquam erat nec sed fringilla ultrices interdum. Eget ac faucibus orci sed odio in bibendum. Est nisl nunc nisi urna tellus tortor.',
                  ),
                  _buildFaqItem(
                    number: '05',
                    question: 'How Approval time?',
                    answer: 'Lorem ipsum dolor sit amet consectetur. Aliquam erat nec sed fringilla ultrices interdum. Eget ac faucibus orci sed odio in bibendum. Est nisl nunc nisi urna tellus tortor.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
            color: Colors.black.withValues(alpha: .1),
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
                  description,
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
            color: Colors.black.withValues(alpha: .1),
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
                      answer,
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
