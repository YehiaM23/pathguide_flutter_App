import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pathguide_app/core/theme/app_colors.dart';
import 'package:pathguide_app/core/widgets/reusable_widgets.dart';
import 'package:pathguide_app/core/widgets/app_footer.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: 'Contact Us',
      padding: EdgeInsets.zero,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(
                  title: 'Get in Touch',
                  subtitle: "Have questions? We'd love to hear from you. Send us a message and we'll respond as soon as possible.",
                ),
                const SizedBox(height: 32),
                
                _buildContactInfoCard(),
                const SizedBox(height: 24),
                _buildFollowUsCard(),
                const SizedBox(height: 40),
                
                const SectionHeader(
                  title: 'Send us a Message',
                  subtitle: 'Fill out the form below and our team will get back to you.',
                ),
                const SizedBox(height: 24),
                const AppCard(
                  child: Column(
                    children: [
                      AppTextField(label: 'Full Name', hint: 'Enter your name'),
                      SizedBox(height: 16),
                      AppTextField(label: 'Email Address', hint: 'Enter your email'),
                      SizedBox(height: 16),
                      AppTextField(label: 'Message', hint: 'How can we help you?', maxLines: 4),
                      SizedBox(height: 24),
                      GradientButton(text: 'Send Message', onPressed: _dummyAction),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
          const AppFooter(),
        ],
      ),
    );
  }

  static void _dummyAction() {}

  Widget _buildContactInfoCard() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Contact Information',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.darkNavy),
          ),
          const SizedBox(height: 4),
          const Text(
            'Reach out to us through any of these channels',
            style: TextStyle(color: AppColors.mutedText, fontSize: 13),
          ),
          const SizedBox(height: 24),
          
          _buildInfoItem(Icons.phone_rounded, 'Phone Support', '+20 123 456 7890'),
          const SizedBox(height: 20),
          _buildInfoItem(Icons.email_rounded, 'Email Address', 'support@pathguide.com'),
          const SizedBox(height: 20),
          _buildInfoItem(Icons.location_on_rounded, 'Main Office', 'Smart Village, Giza, Egypt'),
        ],
      ),
    );
  }

  Widget _buildFollowUsCard() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Connect with Us',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.darkNavy),
          ),
          const SizedBox(height: 20),
          _buildSocialRow(Icons.facebook_rounded, 'Facebook', 'PathGuideOfficial'),
          _buildSocialRow(Icons.camera_alt_rounded, 'Instagram', '@pathguide_app'),
          _buildSocialRow(Icons.business_rounded, 'LinkedIn', 'PathGuide Platform'),
        ],
      ),
    );
  }

  Widget _buildSocialRow(IconData icon, String platform, String handle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: AppColors.primaryBlue, size: 20),
          ),
          const SizedBox(width: 16),
          Text(platform, style: const TextStyle(fontWeight: FontWeight.w600, color: AppColors.darkNavy)),
          const Spacer(),
          Text(handle, style: const TextStyle(color: AppColors.mutedText, fontSize: 13)),
        ],
      ),
    );
  }

 
  Widget _buildInfoItem(IconData icon, String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.lightBlue,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.primaryBlue, size: 20),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(color: AppColors.mutedText, fontSize: 14)),
          ],
        ),
      ],
    );
  }
}

