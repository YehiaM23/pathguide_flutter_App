import 'package:flutter/material.dart';
import 'package:pathguide_app/core/theme/app_colors.dart';
import 'package:pathguide_app/core/widgets/reusable_widgets.dart';
import 'package:pathguide_app/core/data/models.dart';
import 'package:pathguide_app/features/recruiter/dashboard/presentation/widgets/recruiter_dashboard_scaffold.dart';

class MyInternshipsPage extends StatelessWidget {
  const MyInternshipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<InternshipModel> myInternships = [
      const InternshipModel(
        id: '1',
        title: 'Mobile Developer',
        company: 'Vois',
        description: 'Mobile development internship',
        location: 'Smart Village',
        duration: '1 month',
        stipend: '5000 EGP',
        startDate: '05/01/2026',
        deadline: '30/01/2026',
        requiredSkill: 'Figma',
      ),
      const InternshipModel(
        id: '2',
        title: 'Embedded Systems',
        company: 'Vois',
        description: 'Embedded Systems internship',
        location: 'Cairo',
        duration: '3 months',
        stipend: '3000 EGP',
        startDate: '06/01/2026',
        deadline: '07/02/2026',
        requiredSkill: 'CSS',
      ),
    ];

    return RecruiterDashboardScaffold(
      title: 'My Internships',
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: myInternships.length,
              itemBuilder: (context, index) {
                final internship = myInternships[index];
                return _buildInternshipCard(internship);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInternshipCard(InternshipModel internship) {
    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                internship.title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.darkNavy),
              ),
              const StatusBadge(label: 'Active', color: AppColors.successGreen),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.people_outline, size: 16, color: AppColors.mutedText),
              const SizedBox(width: 8),
              const Text('12 Applicants', style: TextStyle(color: AppColors.mutedText)),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryBlue,
                    side: const BorderSide(color: AppColors.primaryBlue),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Edit'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GradientButton(
                  text: 'View Applicants',
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    ).withMargin(const EdgeInsets.only(bottom: 16));
  }
}

extension on Widget {
  Widget withMargin(EdgeInsets margin) => Container(margin: margin, child: this);
}
