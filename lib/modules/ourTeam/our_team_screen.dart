import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OurTeamScreen extends StatelessWidget {
  const OurTeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Team'),
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
              'https://picsum.photos/404',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Join ASOUG Team section
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Join ASOUG Team',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'We Are Looking For Outstanding Talent To Join Us And Help Us Build The Future Of The Leading Company In A Growing And Exciting Industry.',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.purple, Colors.blue], // Purple to Blue gradient
                        begin: Alignment.centerLeft, // Gradient starts from left
                        end: Alignment.centerRight, // and ends at right
                      ),
                      borderRadius: BorderRadius.circular(30), // Same borderRadius as the button
                    ),
                    child: MaterialButton(
                      height: 55,
                      minWidth: 160,
                      color: Colors.transparent, // Important: Set color to transparent
                      elevation: 0, // Remove default shadow if needed
                      textTheme: ButtonTextTheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      onPressed: () {
                        // Handle apply now
                      },
                      child: const Text(
                        'Apply Now',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white, // Ensure text is visible on gradient
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          // About Us section with gradient background
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.green],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About Us',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Gap(12),
                  const Text(
                    'Asoug Academy Seeks To Prepare And Qualify Members Of Society In Various Fields That Are In Line With The Needs Of The Labor Market In The Field Of Wholesale Trade And Exports, Open A Job Opportunity And Improve The Quality And Efficiency Of The Labor Market Through Training And Qualification And Changing Marketing Concepts For Factories, Wholesalers And Exporters',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Our Mission section
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Our Mission',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'Enabling And Spreading The Culture Of E-marketing And Related Activities Through Training And Qualification',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Image.network(
                    'https://picsum.photos/405',
                    width: double.infinity,
                  ),
                  const SizedBox(height: 8),
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

          // Courses and Programs section
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverToBoxAdapter(
              child: const Text(
                'Courses And Programs',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Courses grid view
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.8,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final courses = [
                    'A Training Course For Production Managers In Industrial Establishments',
                    'VAT Law Applications',
                    'Training Course To Prepare A Professional Export Specialist',
                    'A Course In International Trade Contracts And Import And Export Regulations',
                    'Basic Skills Course For Customer Service',
                    'Google AdWords Course',
                    'A Course In Social Media Management',
                    'E-Marketing Plans And Strategies Program',
                    'A Course In Communication Skills In Remote Work',
                    'Telemarketing Course',
                    'Internet Import And Export Course',
                  ];

                  return Card(
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.network(
                            'https://picsum.photos/40${index + 1}',
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            courses[index],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                childCount: 11,
              ),
            ),
          ),

          // Our Goals section
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Our Goals',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildGoalItem('01', 'To Cover The Needs Of Human Cadres For The Trade, Import And Export Sectors'),
                  _buildGoalItem('02', 'Providing The Appropriate Environment And Transforming Society From Pastoral To Development By Mastering Vocational Training'),
                  _buildGoalItem('03', 'Increasing Qualifications, Access To Jobs In The Shortest Way, Achieving Quality And Enhancing Competition'),
                  _buildGoalItem('04', 'Refine E-marketing Skills And Keep Pace With The Sharing Economy'),
                  _buildGoalItem('05', 'Creating An Attractive And Fertile Environment For The Exchange Of Knowledge, Which Will Positively Affect The Members Of The Platform'),
                ],
              ),
            ),
          ),

          // Media Center section
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

          // Media Center items
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
                            Gap(12),
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
                                      ),
                                    ),
                                    Gap(12),
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

  Widget _buildGoalItem(String number, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
