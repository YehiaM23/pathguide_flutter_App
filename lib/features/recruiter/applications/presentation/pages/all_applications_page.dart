import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pathguide_app/core/theme/app_colors.dart';
import 'package:pathguide_app/core/widgets/reusable_widgets.dart';
import 'package:pathguide_app/core/data/models.dart';
import 'package:pathguide_app/features/recruiter/dashboard/presentation/widgets/recruiter_dashboard_scaffold.dart';
import 'package:pathguide_app/features/recruiter/applications/presentation/bloc/application_bloc.dart';
import 'package:pathguide_app/features/recruiter/applications/presentation/bloc/application_event.dart';
import 'package:pathguide_app/features/recruiter/applications/presentation/bloc/application_state.dart';
import 'package:pathguide_app/features/recruiter/internships/presentation/bloc/internship_bloc.dart';

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
            child: BlocBuilder<ApplicationBloc, ApplicationState>(
              builder: (context, state) {
                if (state is ApplicationLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ApplicationLoaded) {
                  return TabBarView(
                    controller: _tabController,
                    children: [
                      _buildApplicationList(state.applications, 'Pending'),
                      _buildApplicationList(state.applications, 'Accepted'),
                      _buildApplicationList(state.applications, 'Completed'),
                    ],
                  );
                } else if (state is ApplicationError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApplicationList(List<ApplicationModel> applications, String status) {
    final filteredApps = applications.where((app) => app.status == status).toList();

    if (filteredApps.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.assignment_late_outlined, size: 64, color: AppColors.mutedText.withValues(alpha: 0.5)),
            const SizedBox(height: 16),
            Text(
              'No $status applications found',
              style: const TextStyle(color: AppColors.mutedText, fontSize: 16),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 24),
      itemCount: filteredApps.length,
      itemBuilder: (context, index) {
        final app = filteredApps[index];
        return _buildApplicantCard(app);
      },
    );
  }

  Widget _buildApplicantCard(ApplicationModel app) {
    // In a real app, we'd fetch student and internship details from their IDs.
    // For now, we'll use mock data mapped from IDs.
    final Map<String, Map<String, String>> studentMocks = {
      'std_1': {'name': 'Ahmed Ali', 'university': 'Cairo University', 'gpa': '3.8'},
      'std_2': {'name': 'Sara Mohamed', 'university': 'GUC', 'gpa': '3.5'},
      'std_3': {'name': 'John Doe', 'university': 'AUC', 'gpa': '3.9'},
    };

    final student = studentMocks[app.studentId] ?? {'name': 'Unknown Student', 'university': 'Unknown', 'gpa': 'N/A'};

    return BlocBuilder<InternshipBloc, InternshipState>(
      builder: (context, state) {
        String internshipTitle = 'Unknown Internship';
        if (state is InternshipLoaded) {
          final internship = state.myInternships.firstWhere(
            (i) => i.id == app.internshipId,
            orElse: () => InternshipModel(id: '', title: 'Internship Not Found', company: '', description: '', location: '', duration: '', stipend: '', startDate: '', deadline: '', requiredSkill: ''),
          );
          internshipTitle = internship.title;
        }

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
                        student['name']![0],
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
                          student['name']!, 
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.darkNavy)
                        ),
                        Text(
                          internshipTitle, 
                          style: const TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.w600, fontSize: 14)
                        ),
                      ],
                    ),
                  ),
                  StatusBadge(
                    label: 'GPA: ${student['gpa']}', 
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
                    student['university']!, 
                    style: const TextStyle(color: AppColors.mutedText, fontSize: 13)
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => _showReviewDialog(student),
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
                  if (app.status == 'Pending') ...[
                    Expanded(
                      child: GradientButton(
                        text: 'Accept',
                        onPressed: () {
                          context.read<ApplicationBloc>().add(
                            UpdateApplicationStatus(applicationId: app.id, status: 'Accepted')
                          );
                        },
                        height: 44,
                      ),
                    ),
                  ] else if (app.status == 'Accepted') ...[
                    Expanded(
                      child: GradientButton(
                        text: 'Complete',
                        onPressed: () => _showCompletionDialog(app, student['name']!),
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
      },
    );
  }

  void _showReviewDialog(Map<String, String> student) {
    // Show student profile details...
  }

  void _showCompletionDialog(ApplicationModel app, String studentName) {
    final TextEditingController feedbackController = TextEditingController();
    double rating = 4.0;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Complete Internship'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Provide feedback and rating for $studentName'),
              const SizedBox(height: 16),
              TextField(
                controller: feedbackController,
                decoration: const InputDecoration(
                  hintText: 'Feedback/Evaluation', 
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.primaryBlue)),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    onPressed: () => setState(() => rating = index + 1.0),
                    icon: Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 32,
                    ),
                  );
                }),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: const Text('Cancel', style: TextStyle(color: AppColors.mutedText))
            ),
            ElevatedButton(
              onPressed: () {
                context.read<ApplicationBloc>().add(
                  UpdateApplicationStatus(
                    applicationId: app.id, 
                    status: 'Completed',
                    feedback: feedbackController.text,
                    rating: rating,
                  )
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text('Submit & Finish', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
