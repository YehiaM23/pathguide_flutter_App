import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pathguide_app/core/data/models.dart';
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

  final List<String> _allSkillsMaster = [
    'Adobe XD', 'Angular', 'AWS', 'CSS', 'Docker', 'Excel', 'Express', 'Figma',
    'Flutter', 'Git', 'HTML', 'Java', 'JavaScript', 'JUnit', 'Kotlin', 'Kubernetes',
    'MongoDB', 'NumPy', 'Pandas', 'PostgreSQL', 'Power BI', 'Python', 'PyTorch',
    'R', 'React', 'React Native', 'REST APIs', 'Sass', 'Selenium', 'SQL', 'Swift',
    'Tableau', 'TensorFlow', 'TestNG', 'TypeScript', 'Vue.js'
  ];

  final List<String> _allInterestsMaster = [
    'AI & Machine Learning', 'Anime', 'Audiobooks', 'Basketball', 'Beach', 'Blogging',
    'Building Apps', 'Business Strategy', 'Camping','Community Service',
    'Content Creation', 'Cooking', 'Cycling', 'Digital Art', 'Drawing', 'Entrepreneurship',
    'Fashion', 'Football', 'Freelancing', 'Gadgets', 'Gaming', 'Graphic Design',
    'Gym & Fitness', 'Hiking', 'Investing', 'Leadership', 'Learning Languages',
    'Marketing', 'Martial Arts', 'Mentoring', 'Movies', 'Music', 'Music Concerts',
    'Nature', 'Networking', 'Online Courses', 'Open Source', 'Personal Finance',
    'Photography', 'Playing Instruments', 'Podcasts', 'Programming', 'Public Speaking',
    'Reading', 'Road Trips', 'Running', 'Self Improvement',
    'Startups', 'Swimming', 'Teaching', 'Tech News', 'Theatre', 'Traveling',
    'TV Series', 'Video Editing', 'Volunteering', 'Writing'
  ];

  bool _isInitialized = false;

  void _initializeData(UserModel user) {
    if (_isInitialized) return;
    _nameController.text = user.name;
    _emailController.text = user.email;
    _phoneController.text = user.phone ?? '';
    _univController.text = user.university ?? '';
    _majorController.text = user.major ?? '';
    _gradYearController.text = user.graduationYear ?? '';
    _bioController.text = user.bio ?? '';
    _selectedCareerPath = user.careerPath;
    _skills.addAll(user.skills);
    _interests.addAll(user.interests);
    _isInitialized = true;
  }

  void _saveProfile(UserModel currentUser) {
    final updatedUser = currentUser.copyWith(
      name: _nameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      university: _univController.text,
      major: _majorController.text,
      graduationYear: _gradYearController.text,
      bio: _bioController.text,
      careerPath: _selectedCareerPath,
      skills: _skills,
      interests: _interests,
    );

    context.read<AuthBloc>().add(UserUpdateRequested(updatedUser));
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Profile updated successfully!'),
        backgroundColor: AppColors.successGreen,
      ),
    );
    context.pop();
  }

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
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        UserModel? currentUser;
        if (state is AuthAuthenticated) {
          currentUser = state.user;
          _initializeData(currentUser);
        }

        return PageScaffold(
          title: 'Edit Profile',
          actions: [
            TextButton(
              onPressed: currentUser != null ? () => _saveProfile(currentUser!) : null,
              child: const Text('Save',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryBlue)),
            ),
          ],
          body: SingleChildScrollView(
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
          ),
        );
      },
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
            isExpanded: true,
            value: (_selectedCareerPath != null && [
              'Software Engineer',
              'Full-Stack Developer',
              'Backend Developer',
              'Frontend Developer',
              'Mobile Developer',
              'Data Scientist',
              'AI / Machine Learning Engineer',
              'Cybersecurity Analyst',
              'Cloud Engineer',
              'DevOps Engineer',
              'UI/UX Designer',
              'Game Developer',
              'Embedded Systems Engineer',
              'Data Engineer',
              'Blockchain Developer',
              'Network Engineer'
            ].contains(_selectedCareerPath)) ? _selectedCareerPath : null,
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.background,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            items: [
              'Software Engineer',
              'Full-Stack Developer',
              'Backend Developer',
              'Frontend Developer',
              'Mobile Developer',
              'Data Scientist',
              'AI / Machine Learning Engineer',
              'Cybersecurity Analyst',
              'Cloud Engineer',
              'DevOps Engineer',
              'UI/UX Designer',
              'Game Developer',
              'Embedded Systems Engineer',
              'Data Engineer',
              'Blockchain Developer',
              'Network Engineer'
            ]
                .map((e) => DropdownMenuItem(
                      value: e,
                      child: Text(
                        e,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
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
            children: _skills
                .map((s) => SkillChip(
                      label: s,
                      isSelected: true,
                      onTap: () => setState(() => _skills.remove(s)),
                    ))
                .toList(),
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: _showAddSkillDialog,
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

  void _showAddSkillDialog() {
    final available = _allSkillsMaster.where((s) => !_skills.contains(s)).toList();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Skill'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: available.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(available[index]),
                onTap: () {
                  setState(() => _skills.add(available[index]));
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
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
            children: _interests
                .map((i) => SkillChip(
                      label: i,
                      isSelected: true,
                      onTap: () => setState(() => _interests.remove(i)),
                    ))
                .toList(),
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: _showAddInterestDialog,
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

  void _showAddInterestDialog() {
    final available = _allInterestsMaster.where((i) => !_interests.contains(i)).toList();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Interest'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: available.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(available[index]),
                onTap: () {
                  setState(() => _interests.add(available[index]));
                  Navigator.pop(context);
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
        ],
      ),
    );
  }
}
