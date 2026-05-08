import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pathguide_app/core/data/models.dart';

part 'internship_event.dart';
part 'internship_state.dart';

class InternshipBloc extends Bloc<InternshipEvent, InternshipState> {
  // Simulating a database with a static list for now
  static final List<InternshipModel> _dummyInternships = [
    const InternshipModel(
      id: 'int_1',
      title: 'Mobile Developer',
      company: 'Vois',
      description: 'Mobile development internship',
      location: 'Smart Village',
      duration: '1 month',
      stipend: '5000 EGP',
      startDate: '05/01/2026',
      deadline: '30/01/2026',
      requiredSkill: 'Flutter, Figma',
    ),
    const InternshipModel(
      id: 'int_2',
      title: 'Embedded Systems',
      company: 'Vois',
      description: 'Embedded Systems internship',
      location: 'Cairo',
      duration: '3 months',
      stipend: '3000 EGP',
      startDate: '06/01/2026',
      deadline: '07/02/2026',
      requiredSkill: 'C, C++',
    ),
  ];

  InternshipBloc() : super(InternshipInitial()) {
    on<LoadMyInternships>((event, emit) {
      emit(InternshipLoading());
      emit(InternshipLoaded(List.from(_dummyInternships)));
    });

    on<AddInternship>((event, emit) {
      _dummyInternships.add(event.internship); // Persist in dummy memory
      
      final currentState = state;
      if (currentState is InternshipLoaded) {
        final updatedList = List<InternshipModel>.from(currentState.myInternships)..add(event.internship);
        emit(InternshipLoaded(updatedList));
      } else {
        // If not loaded yet, emit loaded with just the new one (or trigger a reload)
        emit(InternshipLoaded(List.from(_dummyInternships)));
      }
    });
  }
}
