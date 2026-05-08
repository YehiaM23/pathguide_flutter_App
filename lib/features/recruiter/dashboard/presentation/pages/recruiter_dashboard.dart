import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pathguide_app/core/data/models.dart';
import 'package:pathguide_app/core/theme/app_colors.dart';
import 'package:pathguide_app/core/widgets/reusable_widgets.dart';
import 'package:pathguide_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pathguide_app/features/recruiter/applications/presentation/bloc/application_bloc.dart';
import 'package:pathguide_app/features/recruiter/applications/presentation/bloc/application_state.dart';
import 'package:pathguide_app/features/recruiter/internships/presentation/bloc/internship_bloc.dart';
import '../widgets/recruiter_dashboard_scaffold.dart';

class RecruiterDashboard extends StatelessWidget {
  const RecruiterDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final user = state is AuthAuthenticated ? state.user : null;
        final userName = user?.name ?? 'Recruiter';
        
        return RecruiterDashboardScaffold(
          title: 'Dashboard',
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none_outlined, size: 26),
              onPressed: () => context.push('/notifications'),
            ),
            const SizedBox(width: 8),
          ],
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(userName),
                const SizedBox(height: 32),
                _buildStatsGrid(),
                const SizedBox(height: 32),
                _buildCompanySummary(context, user),
                const SizedBox(height: 32),
                const SectionHeader(
                  title: 'Quick Actions',
                  subtitle: 'Manage your talent pipeline and opportunities.',
                ),
                const SizedBox(height: 16),
                _buildActionCard(
                  context,
                  title: 'Post Internship',
                  description: 'Create a new internship opportunity.',
                  icon: Icons.add_business_rounded,
                  color: AppColors.primaryBlue,
                  onPressed: () => context.push('/recruiter/post-internship'),
                ),
                const SizedBox(height: 16),
                _buildActionCard(
                  context,
                  title: 'My Internships',
                  description: 'View and edit your posted internships.',
                  icon: Icons.list_alt_rounded,
                  color: AppColors.teal,
                  onPressed: () => context.push('/recruiter/my-internships'),
                ),
                const SizedBox(height: 16),
                _buildActionCard(
                  context,
                  title: 'Applications',
                  description: 'Check status of pending applications.',
                  icon: Icons.assignment_ind_rounded,
                  color: AppColors.warningYellow,
                  onPressed: () => context.push('/recruiter/applications'),
                ),
                const SizedBox(height: 32),
                _buildRecentApplicantsSection(context),
                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome back, $name! 🏢',
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.darkNavy,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Manage your internships and review student applications',
          style: TextStyle(color: AppColors.mutedText, fontSize: 15),
        ),
      ],
    );
  }

  Widget _buildStatsGrid() {
    return BlocBuilder<InternshipBloc, InternshipState>(
      builder: (context, internshipState) {
        return BlocBuilder<ApplicationBloc, ApplicationState>(
          builder: (context, appState) {
            final activeInternships = internshipState is InternshipLoaded 
                ? internshipState.myInternships.where((i) => i.isActive).length 
                : 0;
            
            final applications = appState is ApplicationLoaded ? appState.applications : [];
            final totalApps = applications.length;
            final pendingApps = applications.where((a) => a.status == 'Pending').length;
            final completedApps = applications.where((a) => a.status == 'Completed').length;

            return LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;
                return GridView.count(
                  crossAxisCount: crossAxisCount,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.5,
                  children: [
                    _statCard('Active Internships', activeInternships.toString(), AppColors.primaryBlue, Icons.work_rounded),
                    _statCard('Total Applications', totalApps.toString(), AppColors.teal, Icons.groups_rounded),
                    _statCard('Pending Applications', pendingApps.toString(), AppColors.warningYellow, Icons.pending_actions_rounded),
                    _statCard('Completed Internships', completedApps.toString(), AppColors.successGreen, Icons.check_circle_outline_rounded),
                  ],
                );
              }
            );
          },
        );
      },
    );
  }

  Widget _statCard(String label, String value, Color color, IconData icon) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  label, 
                  style: const TextStyle(color: AppColors.mutedText, fontSize: 11, fontWeight: FontWeight.w500),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Icon(icon, size: 16, color: color.withValues(alpha: 0.5)),
            ],
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.darkNavy),
          ),
        ],
      ),
    );
  }

  Widget _buildCompanySummary(BuildContext context, UserModel? user) {
    final companyName = user?.companyName ?? user?.name ?? 'Company';
    final email = user?.email ?? '';
    final website = user?.companyWebsite ?? 'Not set';
    final location = user?.companyLocation ?? 'Not set';

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Company Profile', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.darkNavy)),
              TextButton(
                onPressed: () => context.push('/recruiter/profile'),
                child: const Text('Edit'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _infoRow(Icons.business_outlined, 'Company', companyName),
          _infoRow(Icons.email_outlined, 'Work Email', email),
          _infoRow(Icons.language_outlined, 'Website', website),
          _infoRow(Icons.location_on_outlined, 'Location', location),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.mutedText),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(color: AppColors.mutedText, fontSize: 14)),
          const SizedBox(width: 8),
          const Spacer(),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(color: AppColors.darkNavy, fontWeight: FontWeight.w600, fontSize: 14),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: AppCard(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(icon, color: color, size: 26),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.darkNavy)),
                  const SizedBox(height: 2),
                  Text(description, style: const TextStyle(color: AppColors.mutedText, fontSize: 13)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppColors.cardBorder),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentApplicantsSection(BuildContext context) {
    return BlocBuilder<ApplicationBloc, ApplicationState>(
      builder: (context, state) {
        if (state is ApplicationLoaded && state.applications.isNotEmpty) {
          // Get the last 3 applications
          final recentApps = state.applications.reversed.take(3).toList();
          
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent Activity',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.darkNavy),
                  ),
                  TextButton(
                    onPressed: () => context.push('/recruiter/applications'),
                    child: const Text('View All'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ...recentApps.map((app) {
                // Mock mapping student name and internship title
                final Map<String, String> studentMocks = {
                  'std_1': 'Ahmed Ali',
                  'std_2': 'Sara Mohamed',
                  'std_3': 'John Doe',
                };
                final studentName = studentMocks[app.studentId] ?? 'Unknown';
                
                return BlocBuilder<InternshipBloc, InternshipState>(
                  builder: (context, intState) {
                    String internshipTitle = 'Internship';
                    if (intState is InternshipLoaded) {
                      internshipTitle = intState.myInternships.firstWhere(
                        (i) => i.id == app.internshipId,
                        orElse: () => InternshipModel(id: '', title: 'Internship', company: '', description: '', location: '', duration: '', stipend: '', startDate: '', deadline: '', requiredSkill: ''),
                      ).title;
                    }
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildRecentApplicant(studentName, internshipTitle, app.appliedDate),
                    );
                  },
                );
              }),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildRecentApplicant(String name, String role, String time) {
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                name.isNotEmpty ? name[0] : '?',
                style: const TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.darkNavy, fontSize: 15)),
                Text('Applied for $role', style: const TextStyle(color: AppColors.mutedText, fontSize: 13)),
              ],
            ),
          ),
          Text(time, style: const TextStyle(color: AppColors.mutedText, fontSize: 11)),
        ],
      ),
    );
  }
}
