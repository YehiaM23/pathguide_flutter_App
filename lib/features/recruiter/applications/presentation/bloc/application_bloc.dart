import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pathguide_app/core/data/models.dart';
import 'application_event.dart';
import 'application_state.dart';

class ApplicationBloc extends Bloc<ApplicationEvent, ApplicationState> {
  ApplicationBloc() : super(ApplicationInitial()) {
    on<LoadApplications>(_onLoadApplications);
    on<UpdateApplicationStatus>(_onUpdateApplicationStatus);
  }

  void _onLoadApplications(LoadApplications event, Emitter<ApplicationState> emit) {
    emit(ApplicationLoading());
    // Mock data for initial applications
    final List<ApplicationModel> mockApplications = [
      ApplicationModel(
        id: '1',
        internshipId: 'int_1',
        studentId: 'std_1',
        status: 'Pending',
        appliedDate: '10/05/2026',
      ),
      ApplicationModel(
        id: '2',
        internshipId: 'int_1',
        studentId: 'std_2',
        status: 'Pending',
        appliedDate: '11/05/2026',
      ),
      ApplicationModel(
        id: '3',
        internshipId: 'int_2',
        studentId: 'std_3',
        status: 'Accepted',
        appliedDate: '05/05/2026',
      ),
    ];
    emit(ApplicationLoaded(applications: mockApplications));
  }

  void _onUpdateApplicationStatus(UpdateApplicationStatus event, Emitter<ApplicationState> emit) {
    if (state is ApplicationLoaded) {
      final currentApplications = (state as ApplicationLoaded).applications;
      final updatedApplications = currentApplications.map((app) {
        if (app.id == event.applicationId) {
          return ApplicationModel(
            id: app.id,
            internshipId: app.internshipId,
            studentId: app.studentId,
            status: event.status,
            appliedDate: app.appliedDate,
            feedback: event.feedback ?? app.feedback,
            rating: event.rating ?? app.rating,
            completionDate: event.status == 'Completed' ? DateTime.now().toString() : app.completionDate,
          );
        }
        return app;
      }).toList();
      emit(ApplicationLoaded(applications: updatedApplications));
    }
  }
}
