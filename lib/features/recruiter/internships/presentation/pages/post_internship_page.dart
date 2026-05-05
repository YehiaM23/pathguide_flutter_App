import 'package:flutter/material.dart';
import 'package:pathguide_app/core/theme/app_colors.dart';
import 'package:pathguide_app/core/widgets/reusable_widgets.dart';
import 'package:pathguide_app/features/recruiter/dashboard/presentation/widgets/recruiter_dashboard_scaffold.dart';

class PostInternshipPage extends StatefulWidget {
  const PostInternshipPage({super.key});

  @override
  State<PostInternshipPage> createState() => _PostInternshipPageState();
}

class _PostInternshipPageState extends State<PostInternshipPage> {
  final _formKey = GlobalKey<FormState>();
  
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _durationController = TextEditingController();
  final _stipendController = TextEditingController();
  final _startDateController = TextEditingController();
  final _deadlineController = TextEditingController();
  final _skillController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return RecruiterDashboardScaffold(
      title: 'Post Internship',
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionHeader(
                title: 'Create Opportunity',
                subtitle: 'Fill in the details to reach potential candidates.',
              ),
              const SizedBox(height: 32),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Basic Information',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.darkNavy),
                    ),
                    const SizedBox(height: 20),
                    AppTextField(
                      label: 'Internship Title',
                      hint: 'e.g. Flutter Developer Intern',
                      controller: _titleController,
                      validator: (v) => v!.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      label: 'Location',
                      hint: 'e.g. Remote, Cairo, Egypt',
                      controller: _locationController,
                      validator: (v) => v!.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: AppTextField(
                            label: 'Duration',
                            hint: 'e.g. 3 Months',
                            controller: _durationController,
                            validator: (v) => v!.isEmpty ? 'Required' : null,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: AppTextField(
                            label: 'Stipend',
                            hint: 'e.g. 5000 EGP',
                            controller: _stipendController,
                            validator: (v) => v!.isEmpty ? 'Required' : null,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Timeline & Skills',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.darkNavy),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: AppTextField(
                            label: 'Start Date',
                            hint: 'DD/MM/YYYY',
                            controller: _startDateController,
                            validator: (v) => v!.isEmpty ? 'Required' : null,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: AppTextField(
                            label: 'Deadline',
                            hint: 'DD/MM/YYYY',
                            controller: _deadlineController,
                            validator: (v) => v!.isEmpty ? 'Required' : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    AppTextField(
                      label: 'Required Main Skill',
                      hint: 'e.g. Flutter, Figma, Java',
                      controller: _skillController,
                      validator: (v) => v!.isEmpty ? 'Required' : null,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Detailed Description',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.darkNavy),
                    ),
                    const SizedBox(height: 20),
                    AppTextField(
                      label: 'Description',
                      hint: 'Describe the roles and responsibilities...',
                      controller: _descriptionController,
                      maxLines: 5,
                      validator: (v) => v!.isEmpty ? 'Required' : null,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              GradientButton(
                text: 'Publish Internship',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _showSuccessDialog();
                  }
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }


  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle_outline, color: AppColors.successGreen, size: 80),
            const SizedBox(height: 24),
            const Text(
              'Internship Posted!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Your internship has been successfully posted and is now visible to students.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.mutedText),
            ),
            const SizedBox(height: 32),
            GradientButton(
              text: 'Done',
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Back to dashboard
              },
            ),
          ],
        ),
      ),
    );
  }
}
