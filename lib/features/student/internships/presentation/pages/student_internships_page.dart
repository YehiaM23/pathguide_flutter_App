import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pathguide_app/core/theme/app_colors.dart';
import 'package:pathguide_app/core/widgets/reusable_widgets.dart';
import 'package:pathguide_app/core/data/models.dart';

class StudentInternshipsPage extends StatefulWidget {
  const StudentInternshipsPage({super.key});

  @override
  State<StudentInternshipsPage> createState() => _StudentInternshipsPageState();
}

class _StudentInternshipsPageState extends State<StudentInternshipsPage> {
  final List<InternshipModel> _allInternships = [
    const InternshipModel(
      id: '1',
      title: 'mobile developer',
      company: 'Vois',
      description: 'mobile development internship',
      location: 'smart village',
      duration: '1 month',
      stipend: '5000 EGP',
      startDate: '05/01/2026',
      deadline: '30/01/2026',
      requiredSkill: 'Figma',
    ),
    const InternshipModel(
      id: '2',
      title: 'Embedded System',
      company: 'High Soft',
      description: 'Embedded System internship',
      location: 'cairo',
      duration: '3 months',
      stipend: '3000 EGP',
      startDate: '06/01/2026',
      deadline: '07/02/2026',
      requiredSkill: 'CSS',
    ),
    const InternshipModel(
      id: '3',
      title: 'smart tech',
      company: 'High Soft',
      description: 'smart tech internship',
      location: 'cairo',
      duration: '3 months',
      stipend: '2500 EGP',
      startDate: '10/01/2026',
      deadline: '20/02/2026',
      requiredSkill: 'MongoDB',
    ),
    const InternshipModel(
      id: '4',
      title: 'Software engineer',
      company: 'SmartH',
      description: 'Company for intern',
      location: 'Giza',
      duration: '6 months',
      stipend: 'Unpaid',
      startDate: '01/02/2026',
      deadline: '15/02/2026',
      requiredSkill: 'NumPy',
    ),
  ];

  List<InternshipModel> _filteredInternships = [];
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredInternships = _allInternships;
  }

  void _filterInternships(String query) {
    setState(() {
      _filteredInternships = _allInternships
          .where((i) =>
              i.title.toLowerCase().contains(query.toLowerCase()) ||
              i.company.toLowerCase().contains(query.toLowerCase()) ||
              i.requiredSkill.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: 'Explore Internships',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            title: 'Find Your Next Step',
            subtitle: 'Discover opportunities that match your skills and career goals.',
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _searchController,
            onChanged: _filterInternships,
            decoration: InputDecoration(
              hintText: 'Search by title, company, or skill...',
              prefixIcon: const Icon(Icons.search_rounded, color: AppColors.mutedText),
              suffixIcon: _searchController.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear_rounded),
                      onPressed: () {
                        _searchController.clear();
                        _filterInternships('');
                      },
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                'Showing ${_filteredInternships.length} opportunities',
                style: const TextStyle(color: AppColors.mutedText, fontSize: 13, fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.filter_list_rounded, size: 18),
                label: const Text('Filter'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ..._filteredInternships.map((internship) => _buildInternshipCard(internship)),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildInternshipCard(InternshipModel internship) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: AppCard(
        padding: const EdgeInsets.all(20),
        child: InkWell(
          onTap: () => context.push('/student/internship-details', extra: internship),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.business_rounded, color: AppColors.primaryBlue),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          internship.title,
                          style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: AppColors.darkNavy),
                        ),
                        Text(
                          internship.company,
                          style: const TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.bookmark_border_rounded, color: AppColors.cardBorder),
                ],
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 12,
                runSpacing: 8,
                children: [
                  _iconLabel(Icons.location_on_outlined, internship.location),
                  _iconLabel(Icons.access_time_rounded, internship.duration),
                  _iconLabel(Icons.payments_outlined, internship.stipend),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 16),
              Row(
                children: [
                  SkillChip(label: internship.requiredSkill, isSelected: true),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('Deadline', style: TextStyle(color: AppColors.mutedText, fontSize: 10)),
                      Text(
                        internship.deadline,
                        style: const TextStyle(color: AppColors.dangerRed, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _iconLabel(IconData icon, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: AppColors.mutedText),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(color: AppColors.mutedText, fontSize: 12)),
      ],
    );
  }
}



