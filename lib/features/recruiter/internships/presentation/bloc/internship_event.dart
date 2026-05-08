part of 'internship_bloc.dart';

abstract class InternshipEvent extends Equatable {
  const InternshipEvent();

  @override
  List<Object?> get props => [];
}

class LoadMyInternships extends InternshipEvent {}

class AddInternship extends InternshipEvent {
  final InternshipModel internship;
  const AddInternship(this.internship);

  @override
  List<Object?> get props => [internship];
}
