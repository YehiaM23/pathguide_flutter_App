import 'package:flutter/material.dart';
import 'package:pathguide_app/core/theme/app_colors.dart';
import 'package:pathguide_app/core/widgets/reusable_widgets.dart';
import 'package:pathguide_app/features/recruiter/dashboard/presentation/widgets/recruiter_dashboard_scaffold.dart';

class AllApplicationsPage extends StatefulWidget {
  const AllApplicationsPage({super.key});

  @override
  State<AllApplicationsPage> createState() => _AllApplicationsPageState();
}

class _AllApplicationsPageState extends State<AllApplicationsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RecruiterDashboardScaffold(
      title: 'Applications',
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const SectionHeader(
              title: 'Review Applicants',
              subtitle: 'Manage and track applications for your posted internships.',
            ),
          ),
          const SizedBox(height: 16),
          TabBar(
            controller: _tabController,
            labelColor: AppColors.primaryBlue,
            unselectedLabelColor: AppColors.mutedText,
            indicatorColor: AppColors.primaryBlue,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 3,
            labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            tabs: const [
              Tab(text: 'Pending'),
              Tab(text: 'Accepted'),
              Tab(text: 'Completed'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildApplicationList('Pending'),
                _buildApplicationList('Accepted'),
                _buildApplicationList('Completed'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApplicationList(String status) {
    // Mock data for applicants
    final List<Map<String, String>> applicants = [
      {'name': 'Ahmed Ali', 'internship': 'Mobile Developer', 'university': 'Cairo University', 'gpa': '3.8'},
      {'name': 'Sara Mohamed', 'internship': 'Mobile Developer', 'university': 'GUC', 'gpa': '3.5'},
      {'name': 'John Doe', 'internship': 'Backend Intern', 'university': 'AUC', 'gpa': '3.9'},
    ];

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 24),
      itemCount: applicants.length,
      itemBuilder: (context, index) {
        final applicant = applicants[index];
        return _buildApplicantCard(applicant, status);
      },
    );
  }

  Widget _buildApplicantCard(Map<String, String> applicant, String status) {
    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    applicant['name']![0],
                    style: const TextStyle(
                      fontSize: 20,
                      color: AppColors.primaryBlue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      applicant['name']!, 
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.darkNavy)
                    ),
                    Text(
                      applicant['internship']!, 
                      style: const TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.w600, fontSize: 14)
                    ),
                  ],
                ),
              ),
              StatusBadge(
                label: 'GPA: ${applicant['gpa']}', 
                color: AppColors.successGreen
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const Icon(Icons.school_rounded, size: 14, color: AppColors.mutedText),
              const SizedBox(width: 8),
              Text(
                applicant['university']!, 
                style: const TextStyle(color: AppColors.mutedText, fontSize: 13)
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _showReviewDialog(applicant),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryBlue,
                    side: const BorderSide(color: AppColors.primaryBlue),
                    minimumSize: const Size(0, 44),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('View Profile'),
                ),
              ),
              const SizedBox(width: 12),
              if (status == 'Pending') ...[
                Expanded(
                  child: GradientButton(
                    text: 'Accept',
                    onPressed: () {},
                    height: 44,
                  ),
                ),
              ] else if (status == 'Accepted') ...[
                Expanded(
                  child: GradientButton(
                    text: 'Complete',
                    onPressed: () => _showCompletionDialog(applicant),
                    height: 44,
                  ),
                ),
              ] else ...[
                const Expanded(
                  child: Center(
                    child: StatusBadge(label: 'Completed', color: AppColors.primaryBlue),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    ).withMargin(const EdgeInsets.only(bottom: 16));
  }

  void _showReviewDialog(Map<String, String> applicant) {
    // Show student profile details...
  }

  void _showCompletionDialog(Map<String, String> applicant) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Complete Internship'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Provide feedback and rating for ${applicant['name']}'),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(hintText: 'Feedback/Evaluation', border: OutlineInputBorder()),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.star, color: Colors.amber),
                Icon(Icons.star, color: Colors.amber),
                Icon(Icons.star, color: Colors.amber),
                Icon(Icons.star, color: Colors.amber),
                Icon(Icons.star_border, color: Colors.amber),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Submit & Finish', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

extension on Widget {
  Widget withMargin(EdgeInsets margin) => Container(margin: margin, child: this);
}
