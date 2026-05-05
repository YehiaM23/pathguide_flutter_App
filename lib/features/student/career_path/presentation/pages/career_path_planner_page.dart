import 'package:flutter/material.dart';
import 'package:pathguide_app/core/theme/app_colors.dart';
import 'package:pathguide_app/core/widgets/reusable_widgets.dart';

class CareerPathPlannerPage extends StatelessWidget {
  const CareerPathPlannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: 'Career Path Planner',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Your Roadmap',
            subtitle: 'Generate and track your personalized learning path to your dream career.',
          ),
          const SizedBox(height: 32),
          
          _buildCareerGoalCard(),
          const SizedBox(height: 16),
          _buildCurrentSkillsCard(),
          const SizedBox(height: 32),
          
          const SectionHeader(
            title: 'Path to Full-Stack Developer',
            subtitle: 'A data-driven curriculum based on current industry requirements.',
          ),
          const SizedBox(height: 20),
          _buildSummaryStats(),
          const SizedBox(height: 32),
          
          _buildRequiredSkillsSection(),
          const SizedBox(height: 24),
          _buildSkillsToLearnSection(),
          const SizedBox(height: 32),
          
          const SectionHeader(
            title: 'Learning Journey',
            subtitle: 'Follow these courses in order to build your skills progressively.',
          ),
          const SizedBox(height: 20),
          _buildCourseItem(
            title: 'NumPy Masterclass: Python on Data Science & Machine Learning',
            skill: 'Python',
            duration: '5.5 hours',
            totalTime: '5.5 hours',
            context: context,
            isCompleted: true,
          ),
          const SizedBox(height: 16),
          _buildCourseItem(
            title: 'MongoDB Masterclass: Excel in NoSQL & Pass Certification!',
            skill: 'MongoDB',
            duration: '14.5 hours',
            totalTime: '20 hours',
            context: context,
            isCurrent: true,
          ),
          const SizedBox(height: 16),
          _buildCourseItem(
            title: 'React & TypeScript - The Practical Guide',
            skill: 'React',
            duration: '8 hours',
            totalTime: '28 hours',
            context: context,
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildCareerGoalCard() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Career Goal', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: AppColors.mutedText)),
                  const SizedBox(height: 4),
                  const Text(
                    'Full-Stack Developer',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primaryBlue),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.stars_rounded, color: AppColors.primaryBlue),
              ),
            ],
          ),
          const Divider(height: 32),
          Row(
            children: [
              const Icon(Icons.info_outline, size: 16, color: AppColors.mutedText),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Based on your profile settings and interests.',
                  style: TextStyle(color: AppColors.mutedText, fontSize: 12),
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(visualDensity: VisualDensity.compact),
                child: const Text('Change Goal', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCurrentSkillsCard() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Your Current Arsenal', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.darkNavy)),
          const SizedBox(height: 4),
          const Text('Skills already in your profile.', style: TextStyle(color: AppColors.mutedText, fontSize: 13)),
          const SizedBox(height: 20),
          const Wrap(
            spacing: 8,
            runSpacing: 10,
            children: [
              SkillChip(label: 'HTML5', isSelected: true),
              SkillChip(label: 'CSS3', isSelected: true),
              SkillChip(label: 'JavaScript', isSelected: true),
              SkillChip(label: 'PyTorch', isSelected: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryStats() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 1.8,
      children: [
        _statCard('Total Courses', '9', AppColors.primaryBlue, Icons.library_books_rounded),
        _statCard('Skills to Gain', '7', AppColors.teal, Icons.auto_awesome_rounded),
        _statCard('Learning Time', '342 hrs', AppColors.warningYellow, Icons.timer_rounded),
        _statCard('Est. Completion', '34 wks', AppColors.primaryBlue, Icons.event_available_rounded),
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
          Icon(icon, size: 20, color: color),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.darkNavy),
              ),
              Text(label, style: const TextStyle(color: AppColors.mutedText, fontSize: 11, fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRequiredSkillsSection() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Industry Requirements', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.darkNavy)),
          const SizedBox(height: 4),
          const Text('Skills typically required for this role.', style: TextStyle(color: AppColors.mutedText, fontSize: 13)),
          const SizedBox(height: 20),
          const Wrap(
            spacing: 8,
            runSpacing: 10,
            children: [
              _SkillCheckChip(label: 'Docker', isDone: false),
              _SkillCheckChip(label: 'Express', isDone: false),
              _SkillCheckChip(label: 'JavaScript', isDone: true),
              _SkillCheckChip(label: 'MongoDB', isDone: false),
              _SkillCheckChip(label: 'Node.js', isDone: false),
              _SkillCheckChip(label: 'PostgreSQL', isDone: false),
              _SkillCheckChip(label: 'Python', isDone: false),
              _SkillCheckChip(label: 'React', isDone: false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsToLearnSection() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Your Gap Analysis', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.darkNavy)),
          const SizedBox(height: 4),
          const Text('Missing skills you need to acquire.', style: TextStyle(color: AppColors.mutedText, fontSize: 13)),
          const SizedBox(height: 20),
          const Wrap(
            spacing: 8,
            runSpacing: 10,
            children: [
              SkillChip(label: 'Docker'),
              SkillChip(label: 'Express'),
              SkillChip(label: 'MongoDB'),
              SkillChip(label: 'Node.js'),
              SkillChip(label: 'PostgreSQL'),
              SkillChip(label: 'Python'),
              SkillChip(label: 'React'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCourseItem({
    required String title,
    required String skill,
    required String duration,
    required String totalTime,
    required BuildContext context,
    bool isCompleted = false,
    bool isCurrent = false,
  }) {
    return AppCard(
      padding: EdgeInsets.zero,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 6,
              decoration: BoxDecoration(
                color: isCompleted 
                  ? AppColors.successGreen 
                  : (isCurrent ? AppColors.primaryBlue : AppColors.cardBorder),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        if (isCompleted)
                          const Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(Icons.check_circle, color: AppColors.successGreen, size: 18),
                          ),
                        Expanded(
                          child: Text(
                            title, 
                            style: TextStyle(
                              fontWeight: FontWeight.bold, 
                              fontSize: 15,
                              color: isCompleted ? AppColors.mutedText : AppColors.darkNavy,
                              decoration: isCompleted ? TextDecoration.lineThrough : null,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        StatusBadge(
                          label: skill, 
                          color: isCompleted ? AppColors.mutedText : AppColors.primaryBlue
                        ),
                        const SizedBox(width: 12),
                        const Icon(Icons.access_time, size: 14, color: AppColors.mutedText),
                        const SizedBox(width: 4),
                        Text(duration, style: const TextStyle(color: AppColors.mutedText, fontSize: 12)),
                        const Spacer(),
                        if (isCurrent)
                          const StatusBadge(label: 'In Progress', color: AppColors.primaryBlue),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              minimumSize: const Size(0, 44),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            child: const Text('View Details'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: isCompleted ? null : () => _showMarkCompleteDialog(context, title, skill),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(0, 44),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              backgroundColor: isCompleted ? AppColors.successGreen : null,
                            ),
                            child: Text(isCompleted ? 'Completed' : 'Complete'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  void _showMarkCompleteDialog(BuildContext context, String title, String skill) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Mark Course Complete'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.lightBlue,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                  const SizedBox(height: 4),
                  Text('Skill: $skill · 6 hours', style: const TextStyle(color: AppColors.mutedText, fontSize: 11)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const AppTextField(
              label: 'Certificate URL (optional)',
              hint: 'https://www.coursera.org/degrees/masters',
            ),
            const SizedBox(height: 8),
            const Text(
              'Paste a link to your certificate of completion from Coursera, Udemy, LinkedIn Learning, etc.',
              style: TextStyle(fontSize: 10, color: AppColors.mutedText),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Mark Complete')),
        ],
      ),
    );
  }
}

class _SkillCheckChip extends StatelessWidget {
  final String label;
  final bool isDone;
  const _SkillCheckChip({required this.label, required this.isDone});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isDone ? AppColors.successGreen.withValues(alpha: 0.1) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isDone ? AppColors.successGreen : AppColors.cardBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isDone) const Icon(Icons.check, color: AppColors.successGreen, size: 14),
          if (isDone) const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: isDone ? AppColors.successGreen : AppColors.mutedText,
              fontSize: 12,
              fontWeight: isDone ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

