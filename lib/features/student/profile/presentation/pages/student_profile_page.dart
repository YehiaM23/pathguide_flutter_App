import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pathguide_app/core/theme/app_colors.dart';
import 'package:pathguide_app/core/widgets/reusable_widgets.dart';
import 'package:pathguide_app/features/auth/presentation/bloc/auth_bloc.dart';

class StudentProfilePage extends StatefulWidget {
  const StudentProfilePage({super.key});

  @override
  State<StudentProfilePage> createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _univController = TextEditingController();
  final _majorController = TextEditingController();
  final _gradYearController = TextEditingController();
  final _bioController = TextEditingController();
  
  String? _selectedCareerPath;
  String? _cvFileName;

  final List<String> _skills = [];
  final List<String> _interests = [];

  Future<void> _pickCV() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx'],
    );

    if (result != null) {
      setState(() {
        _cvFileName = result.files.single.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: 'Edit Profile',
      actions: [
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Profile updated successfully!'), backgroundColor: AppColors.successGreen),
            );
            context.pop();
          },
          child: const Text('Save', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
        ),
      ],
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthAuthenticated) {
            // Only initialize once or use a better state management for form fields
            if (_nameController.text.isEmpty) {
              _nameController.text = state.user.name;
              _emailController.text = state.user.email;
            }
          }
          
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildBasicInfoSection(),
                const SizedBox(height: 24),
                _buildLinksSection(),
                const SizedBox(height: 24),
                _buildSkillsSection(),
                const SizedBox(height: 24),
                _buildInterestsSection(),
                const SizedBox(height: 40),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBasicInfoSection() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Basic Information'),
          const SizedBox(height: 24),
          AppTextField(label: 'Full Name', hint: 'Enter your name', controller: _nameController),
          const SizedBox(height: 16),
          AppTextField(label: 'Email', hint: 'Enter your email', controller: _emailController, keyboardType: TextInputType.emailAddress),
          const SizedBox(height: 16),
          AppTextField(label: 'Phone', hint: 'Enter your phone', controller: _phoneController, keyboardType: TextInputType.phone),
          const SizedBox(height: 16),
          AppTextField(label: 'University', hint: 'Enter university', controller: _univController),
          const SizedBox(height: 16),
          AppTextField(label: 'Major', hint: 'Enter major', controller: _majorController),
          const SizedBox(height: 16),
          AppTextField(label: 'Graduation Year', hint: 'Enter year', controller: _gradYearController),
          const SizedBox(height: 16),
          AppTextField(label: 'Bio', hint: 'Tell us about yourself', controller: _bioController),
        ],
      ),
    );
  }

  Widget _buildLinksSection() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Links & Documents'),
          const SizedBox(height: 24),
          const AppTextField(label: 'LinkedIn URL', hint: 'https://linkedin.com/in/yourprofile'),
          const SizedBox(height: 16),
          const AppTextField(label: 'GitHub URL', hint: 'https://github.com/yourusername'),
          const SizedBox(height: 16),
          const Text('CV/Resume', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          const SizedBox(height: 8),
          InkWell(
            onTap: _pickCV,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.cardBorder),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.upload_file, color: AppColors.primaryBlue),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _cvFileName ?? 'Upload CV/Resume (PDF, DOC)',
                      style: TextStyle(
                        color: _cvFileName != null ? AppColors.darkNavy : AppColors.mutedText,
                      ),
                    ),
                  ),
                  if (_cvFileName != null)
                    IconButton(
                      icon: const Icon(Icons.close, size: 20),
                      onPressed: () => setState(() => _cvFileName = null),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Career Path', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            initialValue: _selectedCareerPath,
            items: ['Full-Stack Developer', 'Mobile Developer', 'Data Scientist', 'UI/UX Designer']
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (v) => setState(() => _selectedCareerPath = v),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsSection() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Skills', 
            subtitle: 'Your technical and professional skills',
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _skills.map((s) => SkillChip(label: s, isSelected: true)).toList(),
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add, size: 18),
            label: const Text('Add Skill'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primaryBlue,
              side: const BorderSide(color: AppColors.primaryBlue),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInterestsSection() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Interests', 
            subtitle: 'Your areas of interest',
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _interests.map((i) => SkillChip(label: i, isSelected: true)).toList(),
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add, size: 18),
            label: const Text('Add Interest'),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primaryBlue,
              side: const BorderSide(color: AppColors.primaryBlue),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}
