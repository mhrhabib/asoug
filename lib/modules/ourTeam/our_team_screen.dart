import 'package:asoug/modules/mediaCenter/models/course_program_model.dart';
import 'package:asoug/modules/ourTeam/model/our_team_model.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';

import '../home/controllers/service_controller.dart';
import '../home/models/media_center_model.dart';
import '../mediaCenter/controllers/media_center_controller.dart';
import 'controller/our_team_controller.dart';

class OurTeamScreen extends StatelessWidget {
  final OurTeamController teamController = Get.put(OurTeamController());
  final MediaCenterController mediaController = Get.put(MediaCenterController());
  final ServicesController servicesController = Get.put(ServicesController());

  OurTeamScreen({super.key});

  String _stripHtml(String htmlString) {
    final document = parse(htmlString);
    return document.body?.text ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Our Team'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshData,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: Obx(() {
          if (_isLoading()) return _buildLoadingState();
          if (_hasError()) return _buildErrorState();
          return _buildContent();
        }),
      ),
    );
  }

  Future<void> _refreshData() async {
    await Future.wait([
      teamController.fetchOurTeam(),
      mediaController.fetchOurMission(),
      mediaController.fetchCoursePrograms(),
      mediaController.fetchOurGoals(),
      servicesController.fetchJoinOurTeamData(),
    ]);
  }

  bool _isLoading() {
    return teamController.isLoading.value || mediaController.isLoading.value || servicesController.isLoading.value;
  }

  bool _hasError() {
    return teamController.errorMessage.value.isNotEmpty || mediaController.errorMessage.value.isNotEmpty || servicesController.errorMessage.value.isNotEmpty;
  }

  Widget _buildLoadingState() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildErrorState() {
    final error = teamController.errorMessage.value.isNotEmpty
        ? teamController.errorMessage.value
        : mediaController.errorMessage.value.isNotEmpty
            ? mediaController.errorMessage.value
            : servicesController.errorMessage.value;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              error,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.red),
            ),
            const Gap(20),
            ElevatedButton(
              onPressed: _refreshData,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        children: [
          // Team Header Section
          _buildTeamHeader(),

          // Join Our Team Section
          _buildJoinTeamSection(),

          // About Us Section
          _buildAboutUsSection(),

          // Our Mission Section
          _buildMissionSection(),

          // Team Members Grid
          if (teamController.featuredMembers.isNotEmpty) ...[
            const SectionTitle(title: 'Our Team Members'),
            _buildTeamMembersGrid(),
          ],

          // Courses Section
          if (mediaController.courseProgramData.value?.data?.elements?.isNotEmpty ?? false) ...[
            const SectionTitle(title: 'Courses & Programs'),
            _buildCoursesGrid(),
          ],

          // Our Goals Section
          if (mediaController.ourGoalData.value?.data?.elements!.isNotEmpty ?? false) ...[
            const SectionTitle(title: 'Our Goals'),
            _buildGoalsList(),
          ],

          // Media Center Section
          if (servicesController.allMedia.isNotEmpty) ...[
            const SectionTitle(title: 'Media Center'),
            _buildMediaItems(),
          ],
        ],
      ),
    );
  }

  // Section Builders
  Widget _buildTeamHeader() {
    return Container(
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          image: NetworkImage(
            servicesController.joinOurTeamData.value?.data?.imageUrl ?? 'https://via.placeholder.com/1200x400',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildJoinTeamSection() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Join Our Team',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(12),
          Text(
            servicesController.joinOurTeamData.value?.data?.description ?? 'We are looking for talented individuals to join our growing team.',
            style: const TextStyle(fontSize: 16),
          ),
          const Gap(20),
          Center(
            child: GradientButton(
              text: 'Apply Now',
              onPressed: () => _handleApplyNow(),
              width: 200,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutUsSection() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.blue, Colors.green],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About Us',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const Gap(12),
          Text(
            _stripHtml(mediaController.ourMissionData.value?.data?.description ?? 'Our organization is dedicated to excellence and innovation in our field.'),
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMissionSection() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Our Mission',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Gap(12),
          Text(
            mediaController.ourMissionData.value?.data?.title ?? 'To empower and educate through innovative solutions',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          const Gap(20),
          if (mediaController.ourMissionData.value?.data?.imageUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                mediaController.ourMissionData.value!.data!.imageUrl!,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTeamMembersGrid() {
    return GridView.builder(
      padding: const EdgeInsets.only(top: 20),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.8,
      ),
      itemCount: teamController.featuredMembers.length,
      itemBuilder: (context, index) {
        final member = teamController.featuredMembers[index];
        return TeamMemberCard(member: member);
      },
    );
  }

  Widget _buildCoursesGrid() {
    return GridView.builder(
      padding: const EdgeInsets.only(top: 20),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.9,
      ),
      itemCount: mediaController.courseProgramData.value!.data!.elements!.length,
      itemBuilder: (context, index) {
        final course = mediaController.courseProgramData.value!.data!.elements![index];
        return CourseCard(course: course);
      },
    );
  }

  Widget _buildGoalsList() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          for (var i = 0; i < mediaController.ourGoalData.value!.data!.elements!.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${i + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Gap(12),
                  Expanded(
                    child: Text(
                      mediaController.ourGoalData.value!.data!.elements![i].title ?? '',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMediaItems() {
    return Column(
      children: [
        for (var media in servicesController.allMedia) MediaItemCard(mediaItem: media),
      ],
    );
  }

  void _handleApplyNow() {
    // Handle apply now action
    Get.snackbar('Application', 'Apply now functionality would go here');
  }
}

// Reusable Widgets
class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class TeamMemberCard extends StatelessWidget {
  final Team member;

  const TeamMemberCard({required this.member, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: member.imageUrl != null
                  ? Image.network(
                      member.imageUrl!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    )
                  : Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.person, size: 50),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member.user?.name ?? member.userName ?? 'Team Member',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (member.title != null) ...[
                  const Gap(4),
                  Text(
                    member.title!,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
                if (member.shortDescription != null) ...[
                  const Gap(8),
                  Text(
                    member.shortDescription!,
                    style: const TextStyle(fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CourseCard extends StatelessWidget {
  final Elements course;

  const CourseCard({required this.course, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: course.imageUrl != null
                  ? Image.network(
                      course.imageUrl!,
                      fit: BoxFit.contain,
                      width: double.infinity,
                    )
                  : Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.school, size: 50),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              course.title ?? 'Course Title',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class MediaItemCard extends StatelessWidget {
  final Media mediaItem;

  const MediaItemCard({required this.mediaItem, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (mediaItem.imageUrl != null)
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                mediaItem.imageUrl!,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (mediaItem.title != null)
                  Text(
                    mediaItem.title!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                if (mediaItem.shortDescription != null) ...[
                  const Gap(8),
                  Text(
                    mediaItem.shortDescription!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                ],
                const Gap(16),
                Align(
                  alignment: Alignment.centerRight,
                  child: GradientButton(
                    text: 'Read More',
                    onPressed: () => _handleReadMore(mediaItem),
                    width: 150,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleReadMore(Media mediaItem) {
    // Handle read more action
    Get.toNamed('/media-detail', arguments: mediaItem.id);
  }
}

class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;

  const GradientButton({
    required this.text,
    required this.onPressed,
    this.width,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.blue, Colors.green],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: MaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        height: 50,
        color: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
