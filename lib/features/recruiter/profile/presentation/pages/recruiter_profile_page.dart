import 'package:flutter/material.dart';
import 'package:pathguide_app/core/theme/app_colors.dart';
import 'package:pathguide_app/core/widgets/reusable_widgets.dart';
import 'package:pathguide_app/features/recruiter/dashboard/presentation/widgets/recruiter_dashboard_scaffold.dart';

class RecruiterProfilePage extends StatelessWidget {
  const RecruiterProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return RecruiterDashboardScaffold(
      title: 'Company Profile',
      body: SingleChildScrollView(
        child: Column(
          children: [
            AppCard(
              child: Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: AppColors.mainGradient,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(Icons.business_rounded, color: Colors.white, size: 40),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Vodafone Intelligent Solutions',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.darkNavy),
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    'vois.recruitment@vodafone.com',
                    style: TextStyle(color: AppColors.mutedText, fontSize: 14),
                  ),
                  const SizedBox(height: 12),
                  const StatusBadge(label: 'Verified Company', color: AppColors.successGreen),
                ],
              ),
            ),
            const SizedBox(height: 24),
            AppCard(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(title: 'Company Details'),
                  const SizedBox(height: 24),
                  _buildProfileItem(Icons.location_on_rounded, 'Headquarters', 'Smart Village, Giza'),
                  const SizedBox(height: 20),
                  _buildProfileItem(Icons.language_rounded, 'Website', 'www.vodafone.com.eg'),
                  const SizedBox(height: 20),
                  _buildProfileItem(Icons.info_outline, 'Industry', 'Telecommunications & IT'),
                  const SizedBox(height: 20),
                  _buildProfileItem(Icons.people_alt_rounded, 'Company Size', '10,000+ Employees'),
                ],
              ),
            ),
            const SizedBox(height: 32),
            GradientButton(
              text: 'Edit Company Profile',
              onPressed: () {},
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileItem(IconData icon, String label, String value) {
    return Row(
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(color: AppColors.mutedText, fontSize: 12)),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.darkNavy)),
          ],
        ),
      ],
    );
  }
}
