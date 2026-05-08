import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pathguide_app/core/theme/app_colors.dart';
import 'package:pathguide_app/core/widgets/reusable_widgets.dart';
import 'package:pathguide_app/core/data/models.dart';
import '../bloc/auth_bloc.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  int _currentStep = 0;
  String _selectedRole = 'Candidate'; // Candidate or Recruiter
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  // Controllers Step 1
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  
  // Student Specific
  String? _selectedUniversity;
  String? _selectedMajor;
  final _gradYearController = TextEditingController();

  // Recruiter Specific
  final _companyNameController = TextEditingController();
  final _companyWebsiteController = TextEditingController();
  final _companyIndustryController = TextEditingController();
  final _companyLocationController = TextEditingController();
  final _companyDescriptionController = TextEditingController();

  final List<String> _skills = [
    'Adobe XD', 'Angular', 'AWS', 'CSS', 'Docker', 'Excel', 'Express', 'Figma',
    'Flutter', 'Git', 'HTML', 'Java', 'JavaScript', 'JUnit', 'Kotlin', 'Kubernetes',
    'MongoDB', 'NumPy', 'Pandas', 'PostgreSQL', 'Power BI', 'Python', 'PyTorch',
    'R', 'React', 'React Native', 'REST APIs', 'Sass', 'Selenium', 'SQL', 'Swift',
    'Tableau', 'TensorFlow', 'TestNG', 'TypeScript', 'Vue.js'
  ];

  final List<String> _selectedSkills = [];

  final List<String> _interests = [
    'AI & Machine Learning', 'Anime', 'Audiobooks', 'Basketball', 'Beach', 'Blogging',
    'Building Apps', 'Business Strategy', 'Camping', 'Coffee', 'Community Service',
    'Content Creation', 'Cooking', 'Cycling', 'Digital Art', 'Drawing', 'Entrepreneurship',
    'Fashion', 'Football', 'Freelancing', 'Gadgets', 'Gaming', 'Graphic Design',
    'Gym & Fitness', 'Hiking', 'Investing', 'Leadership', 'Learning Languages',
    'Marketing', 'Martial Arts', 'Mentoring', 'Movies', 'Music', 'Music Concerts',
    'Nature', 'Networking', 'Online Courses', 'Open Source', 'Personal Finance',
    'Photography', 'Playing Instruments', 'Podcasts', 'Programming', 'Public Speaking',
    'Reading', 'Road Trips', 'Running', 'Self Improvement', 'Stand-up Comedy',
    'Startups', 'Swimming', 'Teaching', 'Tech News', 'Theatre', 'Traveling',
    'TV Series', 'Video Editing', 'Volunteering', 'Writing', 'Yoga'
  ];

  final List<String> _selectedInterests = [];

  final List<String> _egyptianUniversities = [
    'Cairo University','Nile University', 'Ain Shams University', 'Alexandria University', 
    'Mansoura University', 'Helwan University', 'Assiut University', 
    'Tanta University', 'Zagazig University', 'Suez Canal University', 
    'Menoufia University', 'Benha University', 'Minia University', 
    'Fayoum University', 'Beni-Suef University', 'Sohag University', 
    'South Valley University', 'Aswan University', 'Port Said University', 
    'Damietta University', 'Suez University', 'Damanhour University', 
    'Kafr El-Sheikh University', 'Matrouh University', 'New Valley University', 
    'Al-Azhar University','American University in Cairo (AUC)', 
    'German University in Cairo (GUC)', 'British University in Egypt (BUE)', 
    'Arab Academy for Science, Technology and Maritime Transport (AASTMT)',
    'Misr International University (MIU)', 'Future University in Egypt (FUE)',
    'Misr University for Science and Technology (MUST)', 'Modern Sciences and Arts University (MSA)',
    'October 6 University', 'Galala University', 'AlAlamein International University',
    'New Mansoura University', 'King Salman International University'
  ];

  final List<String> _csMajors = [
    'Computer Science', 'AI', 'Biotechnology', 
    'Software Engineering', 'Information Technology', 'Information Systems', 
    'Cybersecurity', 'Data Science', 'Computer Engineering'
  ];

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: 'Create Account',
      body: Column(
        children: [
          _buildStepIndicator(),
          const SizedBox(height: 40),
          _currentStep == 0 ? _buildStep1() : _buildStep2(),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Row(
      children: [
        Expanded(child: _indicatorItem(1, 'Account', _currentStep >= 0)),
        Container(width: 40, height: 2, color: _currentStep >= 1 ? AppColors.primaryBlue : AppColors.cardBorder),
        Expanded(child: _indicatorItem(2, 'Profile', _currentStep >= 1)),
      ],
    );
  }

  Widget _indicatorItem(int step, String label, bool isActive) {
    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: isActive ? AppColors.primaryBlue : Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: isActive ? AppColors.primaryBlue : AppColors.cardBorder, width: 2),
            boxShadow: isActive ? [
              BoxShadow(
                color: AppColors.primaryBlue.withValues(alpha: 0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              )
            ] : null,
          ),
          child: Center(
            child: Text(
              '$step',
              style: TextStyle(
                color: isActive ? Colors.white : AppColors.mutedText,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: isActive ? AppColors.darkNavy : AppColors.mutedText,
            fontSize: 13,
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildStep1() {
    return Form(
      key: _formKey1,
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(
              title: 'Who are you?',
              subtitle: 'Select your role to get started',
            ),
            const SizedBox(height: 24),
            _buildRoleSelector(),
            const SizedBox(height: 32),
            const Text(
              'Personal Information',
              style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.darkNavy, fontSize: 16),
            ),
            const SizedBox(height: 16),
            AppTextField(
              label: 'Full Name',
              hint: 'your name',
              controller: _nameController,
              prefixIcon: Icons.person_outline,
              validator: (v) => v!.isEmpty ? 'Please enter your name' : null,
            ),
            const SizedBox(height: 20),
            AppTextField(
              label: 'Email Address',
              hint: 'name@example.com',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              prefixIcon: Icons.email_outlined,
              validator: (v) => v!.contains('@') ? null : 'Invalid email address',
            ),
            const SizedBox(height: 20),
            AppTextField(
              label: 'Password',
              hint: 'Create a password',
              controller: _passwordController,
              isPassword: true,
              prefixIcon: Icons.lock_outline,
              validator: (v) => v!.length < 6 ? 'Password must be at least 6 characters' : null,
            ),
            const SizedBox(height: 32),
            if (_selectedRole == 'Candidate') ...[
              const Text(
                'Education',
                style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.darkNavy, fontSize: 16),
              ),
              const SizedBox(height: 16),
              _buildDropdown('University', 'Select University', _egyptianUniversities, (v) => setState(() => _selectedUniversity = v)),
              const SizedBox(height: 20),
              _buildDropdown('Major', 'Select Major', _csMajors, (v) => setState(() => _selectedMajor = v)),
              const SizedBox(height: 20),
              AppTextField(
                label: 'Graduation Year',
                hint: '2025',
                controller: _gradYearController,
                keyboardType: TextInputType.number,
                prefixIcon: Icons.calendar_today_outlined,
              ),
            ] else ...[
              const Text(
                'Company Info',
                style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.darkNavy, fontSize: 16),
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: 'Company Name',
                hint: 'e.g. Tech Solutions Inc.',
                controller: _companyNameController,
                prefixIcon: Icons.business_outlined,
              ),
            ],
            const SizedBox(height: 40),
            GradientButton(
              text: 'Continue',
              onPressed: () {
                if (_formKey1.currentState!.validate()) {
                  setState(() => _currentStep = 1);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleSelector() {
    return Row(
      children: [
        Expanded(child: _roleOption('Candidate', Icons.person_search_outlined)),
        const SizedBox(width: 16),
        Expanded(child: _roleOption('Recruiter', Icons.business_center_outlined)),
      ],
    );
  }

  Widget _roleOption(String role, IconData icon) {
    bool isSelected = _selectedRole == role;
    return GestureDetector(
      onTap: () => setState(() => _selectedRole = role),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryBlue.withValues(alpha: 0.05) : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? AppColors.primaryBlue : AppColors.cardBorder, 
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? AppColors.primaryBlue : AppColors.mutedText, size: 28),
            const SizedBox(height: 8),
            Text(
              role,
              style: TextStyle(
                color: isSelected ? AppColors.primaryBlue : AppColors.mutedText,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, String hint, List<String> items, Function(String?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: AppColors.darkNavy)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          isExpanded: true,
          decoration: InputDecoration(
            hintText: hint,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          items: items.map((e) => DropdownMenuItem(
            value: e, 
            child: Text(
              e,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            )
          )).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildStep2() {
    return Form(
      key: _formKey2,
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: 'Professional Profile',
              subtitle: _selectedRole == 'Candidate' 
                  ? 'Tell us more about your skills and interests'
                  : 'Tell us more about your company',
            ),
            const SizedBox(height: 32),
            const Text(
              'Online Presence',
              style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.darkNavy, fontSize: 16),
            ),
            const SizedBox(height: 16),
            const AppTextField(
              label: 'LinkedIn Profile', 
              hint: 'https://linkedin.com/in/username',
              prefixIcon: Icons.link,
            ),
            const SizedBox(height: 20),
            if (_selectedRole == 'Candidate') ...[
              const AppTextField(
                label: 'GitHub Profile', 
                hint: 'https://github.com/username',
                prefixIcon: Icons.code,
              ),
              const SizedBox(height: 32),
              _buildChipSection('Technical Skills', 'Select your top skills', _skills, _selectedSkills),
              const SizedBox(height: 32),
              _buildChipSection('Interests', 'What drives you?', _interests, _selectedInterests),
            ] else ...[
              AppTextField(
                label: 'Company Website', 
                hint: 'https://www.company.com',
                controller: _companyWebsiteController,
                prefixIcon: Icons.language,
              ),
              const SizedBox(height: 32),
              const Text(
                'Business Details',
                style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.darkNavy, fontSize: 16),
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: 'Industry',
                hint: 'e.g. Software Development',
                controller: _companyIndustryController,
              ),
              const SizedBox(height: 20),
              AppTextField(
                label: 'HQ Location',
                hint: 'e.g. Cairo, Egypt',
                controller: _companyLocationController,
                prefixIcon: Icons.location_on_outlined,
              ),
              const SizedBox(height: 20),
              AppTextField(
                label: 'Company Bio',
                hint: 'Describe your company culture and mission...',
                controller: _companyDescriptionController,
                maxLines: 4,
              ),
            ],

            const SizedBox(height: 48),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => setState(() => _currentStep = 0),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Back'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return GradientButton(
                        text: 'Finish Setup',
                        isLoading: state is AuthLoading,
                        onPressed: () {
                          if (_formKey2.currentState!.validate()) {
                            final role = _selectedRole == 'Candidate' ? UserRole.student : UserRole.recruiter;
                            context.read<AuthBloc>().add(RegisterRequested(
                              name: _nameController.text,
                              email: _emailController.text,
                              password: _passwordController.text,
                              role: role,
                            ));
                            
                            if (role == UserRole.student) {
                              _showCareerPathDialog();
                            } else {
                              context.go('/recruiter/dashboard');
                            }
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChipSection(String title, String subtitle, List<String> items, List<String> selectedList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.darkNavy, fontSize: 16)),
        Text(subtitle, style: const TextStyle(color: AppColors.mutedText, fontSize: 13)),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 10,
          children: items.map((item) => SkillChip(
            label: item,
            isSelected: selectedList.contains(item),
            onTap: () {
              setState(() {
                if (selectedList.contains(item)) {
                  selectedList.remove(item);
                } else {
                  selectedList.add(item);
                }
              });
            },
          )).toList(),
        ),
      ],
    );
  }

  void _showCareerPathDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Ready to Start?'),
        content: const Text('Would you like us to recommend a personalized career path based on your skills?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showSelectionDialog('Choose Your Path', false);
            },
            child: const Text('I\'ll Choose'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showSelectionDialog('Recommended for You', true);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Yes, Recommend'),
          ),
        ],
      ),
    );
  }

  void _showSelectionDialog(String title, bool isRecommended) {
    final paths = [
      'Full-Stack Developer', 'Mobile Developer', 'Data Scientist', 
      'AI / Machine Learning Engineer', 'Backend Developer', 
      'Frontend Developer', 'UI/UX Designer', 'DevOps Engineer'
    ];
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(title),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.separated(
            shrinkWrap: true,
            itemCount: paths.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) => ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(paths[index], style: const TextStyle(fontWeight: FontWeight.w500)),
              trailing: isRecommended && index < 2 ? const StatusBadge(label: '98% Match', color: AppColors.successGreen) : const Icon(Icons.chevron_right, size: 20),
              onTap: () => context.go('/student/dashboard'),
            ),
          ),
        ),
      ),
    );
  }
}


