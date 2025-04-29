import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class HomeLandingScreen extends StatelessWidget {
  const HomeLandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ASOUG'),
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
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
                    width: screenWidth,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      'Promotion of exports and the link between factories and wholesalers',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: isSmallScreen ? 20 : 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      'Welcome to ASOUG To promote and market wholesale products on behalf of others',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: isSmallScreen ? 14 : 18,
                      ),
                    ),
                  ),
                  const Gap(30),
                  Row(
                    children: [
                      Gap(12),
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF6606),
                            foregroundColor: Colors.white,
                            shape: StadiumBorder(
                              side: const BorderSide(color: Color(0xFFFF6606)),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                          onPressed: () {},
                          child: const Text('Shop Now'),
                        ),
                      ),
                      const Gap(16),
                      Expanded(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.black),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          ),
                          onPressed: () {},
                          child: const Text(
                            'Start Selling',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      Gap(12),
                    ],
                  ),
                ],
              ),
            ),

            // Services Section
            Container(
              //margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 2),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  colors: [Color.fromARGB(255, 175, 146, 219), Color.fromARGB(255, 222, 161, 123)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                children: [
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    alignment: WrapAlignment.start,
                    children: [
                      _buildServiceItem(
                        imageUrl: 'https://picsum.photos/309',
                        title: 'Our Executive Service',
                        paragraph: 'We Provide A Unique Service To Our Customers By Providing A Dedicated Executive Service To Help You With Your Business Needs.',
                      ),
                      _buildServiceItem(
                        imageUrl: 'https://picsum.photos/308',
                        title: 'Global And Local Trade',
                        paragraph: 'We Provide A Unique Service To Our Customers By Providing A Dedicated Executive Service To Help You With Your Business Needs.',
                      ),
                      _buildServiceItem(
                        imageUrl: 'https://picsum.photos/307',
                        title: 'Export Services',
                        paragraph: 'We Provide A Unique Service To Our Customers By Providing A Dedicated Executive Service To Help You With Your Business Needs.',
                      ),
                      _buildServiceItem(
                        imageUrl: 'https://picsum.photos/306',
                        title: 'Market Platform',
                        paragraph: 'We Provide A Unique Service To Our Customers By Providing A Dedicated Executive Service To Help You With Your Business Needs.',
                      ),
                      _buildServiceItem(
                        imageUrl: 'https://picsum.photos/306',
                        title: 'Events & Meetings',
                        paragraph: 'We Provide A Unique Service To Our Customers By Providing A Dedicated Executive Service To Help You With Your Business Needs.',
                      ),
                      _buildServiceItem(
                        imageUrl: 'https://picsum.photos/305',
                        title: 'Storage Solutions',
                        paragraph: 'We Provide A Unique Service To Our Customers By Providing A Dedicated Executive Service To Help You With Your Business Needs.',
                      ),
                      _buildServiceItem(
                        imageUrl: 'https://picsum.photos/304',
                        title: 'Logistics Options',
                        paragraph: 'We Provide A Unique Service To Our Customers By Providing A Dedicated Executive Service To Help You With Your Business Needs.',
                      ),
                      _buildServiceItem(
                        imageUrl: 'https://picsum.photos/303',
                        title: 'Payment Solutions',
                        paragraph: 'We Provide A Unique Service To Our Customers By Providing A Dedicated Executive Service To Help You With Your Business Needs.',
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // About Section
            // Join Team Section
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 40),
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://images.unsplash.com/photo-1522071820081-009f0129c71c?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                color: Colors.black.withValues(alpha: 0.7),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      'Join ASOUG Team',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Gap(20),
                    const Text(
                      'We Are Looking For Outstanding Talent To Join Us And Help Us Build The Future Of The Leading Company In A Growing And Exciting Industry.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Gap(30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: const Color(0xFFFF6606),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {},
                      child: const Text(
                        'Apply Now',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Testimonials Section
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Column(
                children: [
                  const Text(
                    'Media Center',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Gap(10),
                  const Text(
                    'To know more about us',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const Gap(30),
                  isSmallScreen
                      ? Column(
                          children: [
                            _buildTestimonialCard(
                              name: 'Hossain Sadh',
                              role: 'Business Advisor',
                              quote: 'It is a long established fact that a reader will be distracted',
                              description: 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable.',
                            ),
                            const Gap(20),
                            _buildTestimonialCard(
                              name: 'Mohammad Salim',
                              role: 'Business Advisor',
                              quote: 'It is a long established fact that a reader will be distracted',
                              description: 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable.',
                            ),
                            const Gap(20),
                            _buildTestimonialCard(
                              name: 'Mohammad Shayem',
                              role: 'Business Advisor',
                              quote: 'It is a long established fact that a reader will be distracted',
                              description: 'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable.',
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Expanded(
                              child: _buildTestimonialCard(
                                name: 'Hossain Sadh',
                                role: 'Business Advisor',
                                quote: 'It is a long established fact that a reader will be distracted',
                                description:
                                    'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable.',
                              ),
                            ),
                            const Gap(20),
                            Expanded(
                              child: _buildTestimonialCard(
                                name: 'Mohammad Salim',
                                role: 'Business Advisor',
                                quote: 'It is a long established fact that a reader will be distracted',
                                description:
                                    'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable.',
                              ),
                            ),
                            const Gap(20),
                            Expanded(
                              child: _buildTestimonialCard(
                                name: 'Mohammad Shayem',
                                role: 'Business Advisor',
                                quote: 'It is a long established fact that a reader will be distracted',
                                description:
                                    'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable.',
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceItem({required String title, required String imageUrl, required String paragraph}) {
    return Container(
      width: 180,
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
      child: Column(
        children: [
          Image.network(
            imageUrl,
          ),
          const Gap(10),
          Text(
            title,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            paragraph,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({required String title, required String description}) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF340F6A),
            ),
          ),
          const Gap(10),
          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTestimonialCard({
    required String name,
    required String role,
    required String quote,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage('https://randomuser.me/api/portraits/men/1.jpg'),
              ),
              const Gap(16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    role,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Gap(20),
          Text(
            quote,
            style: const TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 16,
            ),
          ),
          const Gap(10),
          Text(
            description,
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          const Gap(20),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {},
              child: const Text(
                'Read More',
                style: TextStyle(color: Color(0xFFFF6606)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
