import 'package:equatable/equatable.dart';

enum UserRole { student, recruiter }

class UserModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final UserRole role;
  final String? phone;
  final String? university;
  final String? major;
  final String? graduationYear;
  final String? careerPath;
  final String? bio;
  final List<String> skills;
  final List<String> interests;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.phone,
    this.university,
    this.major,
    this.graduationYear,
    this.careerPath,
    this.bio,
    this.skills = const [],
    this.interests = const [],
  });

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        role,
        phone,
        university,
        major,
        graduationYear,
        careerPath,
        bio,
        skills,
        interests,
      ];

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    UserRole? role,
    String? phone,
    String? university,
    String? major,
    String? graduationYear,
    String? careerPath,
    String? bio,
    List<String>? skills,
    List<String>? interests,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      phone: phone ?? this.phone,
      university: university ?? this.university,
      major: major ?? this.major,
      graduationYear: graduationYear ?? this.graduationYear,
      careerPath: careerPath ?? this.careerPath,
      bio: bio ?? this.bio,
      skills: skills ?? this.skills,
      interests: interests ?? this.interests,
    );
  }
}

class StudentProfileModel extends Equatable {
  final String userId;
  final String? phone;
  final String? university;
  final String? major;
  final String? graduationYear;
  final String? gpa;
  final String? bio;
  final String? linkedinUrl;
  final String? githubUrl;
  final String? cvUrl;
  final String? careerPath;
  final List<String> skills;
  final List<String> interests;

  const StudentProfileModel({
    required this.userId,
    this.phone,
    this.university,
    this.major,
    this.graduationYear,
    this.gpa,
    this.bio,
    this.linkedinUrl,
    this.githubUrl,
    this.cvUrl,
    this.careerPath,
    this.skills = const [],
    this.interests = const [],
  });

  @override
  List<Object?> get props => [
        userId,
        phone,
        university,
        major,
        graduationYear,
        gpa,
        bio,
        linkedinUrl,
        githubUrl,
        cvUrl,
        careerPath,
        skills,
        interests,
      ];
}

class InternshipModel extends Equatable {
  final String id;
  final String title;
  final String company;
  final String description;
  final String location;
  final String duration;
  final String stipend;
  final String startDate;
  final String deadline;
  final String requiredSkill;
  final bool isActive;

  const InternshipModel({
    required this.id,
    required this.title,
    required this.company,
    required this.description,
    required this.location,
    required this.duration,
    required this.stipend,
    required this.startDate,
    required this.deadline,
    required this.requiredSkill,
    this.isActive = true,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        company,
        description,
        location,
        duration,
        stipend,
        startDate,
        deadline,
        requiredSkill,
        isActive,
      ];
}

class ApplicationModel extends Equatable {
  final String id;
  final String internshipId;
  final String studentId;
  final String status; // 'Applied', 'Under Review', 'Accepted', 'Rejected', 'Completed'
  final String appliedDate;
  final String? reviewedDate;
  final String? completionDate;
  final double? rating;
  final String? feedback;
  final String? certificateUrl;

  const ApplicationModel({
    required this.id,
    required this.internshipId,
    required this.studentId,
    required this.status,
    required this.appliedDate,
    this.reviewedDate,
    this.completionDate,
    this.rating,
    this.feedback,
    this.certificateUrl,
  });

  @override
  List<Object?> get props => [
        id,
        internshipId,
        studentId,
        status,
        appliedDate,
        reviewedDate,
        completionDate,
        rating,
        feedback,
        certificateUrl,
      ];
}

class CourseModel extends Equatable {
  final String id;
  final String title;
  final String skill;
  final double durationHours;
  final String? certificateUrl;
  final bool isCompleted;

  const CourseModel({
    required this.id,
    required this.title,
    required this.skill,
    required this.durationHours,
    this.certificateUrl,
    this.isCompleted = false,
  });

  @override
  List<Object?> get props => [id, title, skill, durationHours, certificateUrl, isCompleted];
}

class NotificationModel extends Equatable {
  final String id;
  final String title;
  final String message;
  final String time;
  final bool isRead;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.time,
    this.isRead = false,
  });

  @override
  List<Object?> get props => [id, title, message, time, isRead];
}
