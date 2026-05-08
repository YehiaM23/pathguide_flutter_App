import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pathguide_app/core/theme/app_colors.dart';
import 'package:pathguide_app/core/widgets/reusable_widgets.dart';
import 'package:pathguide_app/core/data/models.dart';
import 'package:pathguide_app/features/recruiter/dashboard/presentation/widgets/recruiter_dashboard_scaffold.dart';
import 'package:pathguide_app/features/recruiter/internships/presentation/bloc/internship_bloc.dart';

class MyInternshipsPage extends StatefulWidget {
  const MyInternshipsPage({super.key});

  @override
  State<MyInternshipsPage> createState() => _MyInternshipsPageState();
}

class _MyInternshipsPageState extends State<MyInternshipsPage> {
  @override
  void initState() {
    super.initState();
    // نطلب البيانات مرة واحدة فقط عند تشغيل الصفحة لأول مرة
    context.read<InternshipBloc>().add(LoadMyInternships());
  }

  @override
  Widget build(BuildContext context) {
    return RecruiterDashboardScaffold(
      title: 'My Internships',
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: const SectionHeader(
              title: 'Posted Opportunities',
              subtitle: 'Track and manage your internship listings.',
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: BlocBuilder<InternshipBloc, InternshipState>(
              builder: (context, state) {
                if (state is InternshipLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is InternshipLoaded) {
                  if (state.myInternships.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.work_off_outlined, size: 64, color: AppColors.mutedText.withValues(alpha: 0.5)),
                          const SizedBox(height: 16),
                          const Text('No internships posted yet.', style: TextStyle(color: AppColors.mutedText)),
                        ],
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: state.myInternships.length,
                    itemBuilder: (context, index) {
                      final internship = state.myInternships[index];
                      return _buildInternshipCard(context, internship);
                    },
                  );
                } else if (state is InternshipError) {
                  return Center(child: Text(state.message));
                }
                return const Center(child: Text('Something went wrong.'));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInternshipCard(BuildContext context, InternshipModel internship) {
    return AppCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  internship.title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.darkNavy),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              StatusBadge(
                label: internship.isActive ? 'Active' : 'Closed', 
                color: internship.isActive ? AppColors.successGreen : AppColors.mutedText
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            internship.company,
            style: const TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.location_on_outlined, size: 16, color: AppColors.mutedText),
              const SizedBox(width: 4),
              Text(internship.location, style: const TextStyle(color: AppColors.mutedText, fontSize: 13)),
              const SizedBox(width: 16),
              const Icon(Icons.people_outline, size: 16, color: AppColors.mutedText),
              const SizedBox(width: 4),
              const Text('0 Applicants', style: TextStyle(color: AppColors.mutedText, fontSize: 13)),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryBlue,
                    side: const BorderSide(color: AppColors.primaryBlue),
                    minimumSize: const Size(0, 44),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Edit'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: GradientButton(
                  text: 'View Applicants',
                  onPressed: () => context.push('/recruiter/applications'),
                  height: 44,
                ),
              ),
            ],
          ),
        ],
      ),
    ).withMargin(const EdgeInsets.only(bottom: 16));
  }
}
