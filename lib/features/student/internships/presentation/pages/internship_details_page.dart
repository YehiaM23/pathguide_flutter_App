import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pathguide_app/core/theme/app_colors.dart';
import 'package:pathguide_app/core/widgets/reusable_widgets.dart';
import 'package:pathguide_app/core/data/models.dart';

class InternshipDetailsPage extends StatelessWidget {
  const InternshipDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final internship = GoRouterState.of(context).extra as InternshipModel;

    return PageScaffold(
      title: 'Internship Details',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(internship),
          const SizedBox(height: 32),
          
          const SectionHeader(title: 'Overview'),
          const SizedBox(height: 16),
          _buildOverviewGrid(internship),
          const SizedBox(height: 32),
          
          const SectionHeader(title: 'Description'),
          const SizedBox(height: 12),
          AppCard(
            child: Text(
              internship.description,
              style: const TextStyle(color: AppColors.mutedText, fontSize: 15, height: 1.6),
            ),
          ),
          const SizedBox(height: 32),
          
          const SectionHeader(title: 'Required Skills'),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              SkillChip(label: internship.requiredSkill, isSelected: true),
              const SkillChip(label: 'Communication'),
              const SkillChip(label: 'Teamwork'),
            ],
          ),
          const SizedBox(height: 48),
          
          GradientButton(
            text: 'Apply Now',
            onPressed: () => _showApplyDialog(context, internship),
          ),
          const SizedBox(height: 12),
          Center(
            child: TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.bookmark_border_rounded),
              label: const Text('Save for Later'),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildHeader(InternshipModel internship) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: AppColors.primaryBlue.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Icon(Icons.business_rounded, color: AppColors.primaryBlue, size: 32),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                internship.title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.darkNavy),
              ),
              const SizedBox(height: 4),
              Text(
                internship.company,
                style: const TextStyle(fontSize: 18, color: AppColors.primaryBlue, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              const StatusBadge(label: 'Active Opportunity', color: AppColors.successGreen),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOverviewGrid(InternshipModel internship) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 2.5,
      children: [
        _overviewItem(Icons.location_on_outlined, 'Location', internship.location),
        _overviewItem(Icons.access_time_rounded, 'Duration', internship.duration),
        _overviewItem(Icons.payments_outlined, 'Stipend', internship.stipend),
        _overviewItem(Icons.event_available_rounded, 'Start Date', internship.startDate),
        _overviewItem(Icons.timer_rounded, 'Deadline', internship.deadline, isDestructive: true),
      ],
    );
  }

  Widget _overviewItem(IconData icon, String label, String value, {bool isDestructive = false}) {
    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(icon, size: 18, color: isDestructive ? AppColors.dangerRed : AppColors.primaryBlue),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(label, style: const TextStyle(color: AppColors.mutedText, fontSize: 10)),
                Text(
                  value, 
                  style: TextStyle(
                    fontWeight: FontWeight.bold, 
                    fontSize: 13,
                    color: isDestructive ? AppColors.dangerRed : AppColors.darkNavy,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  void _showApplyDialog(BuildContext context, InternshipModel internship) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('Confirm Application'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('You are about to apply for:'),
            const SizedBox(height: 8),
            Text(
              internship.title,
              style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryBlue),
            ),
            Text('at ${internship.company}'),
            const SizedBox(height: 16),
            const Text('Your profile details and CV will be shared with the recruiter.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: AppColors.mutedText)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSuccessDialog(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Confirm Application', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle_outline, color: AppColors.successGreen, size: 80),
            const SizedBox(height: 24),
            const Text(
              'Applied Successfully!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Your application has been sent. You can track its status in "My Applications".',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.mutedText),
            ),
            const SizedBox(height: 32),
            GradientButton(
              text: 'View My Applications',
              onPressed: () {
                Navigator.pop(context); // Close dialog
                context.pushReplacement('/student/applications');
              },
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Back to Internships', style: TextStyle(color: AppColors.mutedText)),
            ),
          ],
        ),
      ),
    );
  }
}

