import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pathguide_app/core/theme/app_colors.dart';
import 'package:pathguide_app/core/widgets/reusable_widgets.dart';
import 'package:pathguide_app/core/widgets/app_footer.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: 'About Us',
      padding: EdgeInsets.zero,
      body: Column(
        children: [
          _buildHeader(context),
          _buildMissionSection(),
          _buildHowItWorksSection(),
          _buildCommunitySection(),
          _buildCTASection(context),
          const AppFooter(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      color: AppColors.lightBlue.withValues(alpha: 0.3),
      child: const Column(
        children: [
          Text(
            'Helping Students Discover Their\nIdeal Career Path',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.darkNavy,
              height: 1.3,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Through personalized guidance and real-world connections, we bridge the gap between academia and industry.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.mutedText, fontSize: 15),
          ),
        ],
      ),
    );
  }

  Widget _buildMissionSection() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.rocket_launch, color: AppColors.primaryBlue),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Our Mission',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'PathGuide was created to bridge the gap between university students and their career aspirations. We believe that every student deserves personalized guidance to discover their strengths and find opportunities that align with their unique personality and goals.',
              style: TextStyle(color: AppColors.mutedText, height: 1.6),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHowItWorksSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.teal.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.settings, color: AppColors.teal),
                ),
                const SizedBox(width: 12),
                const Text(
                  'How It Works',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Our platform uses your professional profile, skills, and career aspirations to provide personalized recommendations. Whether you have a clear path in mind or need guidance, we match you with courses and internships that align with your goals.',
              style: TextStyle(color: AppColors.mutedText, height: 1.6),
            ),
            const SizedBox(height: 20),
            _buildBullet('Personalized career path recommendations'),
            _buildBullet('Curated course suggestions to build relevant skills'),
            _buildBullet('Internship opportunities matched to your profile'),
            _buildBullet('Direct connections with course providers and recruiters'),
          ],
        ),
      ),
    );
  }

  Widget _buildBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: AppColors.successGreen, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: AppColors.mutedText, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommunitySection() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.warningYellow.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.groups, color: AppColors.warningYellow),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Our Community',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'PathGuide brings together students, course providers, and recruiters in one platform. We create meaningful connections that help students grow, educators reach motivated learners, and companies find talented candidates who are the right fit for their opportunities.',
              style: TextStyle(color: AppColors.mutedText, height: 1.6),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCTASection(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: AppColors.darkNavy,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Text(
            'Ready to Find Your Path?',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Join PathGuide today and take the first step toward your ideal career.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => context.push('/signup'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.darkNavy,
            ),
            child: const Text('Get Started Free'),
          ),
        ],
      ),
    );
  }
}

