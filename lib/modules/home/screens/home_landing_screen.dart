import 'dart:io';

import 'package:asoug/modules/home/models/media_center_model.dart';
import 'package:asoug/modules/home/widgets/home_screen_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../controllers/service_controller.dart';

class HomeLandingScreen extends StatefulWidget {
  const HomeLandingScreen({super.key});

  @override
  State<HomeLandingScreen> createState() => _HomeLandingScreenState();
}

class _HomeLandingScreenState extends State<HomeLandingScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final ServicesController _controller = Get.put(ServicesController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600;

    return Platform.isAndroid
        ? AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light.copyWith(
              statusBarColor: Colors.purple, // Custom status bar color
              statusBarIconBrightness: Brightness.light, // For Android
              statusBarBrightness: Brightness.dark, // For iOS
            ),
            child: _buildBody(isSmallScreen, screenWidth),
          )
        : _buildBody(isSmallScreen, screenWidth);
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
          if (imageUrl.isNotEmpty)
            Image.network(
              imageUrl,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
            ),
          const Gap(10),
          Text(
            title,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const Gap(5),
          Expanded(
            child: Text(
              paragraph,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildBody(bool isSmallScreen, double screenWidth) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.purple,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.white,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        key: scaffoldKey,
        extendBody: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor.withValues(alpha: 0.9),
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.purple,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 4.0, bottom: 2),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.9),
                    Colors.white.withValues(alpha: 0.8),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          title: const Text(
            'ASOUG',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          actions: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.purple.withValues(alpha: 0.3),
                    Colors.purple.withValues(alpha: 0.6),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.language,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () => _controller.buildDialog(context),
              ),
            ),
            Gap(12),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.purple.withValues(alpha: 0.3),
                    Colors.purple.withValues(alpha: 0.6),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () => scaffoldKey.currentState?.openDrawer(),
              ),
            ),
            const Gap(12),
          ],
        ),
        drawer: HomeScreenWithDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Hero Section
              Obx(
                () => _controller.isLoading.value
                    ? SizedBox(
                        height: 400,
                        width: double.infinity,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.amber,
                          ),
                        ),
                      )
                    : Container(
                        color: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              _controller.bannerData.value?.data!.imageUrl ?? 'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
                              width: screenWidth,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12.0),
                              child: Text(
                                _controller.bannerData.value?.data!.title ?? 'Promotion of exports and the link between factories and wholesalers',
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
                                _controller.bannerData.value?.data!.subTitle ?? 'Welcome to ASOUG To promote and market wholesale products on behalf of others',
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
              ),

              // Services Section
              Obx(() {
                final services = _controller.services.value?.data ?? [];

                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: const LinearGradient(
                      colors: [Color.fromARGB(255, 175, 146, 219), Color.fromARGB(255, 222, 161, 123)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 0.65,
                    ),
                    itemCount: services.length + (_controller.isLoadingMore.value ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index >= services.length) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final service = services[index];
                      return _buildServiceItem(
                        imageUrl: service.image ?? '',
                        title: service.title ?? 'No title',
                        paragraph: service.description ?? 'No description',
                      );
                    },
                  ),
                );
              }),

              // About Section
              // Join Team Section
              Obx(() {
                final data = _controller.joinOurTeamData.value?.data;

                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 40),
                  padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(data?.imageUrl ?? 'https://images.unsplash.com/photo-1522071820081-009f0129c71c?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.black.withValues(alpha: 0.7),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          data?.title ?? 'Join ASOUG Team',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Gap(20),
                        Text(
                          data?.description ?? 'We Are Looking For Outstanding Talent To Join Us And Help Us Build The Future Of The Leading Company In A Growing And Exciting Industry.',
                          style: const TextStyle(
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
                          onPressed: () {
                            // Handle apply now action
                          },
                          child: const Text(
                            'Apply Now',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              // Testimonials Section
              Obx(() {
                if (_controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (_controller.errorMessage.isNotEmpty) {
                  return Center(child: Text(_controller.errorMessage.value));
                }

                final mediaItems = _controller.allMedia.take(3).toList(); // Get first 3 items for display

                return Padding(
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
                                for (var item in mediaItems) _buildMediaCard(item: item),
                                const Gap(20),
                              ],
                            )
                          : Row(
                              children: [
                                for (var item in mediaItems)
                                  Expanded(
                                    child: _buildMediaCard(item: item),
                                  ),
                                const Gap(20),
                              ],
                            ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget _buildFeatureCard({required String title, required String description}) {
Widget _buildMediaCard({required Media item}) {
  return Container(
    padding: const EdgeInsets.all(20),
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
        if (item.imageUrl != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              item.imageUrl!,
              height: 150,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
        const Gap(16),
        if (item.user?.name != null)
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: item.user?.avatarUrl != null ? NetworkImage(item.user!.avatarUrl!) : const NetworkImage('https://picsum.photos/404'),
              ),
              const Gap(16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.user!.name!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  if (item.user?.email != null)
                    Text(
                      item.user!.email!,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            ],
          ),
        const Gap(16),
        if (item.title != null)
          Text(
            item.title!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        const Gap(8),
        if (item.shortDescription != null)
          Text(
            item.shortDescription!,
            style: const TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 14,
            ),
          ),
        const Gap(8),
        if (item.content != null)
          Text(
            item.content!.length > 100 ? '${item.content!.substring(0, 100)}...' : item.content!,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        const Gap(16),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              // Navigate to media detail page
              Get.toNamed('/media-detail', arguments: item.id);
            },
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
