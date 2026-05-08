import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pathguide_app/core/data/models.dart';
import 'package:pathguide_app/core/theme/app_colors.dart';
import 'package:pathguide_app/core/widgets/reusable_widgets.dart';
import 'package:pathguide_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pathguide_app/features/recruiter/dashboard/presentation/widgets/recruiter_dashboard_scaffold.dart';

class RecruiterProfilePage extends StatefulWidget {
  const RecruiterProfilePage({super.key});

  @override
  State<RecruiterProfilePage> createState() => _RecruiterProfilePageState();
}

class _RecruiterProfilePageState extends State<RecruiterProfilePage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _companyNameController = TextEditingController();
  final _websiteController = TextEditingController();
  final _industryController = TextEditingController();
  final _locationController = TextEditingController();
  final _bioController = TextEditingController();

  bool _isInitialized = false;

  void _initializeData(UserModel user) {
    if (_isInitialized) return;
    _nameController.text = user.name;
    _emailController.text = user.email;
    _phoneController.text = user.phone ?? '';
    _companyNameController.text = user.companyName ?? user.name;
    _websiteController.text = user.companyWebsite ?? '';
    _industryController.text = user.companyIndustry ?? '';
    _locationController.text = user.companyLocation ?? '';
    _bioController.text = user.bio ?? '';
    _isInitialized = true;
  }

  void _saveProfile(UserModel currentUser) {
    final updatedUser = currentUser.copyWith(
      name: _nameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      companyName: _companyNameController.text,
      companyWebsite: _websiteController.text,
      companyIndustry: _industryController.text,
      companyLocation: _locationController.text,
      bio: _bioController.text,
    );

    context.read<AuthBloc>().add(UserUpdateRequested(updatedUser));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Company profile updated successfully!'),
        backgroundColor: AppColors.successGreen,
      ),
    );
    context.pop();
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

        return RecruiterDashboardScaffold(
          title: 'Edit Profile',
          actions: [
            TextButton(
              onPressed: currentUser != null ? () => _saveProfile(currentUser!) : null,
              child: const Text(
                'Save',
                style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryBlue),
              ),
            ),
          ],
          body: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeaderSection(currentUser),
                const SizedBox(height: 24),
                _buildDetailsSection(),
                const SizedBox(height: 40),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeaderSection(UserModel? user) {
    return AppCard(
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              gradient: AppColors.mainGradient,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(Icons.business_rounded, color: Colors.white, size: 40),
          ),
          const SizedBox(height: 20),
          AppTextField(
            label: 'Company Name',
            hint: 'Enter company name',
            controller: _companyNameController,
          ),
          const SizedBox(height: 16),
          AppTextField(
            label: 'Work Email',
            hint: 'Enter work email',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 12),
          const StatusBadge(label: 'Verified Company', color: AppColors.successGreen),
        ],
      ),
    );
  }

  Widget _buildDetailsSection() {
    return AppCard(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Company Details'),
          const SizedBox(height: 24),
          AppTextField(
            label: 'Headquarters',
            hint: 'Smart Village, Giza',
            controller: _locationController,
            prefixIcon: Icons.location_on_rounded,
          ),
          const SizedBox(height: 20),
          AppTextField(
            label: 'Website',
            hint: 'www.company.com',
            controller: _websiteController,
            prefixIcon: Icons.language_rounded,
          ),
          const SizedBox(height: 20),
          AppTextField(
            label: 'Industry',
            hint: 'Telecommunications & IT',
            controller: _industryController,
            prefixIcon: Icons.info_outline,
          ),
          const SizedBox(height: 20),
          AppTextField(
            label: 'Phone',
            hint: 'Enter phone number',
            controller: _phoneController,
            prefixIcon: Icons.phone_outlined,
          ),
          const SizedBox(height: 20),
          AppTextField(
            label: 'About Company',
            hint: 'Tell us about your company mission...',
            controller: _bioController,
            maxLines: 4,
          ),
        ],
      ),
    );
  }
}
