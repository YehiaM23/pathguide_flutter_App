import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pathguide_app/core/theme/app_colors.dart';
import 'package:pathguide_app/core/widgets/reusable_widgets.dart';
import 'package:pathguide_app/features/auth/presentation/bloc/auth_bloc.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        final user = state is AuthAuthenticated ? state.user : null;
        final userName = user?.name ?? 'Student';
        final userEmail = user?.email ?? '';

        return PageScaffold(
          showLogo: true,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          drawer: _buildStudentDrawer(context, userName, userEmail),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none_outlined, size: 26),
              onPressed: () => context.push('/notifications'),
            ),
            const SizedBox(width: 8),
          ],
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWelcomeHeader(userName),
              const SizedBox(height: 32),
              _buildStatsGrid(),
              const SizedBox(height: 32),
              const SectionHeader(title: 'Quick Actions', subtitle: 'What would you like to do today?'),
              const SizedBox(height: 16),
              _buildActionCard(
                context,
                title: 'Find Internships',
                description: 'Explore opportunities that match your skills.',
                icon: Icons.search_rounded,
                color: AppColors.primaryBlue,
                onPressed: () => context.push('/student/internships'),
              ),
              const SizedBox(height: 16),
              _buildActionCard(
                context,
                title: 'My Applications',
                description: 'Track and manage your sent applications.',
                icon: Icons.assignment_rounded,
                color: AppColors.teal,
                onPressed: () => context.push('/student/applications'),
              ),
              const SizedBox(height: 16),
              _buildActionCard(
                context,
                title: 'Career Planner',
                description: 'Design your journey to your dream job.',
                icon: Icons.map_rounded,
                color: AppColors.warningYellow,
                onPressed: () => context.push('/student/career-path'),
              ),
              const SizedBox(height: 32),
              _buildProfileSummary(userName, userEmail),
              const SizedBox(height: 32),
              _buildSkillsInterestsSection(context),
              const SizedBox(height: 32),
              _buildCalendarSection(),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWelcomeHeader(String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello, $name 👋',
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.darkNavy,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Let\'s make progress on your career today.',
          style: TextStyle(color: AppColors.mutedText, fontSize: 15),
        ),
      ],
    );
  }

  Widget _buildStatsGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.6,
      children: [
        _statCard('Active Apps', '2', AppColors.primaryBlue, Icons.send_rounded),
        _statCard('Skill Level', 'Intermediate', AppColors.teal, Icons.trending_up_rounded),
        _statCard('Saved Jobs', '12', AppColors.warningYellow, Icons.bookmark_rounded),
        _statCard('Path Progress', '45%', AppColors.primaryBlue, Icons.auto_graph_rounded),
      ],
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
              Text(label, style: const TextStyle(color: AppColors.mutedText, fontSize: 12, fontWeight: FontWeight.w500)),
              Icon(icon, size: 16, color: color.withValues(alpha: 0.5)),
            ],
          ),
          Text(
            value,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.darkNavy),
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

  Widget _buildProfileSummary(String name, String email) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Profile Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.darkNavy)),
              TextButton(onPressed: () {}, child: const Text('Edit')),
            ],
          ),
          const SizedBox(height: 16),
          _infoRow(Icons.person_outline, 'Name', name),
          _infoRow(Icons.email_outlined, 'Email', email),
          _infoRow(Icons.school_outlined, 'University', 'Nile University'),
          _infoRow(Icons.workspace_premium_outlined, 'Major', 'Computer Science'),
          _infoRow(Icons.calendar_today_outlined, 'Graduation', '2026'),
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
          const Spacer(),
          Text(value, style: const TextStyle(color: AppColors.darkNavy, fontWeight: FontWeight.w600, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildSkillsInterestsSection(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Expertise & Interests', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.darkNavy)),
          const SizedBox(height: 20),
          const Text('Skills', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.mutedText)),
          const SizedBox(height: 12),
          const Wrap(
            spacing: 8,
            runSpacing: 10,
            children: [
              SkillChip(label: 'HTML5', isSelected: true),
              SkillChip(label: 'Flutter', isSelected: true),
              SkillChip(label: 'Dart', isSelected: true),
              SkillChip(label: 'PyTorch', isSelected: true),
              SkillChip(label: 'Firebase', isSelected: true),
            ],
          ),
          const SizedBox(height: 24),
          const Text('Interests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.mutedText)),
          const SizedBox(height: 12),
          const Wrap(
            spacing: 8,
            runSpacing: 10,
            children: [
              SkillChip(label: 'AI Research'),
              SkillChip(label: 'Mobile UX'),
              SkillChip(label: 'Open Source'),
            ],
          ),
          const SizedBox(height: 24),
          OutlinedButton(
            onPressed: () => context.push('/student/profile'),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Update Profile'),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarSection() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Upcoming Deadlines', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.darkNavy)),
          const SizedBox(height: 20),
          _deadlineItem('Google Summer of Code', 'Jan 15, 2026', AppColors.primaryBlue),
          const Divider(height: 24),
          _deadlineItem('Microsoft Internship', 'Feb 02, 2026', AppColors.teal),
        ],
      ),
    );
  }

  Widget _deadlineItem(String title, String date, Color color) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 32,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              Text(date, style: const TextStyle(color: AppColors.mutedText, fontSize: 12)),
            ],
          ),
        ),
        const Icon(Icons.chevron_right, size: 20, color: AppColors.cardBorder),
      ],
    );
  }

  Widget _buildStudentDrawer(BuildContext context, String name, String email) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
            decoration: const BoxDecoration(gradient: AppColors.mainGradient),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(Icons.person, color: Colors.white, size: 30),
                ),
                const SizedBox(height: 16),
                Text(
                  name,
                  style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  email,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _drawerItem(Icons.dashboard_outlined, 'Dashboard', () => Navigator.pop(context), isSelected: true),
          _drawerItem(Icons.person_outline, 'My Profile', () => context.push('/student/profile')),
          _drawerItem(Icons.business_center_outlined, 'Internships', () => context.push('/student/internships')),
          _drawerItem(Icons.assignment_outlined, 'Applications', () => context.push('/student/applications')),
          _drawerItem(Icons.map_outlined, 'Career Path', () => context.push('/student/career-path')),
          const Spacer(),
          const Divider(),
          _drawerItem(Icons.logout_rounded, 'Sign Out', () {
            context.read<AuthBloc>().add(LogoutRequested());
            context.go('/home');
          }, color: AppColors.dangerRed),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, VoidCallback onTap, {bool isSelected = false, Color? color}) {
    return ListTile(
      leading: Icon(icon, color: color ?? (isSelected ? AppColors.primaryBlue : AppColors.mutedText)),
      title: Text(
        title, 
        style: TextStyle(
          color: color ?? (isSelected ? AppColors.primaryBlue : AppColors.darkNavy),
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
        ),
      ),
      onTap: onTap,
      dense: true,
      visualDensity: VisualDensity.compact,
    );
  }
}


