import 'package:flutter/material.dart';
import 'package:pathguide_app/core/theme/app_colors.dart';
import 'package:pathguide_app/core/widgets/reusable_widgets.dart';
import 'package:pathguide_app/core/data/models.dart';

class StudentApplicationsPage extends StatefulWidget {
  const StudentApplicationsPage({super.key});

  @override
  State<StudentApplicationsPage> createState() => _StudentApplicationsPageState();
}

class _StudentApplicationsPageState extends State<StudentApplicationsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _applications = [
    {
      'internship': const InternshipModel(
        id: '1',
        title: 'mobile developer',
        company: 'Vois',
        description: '',
        location: 'smart village',
        duration: '1 month',
        stipend: '5000 EGP',
        startDate: '05/01/2026',
        deadline: '30/01/2026',
        requiredSkill: 'Figma',
      ),
      'application': const ApplicationModel(
        id: 'app1',
        internshipId: '1',
        studentId: 'student123',
        status: 'Applied',
        appliedDate: '15/12/2025',
      ),
    },
    {
      'internship': const InternshipModel(
        id: '5',
        title: 'UX/UI Design',
        company: 'Designers Hub',
        description: '',
        location: 'Remote',
        duration: '3 months',
        stipend: 'Unpaid',
        startDate: '01/01/2026',
        deadline: '15/01/2026',
        requiredSkill: 'Figma',
      ),
      'application': const ApplicationModel(
        id: 'app2',
        internshipId: '5',
        studentId: 'student123',
        status: 'Accepted',
        appliedDate: '10/12/2025',
        reviewedDate: '20/12/2025',
      ),
    },
    {
      'internship': const InternshipModel(
        id: '6',
        title: 'Backend Intern',
        company: 'TechCorp',
        description: '',
        location: 'Maadi',
        duration: '2 months',
        stipend: '4000 EGP',
        startDate: '01/11/2025',
        deadline: '15/10/2025',
        requiredSkill: 'Node.js',
      ),
      'application': ApplicationModel(
        id: 'app3',
        internshipId: '6',
        studentId: 'student123',
        status: 'Completed',
        appliedDate: '01/10/2025',
        reviewedDate: '05/10/2025',
        completionDate: '01/01/2026',
        rating: 4.5,
        feedback: 'Excellent work on the API endpoints!',
        certificateUrl: 'https://example.com/cert.pdf',
      ),
    },
  ];

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
    return PageScaffold(
      title: 'My Applications',
      padding: EdgeInsets.zero,
      scrollable: false,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            alignment: Alignment.centerLeft,
            child: const SectionHeader(
              title: 'Track Your Journey',
              subtitle: 'Stay updated on your internship application statuses.',
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
              Tab(text: 'Active'),
              Tab(text: 'Accepted'),
              Tab(text: 'History'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildApplicationList(['Applied', 'Under Review']),
                _buildApplicationList(['Accepted']),
                _buildApplicationList(['Completed', 'Rejected']),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApplicationList(List<String> statuses) {
    final filtered = _applications.where((app) => statuses.contains(app['application'].status)).toList();

    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.cardBorder.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.assignment_outlined, size: 48, color: AppColors.mutedText.withValues(alpha: 0.4)),
            ),
            const SizedBox(height: 20),
            const Text(
              'No applications found',
              style: TextStyle(color: AppColors.darkNavy, fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            const Text(
              'Try applying for more internships to see them here.',
              style: TextStyle(color: AppColors.mutedText, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(24),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        final item = filtered[index];
        final InternshipModel internship = item['internship'];
        final ApplicationModel application = item['application'];

        return _buildApplicationCard(internship, application);
      },
    );
  }

  Widget _buildApplicationCard(InternshipModel internship, ApplicationModel application) {
    Color statusColor;
    IconData statusIcon;
    switch (application.status) {
      case 'Accepted':
        statusColor = AppColors.successGreen;
        statusIcon = Icons.check_circle_rounded;
        break;
      case 'Rejected':
        statusColor = AppColors.dangerRed;
        statusIcon = Icons.cancel_rounded;
        break;
      case 'Completed':
        statusColor = AppColors.primaryBlue;
        statusIcon = Icons.stars_rounded;
        break;
      case 'Under Review':
        statusColor = AppColors.warningYellow;
        statusIcon = Icons.hourglass_empty_rounded;
        break;
      default:
        statusColor = AppColors.mutedText;
        statusIcon = Icons.send_rounded;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: AppCard(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(statusIcon, color: statusColor, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        internship.title,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.darkNavy),
                      ),
                      Text(
                        internship.company,
                        style: const TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.w600, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                StatusBadge(label: application.status, color: statusColor),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                _miniInfo(Icons.calendar_today_rounded, 'Applied: ${application.appliedDate}'),
                const SizedBox(width: 16),
                _miniInfo(Icons.location_on_rounded, internship.location),
              ],
            ),
            if (application.status == 'Completed') ...[
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.primaryBlue.withValues(alpha: 0.1)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Review & Feedback', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                        RatingStars(rating: application.rating ?? 0, size: 14),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      application.feedback ?? 'No feedback provided.',
                      style: const TextStyle(color: AppColors.mutedText, fontSize: 13, height: 1.4),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              GradientButton(
                text: 'Download Certificate',
                onPressed: () {},
                height: 44,
              ),
            ] else if (application.status == 'Accepted') ...[
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Accept Offer'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text('Decline'),
                    ),
                  ),
                ],
              ),
            ] else ...[
              const SizedBox(height: 20),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 44)),
                child: const Text('View Application Details'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _miniInfo(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 12, color: AppColors.mutedText),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(fontSize: 11, color: AppColors.mutedText, fontWeight: FontWeight.w500)),
      ],
    );
  }

}



