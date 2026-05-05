import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pathguide_app/core/theme/app_colors.dart';
import 'package:pathguide_app/core/widgets/reusable_widgets.dart';
import 'package:pathguide_app/core/widgets/app_footer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      showLogo: true,
      padding: EdgeInsets.zero,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextButton(
            onPressed: () => context.push('/student-login'),
            child: const Text('Student', style: TextStyle(fontWeight: FontWeight.w600)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextButton(
            onPressed: () => context.push('/recruiter-login'),
            child: const Text('Recruiter', style: TextStyle(fontWeight: FontWeight.w600)),
          ),
        ),
        const SizedBox(width: 8),
      ],
      body: Column(
        children: [
          _buildHeroSection(context),
          _buildFeaturesSection(),
          _buildExploreSection(),
          _buildCTASection(context),
          const AppFooter(),
        ],
      ),
    );
  }



  Widget _buildHeroSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      decoration: const BoxDecoration(
        color: AppColors.lightBlue,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: AppColors.primaryBlue.withValues(alpha: 0.1)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryBlue.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Text(
              '🚀 Transform Your CS Career',
              style: TextStyle(
                color: AppColors.primaryBlue,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(height: 32),
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                height: 1.1,
                color: AppColors.darkNavy,
                fontFamily: 'Poppins',
              ),
              children: [
                TextSpan(text: 'Your Journey from\n'),
                TextSpan(
                  text: 'Student to Pro',
                  style: TextStyle(color: AppColors.primaryBlue),
                ),
                TextSpan(text: '\nStarts Here'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'PathGuide provides personalized learning paths, real-world projects, and direct connections to internships.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.mutedText, fontSize: 16, height: 1.5),
            ),
          ),
          const SizedBox(height: 48),
          GradientButton(
            text: 'Get Started Now',
            width: 260,
            onPressed: () => context.push('/signup'),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _heroBadge(Icons.check_circle, 'No fees'),
              const SizedBox(width: 16),
              _heroBadge(Icons.check_circle, 'Free forever'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _heroBadge(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppColors.teal),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(color: AppColors.mutedText, fontSize: 13, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget _buildFeaturesSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 60),
      child: Column(
        children: [
          SectionHeader(
            title: 'Why Choose PathGuide?',
            subtitle: 'We provide the tools and connections to accelerate your career.',
            centered: true,
          ),
          const SizedBox(height: 48),
          _featureCard(
            Icons.map_outlined, 
            'Personalized Paths',
            'Get customized learning roadmaps based on your interests and career goals.',
          ),
          const SizedBox(height: 20),
          _featureCard(
            Icons.handshake_outlined, 
            'Internship Matching',
            'Find internships that align with your skills and career aspirations.',
          ),
          const SizedBox(height: 20),
          _featureCard(
            Icons.trending_up, 
            'Progress Tracking',
            'Monitor your skill development and see how you compare to requirements.',
          ),
        ],
      ),
    );
  }

  Widget _featureCard(IconData icon, String title, String desc) {
    return AppCard(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.lightBlue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: AppColors.primaryBlue, size: 32),
          ),
          const SizedBox(height: 20),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.darkNavy)),
          const SizedBox(height: 12),
          Text(
            desc, 
            textAlign: TextAlign.center, 
            style: const TextStyle(color: AppColors.mutedText, fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _buildExploreSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      color: Colors.white,
      child: const Column(
        children: [
          SectionHeader(
            title: 'Career Paths',
            subtitle: 'Discover the perfect tech career path and get started.',
            centered: true,
          ),
          SizedBox(height: 40),
          AppCard(
            padding: EdgeInsets.all(32),
            child: Center(
              child: Text(
                'Personalized recommendations coming soon...', 
                style: TextStyle(fontStyle: FontStyle.italic, color: AppColors.mutedText),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCTASection(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(24),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      decoration: BoxDecoration(
        gradient: AppColors.mainGradient,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withValues(alpha: 0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Ready to Start?',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          const Text(
            'Start building the skills and connections you need to land your dream tech job today.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16, height: 1.5),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => context.push('/signup'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primaryBlue,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),
            child: const Text('Start Your Career', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }


}


