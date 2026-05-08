import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:pathguide_app/core/theme/app_colors.dart';
import 'package:pathguide_app/core/widgets/reusable_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pathguide_app/core/data/models.dart';
import 'package:pathguide_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pathguide_app/features/recruiter/internships/presentation/bloc/internship_bloc.dart';
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
  final _otherSkillController = TextEditingController();
  final _descriptionController = TextEditingController();

  List<String> _selectedSkills = [];
  final List<String> _skillMasterList = [
    'Flutter', 'React Native', 'Java', 'Python', 'Node.js', 
    'UI/UX Design', 'Figma', 'Marketing', 'Sales', 'Graphic Design',
    'Others'
  ];

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryBlue,
              onPrimary: Colors.white,
              onSurface: AppColors.darkNavy,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        controller.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  void _showSkillsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Select Required Skills', style: TextStyle(color: AppColors.darkNavy, fontWeight: FontWeight.bold)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _skillMasterList.length,
                        itemBuilder: (context, index) {
                          final skill = _skillMasterList[index];
                          final isSelected = _selectedSkills.contains(skill);
                          return CheckboxListTile(
                            title: Text(skill),
                            value: isSelected,
                            activeColor: AppColors.primaryBlue,
                            onChanged: (bool? value) {
                              setDialogState(() {
                                if (value == true) {
                                  _selectedSkills.add(skill);
                                } else {
                                  _selectedSkills.remove(skill);
                                }
                              });
                              setState(() {}); // Update main UI
                            },
                          );
                        },
                      ),
                    ),
                    if (_selectedSkills.contains('Others')) ...[
                      const SizedBox(height: 12),
                      AppTextField(
                        label: 'Enter Custom Skills',
                        hint: 'e.g. Kotlin, Swift',
                        controller: _otherSkillController,
                        onChanged: (v) => setState(() {}),
                      ),
                    ]
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Done', style: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold)),
                ),
              ],
            );
          }
        );
      },
    );
  }

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
                            suffixIcon: Icons.calendar_today_outlined,
                            readOnly: true,
                            onTap: () => _selectDate(context, _startDateController),
                            validator: (v) => v!.isEmpty ? 'Required' : null,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: AppTextField(
                            label: 'Deadline',
                            hint: 'DD/MM/YYYY',
                            controller: _deadlineController,
                            suffixIcon: Icons.calendar_today_outlined,
                            readOnly: true,
                            onTap: () => _selectDate(context, _deadlineController),
                            validator: (v) => v!.isEmpty ? 'Required' : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text('Required Skills', style: TextStyle(color: AppColors.mutedText, fontSize: 14)),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: _showSkillsDialog,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.cardBorder),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                _selectedSkills.isEmpty 
                                    ? 'Select skills...' 
                                    : _selectedSkills.join(', ') + (_selectedSkills.contains('Others') && _otherSkillController.text.isNotEmpty ? ': ${_otherSkillController.text}' : ''),
                                style: TextStyle(
                                  color: _selectedSkills.isEmpty ? AppColors.mutedText : AppColors.darkNavy,
                                  fontSize: 14,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const Icon(Icons.add_circle_outline, color: AppColors.primaryBlue, size: 20),
                          ],
                        ),
                      ),
                    ),
                    if (_selectedSkills.isEmpty)
                      const Padding(
                        padding: EdgeInsets.only(top: 8, left: 4),
                        child: Text('Please select at least one skill', style: TextStyle(color: Colors.red, fontSize: 12)),
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
                  if (_formKey.currentState!.validate() && _selectedSkills.isNotEmpty) {
                    final authState = context.read<AuthBloc>().state;
                    String companyName = 'Company';
                    if (authState is AuthAuthenticated) {
                      companyName = authState.user.companyName ?? authState.user.name;
                    }

                    String skillsText = _selectedSkills.join(', ');
                    if (_selectedSkills.contains('Others') && _otherSkillController.text.isNotEmpty) {
                      skillsText = skillsText.replaceFirst('Others', _otherSkillController.text);
                    }

                    final newInternship = InternshipModel(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      title: _titleController.text,
                      company: companyName,
                      description: _descriptionController.text,
                      location: _locationController.text,
                      duration: _durationController.text,
                      stipend: _stipendController.text,
                      startDate: _startDateController.text,
                      deadline: _deadlineController.text,
                      requiredSkill: skillsText,
                    );

                    context.read<InternshipBloc>().add(AddInternship(newInternship));
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
                Navigator.of(context).pop(); // Close dialog
                context.go('/recruiter/dashboard'); // Use go to return safely
              },
            ),
          ],
        ),
      ),
    );
  }
}
