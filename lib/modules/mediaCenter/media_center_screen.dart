import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MediaCenterScreen extends StatelessWidget {
  const MediaCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Media Center'),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              // Handle menu action
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // Full width image
          SliverToBoxAdapter(
            child: Image.network(
              'https://picsum.photos/701',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Media Center headline and description
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Media Center',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'A link that highlights opportunities and challenges to be a media link between the market and members. Contribute to highlighting the efforts of export-related bodies. Designing and developing identity, trademarks and logos. Digital marketing and social media content management. Audio-visual television and electronic advertising design. Commercial packaging design and packaging of products, services and brands.',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Image.network(
                    'https://picsum.photos/702',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          ),

          // Multi Type Events section
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Multi Type Events',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'We are looking in Asouq to enable members to provide services, events, events, knowledge and forums, as many events provide topics and news about international trade and import and export technologies by a team of specialists and veterans with the ability to communicate and create, and we look forward to becoming one of the largest solutions for service providers to help Governments and businesses unlock an understanding of export markets and investment opportunities no matter where you are. The Anywhere concept is available to consumers across a variety of platforms.',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Number of Batteries: 32 AAA batteries required\n'
                    'Brand: Energizer\n'
                    'Battery Cell Composition: Alkaline\n'
                    'Recommended Uses For Product: TV Remote\n'
                    'Unit Count: 32.0 Count',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ),

          // Media Center advisors section
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverToBoxAdapter(
              child: const Text(
                'Media Center',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Media Center advisors list
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final advisors = [
                  {'image': 'https://picsum.photos/601', 'name': 'Hossain Sadh', 'position': 'Business Advisor'},
                  {'image': 'https://picsum.photos/602', 'name': 'Mohammad Salim', 'position': 'Business Advisor'},
                  {'image': 'https://picsum.photos/603', 'name': 'Mohammad Shayem', 'position': 'Business Advisor'},
                ];

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Card(
                    child: Stack(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              'https://picsum.photos/50${index + 1}',
                              width: double.infinity,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                            const Gap(12),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'To know more about us',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'It is a long established fact that a reader will be distracted. There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable.',
                                    maxLines: 4,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 16),
                                  Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [Colors.purple, Colors.blue], // Purple to Blue gradient
                                            begin: Alignment.centerLeft, // Gradient starts from left
                                            end: Alignment.centerRight, // and ends at right
                                          ),
                                          borderRadius: BorderRadius.circular(10), // Same borderRadius as the button
                                        ),
                                        child: MaterialButton(
                                          height: 55,
                                          minWidth: 160,
                                          color: Colors.transparent, // Important: Set color to transparent
                                          elevation: 0, // Remove default shadow if needed
                                          textTheme: ButtonTextTheme.primary,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          onPressed: () {
                                            // Handle apply now
                                          },
                                          child: const Text(
                                            'Read More',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white, // Ensure text is visible on gradient
                                            ),
                                          ),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          left: MediaQuery.sizeOf(context).width * .20,
                          top: 160,
                          child: Align(
                            alignment: Alignment.center,
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(18),
                                      child: Image.network(
                                        advisors[index]['image']!,
                                        height: 40,
                                        width: 40,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const Gap(12),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          advisors[index]['name']!,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(advisors[index]['position']!),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              childCount: 3,
            ),
          ),
        ],
      ),
    );
  }
}
