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
  bool? _hasSpecificPath;
  String? _selectedCareerPath;

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

  final List<String> _allCareers = [
    'Software Engineer', 'Full-Stack Developer', 'Backend Developer', 
    'Frontend Developer', 'Mobile Developer', 'Data Scientist', 
    'AI / Machine Learning Engineer', 'Cybersecurity Analyst', 
    'Cloud Engineer', 'DevOps Engineer', 'UI/UX Designer', 
    'Game Developer', 'Embedded Systems Engineer', 'Data Engineer',
    'Blockchain Developer', 'Network Engineer'
  ];

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: 'Create Account',
      body: Column(
        children: [
          _buildStepIndicator(),
          const SizedBox(height: 40),
          _buildCurrentStep(),
        ],
      ),
    );
  }

  Widget _buildCurrentStep() {
    if (_currentStep == 0) return _buildStep1();
    if (_currentStep == 1) return _buildStep2();
    return _buildStep3();
  }

  Widget _buildStepIndicator() {
    return Row(
      children: [
        Expanded(child: _indicatorItem(1, 'Account', _currentStep >= 0)),
        _indicatorLine(_currentStep >= 1),
        Expanded(child: _indicatorItem(2, 'Profile', _currentStep >= 1)),
        if (_selectedRole == 'Candidate') ...[
          _indicatorLine(_currentStep >= 2),
          Expanded(child: _indicatorItem(3, 'Career', _currentStep >= 2)),
        ],
      ],
    );
  }

  Widget _indicatorLine(bool isActive) {
    return Container(
      width: 30, 
      height: 2, 
      margin: const EdgeInsets.symmetric(horizontal: 4),
      color: isActive ? AppColors.primaryBlue : AppColors.cardBorder
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
              label: 'Phone Number',
              hint: '+20 123 456 7890',
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              prefixIcon: Icons.phone_outlined,
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
                        text: _selectedRole == 'Candidate' ? 'Next' : 'Finish Setup',
                        isLoading: state is AuthLoading,
                        onPressed: () {
                          if (_formKey2.currentState!.validate()) {
                            if (_selectedRole == 'Candidate') {
                              setState(() => _currentStep = 2);
                            } else {
                              context.read<AuthBloc>().add(RegisterRequested(
                                name: _nameController.text,
                                email: _emailController.text,
                                password: _passwordController.text,
                                role: UserRole.recruiter,
                                phone: _phoneController.text,
                                companyName: _companyNameController.text,
                                companyWebsite: _companyWebsiteController.text,
                                companyIndustry: _companyIndustryController.text,
                                companyLocation: _companyLocationController.text,
                                companyDescription: _companyDescriptionController.text,
                              ));
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

  Widget _buildStep3() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Career Direction',
            subtitle: 'Let\'s define your professional path',
          ),
          const SizedBox(height: 32),
          const Text(
            'Do you have a specific career path in mind?',
            style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.darkNavy, fontSize: 16),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _choiceOption('Yes', _hasSpecificPath == true, () => setState(() => _hasSpecificPath = true)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _choiceOption('No, Recommend', _hasSpecificPath == false, () => setState(() => _hasSpecificPath = false)),
              ),
            ],
          ),
          if (_hasSpecificPath == true) ...[
            const SizedBox(height: 32),
            _buildDropdown('Desired Career Path', 'Select Path', _allCareers, (v) => setState(() => _selectedCareerPath = v)),
          ],
          if (_hasSpecificPath == false) ...[
            const SizedBox(height: 32),
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
                  const Row(
                    children: [
                      Icon(Icons.auto_awesome, color: AppColors.primaryBlue, size: 20),
                      SizedBox(width: 8),
                      Text('System Recommendation', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryBlue)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Based on your skills and interests, we recommend focusing on:',
                    style: TextStyle(fontSize: 14, color: AppColors.darkNavy),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _getRecommendedPath(),
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppColors.primaryBlue),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 48),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => setState(() => _currentStep = 1),
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
                      onPressed: (_hasSpecificPath == null || (_hasSpecificPath == true && _selectedCareerPath == null)) 
                          ? null 
                          : () {
                        context.read<AuthBloc>().add(RegisterRequested(
                          name: _nameController.text,
                          email: _emailController.text,
                          password: _passwordController.text,
                          role: UserRole.student,
                          phone: _phoneController.text,
                          university: _selectedUniversity,
                          major: _selectedMajor,
                          graduationYear: _gradYearController.text,
                          careerPath: _hasSpecificPath == true ? _selectedCareerPath : _getRecommendedPath(),
                          skills: _selectedSkills,
                          interests: _selectedInterests,
                        ));
                        context.go('/student/dashboard');
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getRecommendedPath() {
    if (_selectedSkills.contains('Flutter') || _selectedSkills.contains('React Native')) {
      return 'Mobile Developer';
    } else if (_selectedSkills.contains('Python') || _selectedInterests.contains('AI & Machine Learning')) {
      return 'Data Scientist';
    } else if (_selectedSkills.contains('Figma') || _selectedSkills.contains('Adobe XD')) {
      return 'UI/UX Designer';
    }
    return 'Full-Stack Developer';
  }

  Widget _choiceOption(String text, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryBlue : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? AppColors.primaryBlue : AppColors.cardBorder),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.mutedText,
              fontWeight: FontWeight.bold,
            ),
          ),
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


}


