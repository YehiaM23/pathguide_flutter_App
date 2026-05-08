import 'package:equatable/equatable.dart';
import 'package:pathguide_app/core/data/models.dart';

abstract class ApplicationEvent extends Equatable {
  const ApplicationEvent();

  @override
  List<Object?> get props => [];
}

class LoadApplications extends ApplicationEvent {}

class UpdateApplicationStatus extends ApplicationEvent {
  final String applicationId;
  final String status;
  final String? feedback;
  final double? rating;

  const UpdateApplicationStatus({
    required this.applicationId,
    required this.status,
    this.feedback,
    this.rating,
  });

  @override
  List<Object?> get props => [applicationId, status, feedback, rating];
}
