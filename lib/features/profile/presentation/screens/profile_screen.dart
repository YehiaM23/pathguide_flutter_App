import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pathguide_app/core/theme/app_colors.dart';
import 'package:pathguide_app/core/widgets/reusable_widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  'JD',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryBlue,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'John Doe',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              'Computer Science Student',
              style: TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 32),
            _buildProfileSection(
              'About Me',
              'Passionate about mobile development and AI. Looking for internship opportunities in Flutter.',
            ),
            const SizedBox(height: 24),
            _buildSkillSection(),
            const SizedBox(height: 24),
            _buildCVSection(context),
            const SizedBox(height: 24),
            ListTile(
              leading: const Icon(Icons.assignment_outlined, color: AppColors.primaryBlue),
              title: const Text('My Applications'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/applications'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Colors.grey[200]!),
              ),
            ),
            const SizedBox(height: 12),
            ListTile(
              leading: const Icon(Icons.business_center_outlined, color: AppColors.primaryBlue),
              title: const Text('Switch to Recruiter View'),
              subtitle: const Text('Demo Mode'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.push('/recruiter'),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(color: Colors.grey[200]!),
              ),
            ),
            const SizedBox(height: 32),
            GradientButton(
              text: 'Logout',
              onPressed: () => context.go('/login'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(content, style: const TextStyle(color: AppColors.textSecondary, height: 1.5)),
      ],
    );
  }

  Widget _buildSkillSection() {
    final skills = ['Flutter', 'Dart', 'Firebase', 'Git', 'UI Design', 'Python'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Skills', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: skills.map((skill) => Chip(
            label: Text(skill),
            backgroundColor: AppColors.primaryBlue.withValues(alpha: 0.1),
            side: BorderSide.none,
            labelStyle: const TextStyle(color: AppColors.primaryBlue),
          )).toList(),
        ),
      ],
    );
  }

  Widget _buildCVSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Resume / CV', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextButton(
              onPressed: () async {
                final scaffoldMessenger = ScaffoldMessenger.of(context);
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['pdf', 'doc', 'docx'],
                );
                if (result != null) {
                  scaffoldMessenger.showSnackBar(
                    SnackBar(content: Text('Uploaded: ${result.files.first.name}'), backgroundColor: AppColors.success),
                  );
                }
              },
              child: const Text('Upload New'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Row(
            children: [
              const Icon(Icons.description, color: AppColors.primaryBlue, size: 40),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('John_Doe_CV.pdf', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('Uploaded on Oct 12, 2023', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.download),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }
}

