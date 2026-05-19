import 'package:pathguide_app/core/data/models.dart';
import 'package:pathguide_app/core/services/api_client.dart';

class StudentApiService {
  static final _dio = ApiClient.instance;

  /// Fetch the full student profile from the backend
  static Future<UserModel> getProfile(UserModel current) async {
    final response = await _dio.get('/students/profile');
    final j = response.data as Map<String, dynamic>;
    return current.copyWith(
      id: j['userId']?.toString() ?? current.id,
      name: (j['userName'] as String?) ?? current.name,
      phone: j['phone'] as String?,
      university: j['universityName'] as String?,
      major: j['majorName'] as String?,
      graduationYear: j['graduationYear']?.toString(),
      bio: j['bio'] as String?,
      linkedinUrl: j['linkedinUrl'] as String?,
      githubUrl: j['githubUrl'] as String?,
      careerPath: j['careerPathName'] as String?,
      skills: ((j['skills'] as List?) ?? [])
          .map((s) => (s['skillName'] as String?) ?? '')
          .where((s) => s.isNotEmpty)
          .toList(),
      interests: ((j['interests'] as List?) ?? [])
          .map((i) => (i['interestName'] as String?) ?? '')
          .where((s) => s.isNotEmpty)
          .toList(),
    );
  }

  /// Save editable profile fields back to the backend
  static Future<void> updateProfile({
    required String name,
    String? phone,
    String? bio,
    String? graduationYear,
    String? linkedinUrl,
    String? githubUrl,
  }) async {
    await _dio.put('/students/profile', data: {
      'fullName': name,
      if (phone != null && phone.isNotEmpty) 'phone': phone,
      if (bio != null && bio.isNotEmpty) 'bio': bio,
      if (graduationYear != null && graduationYear.isNotEmpty)
        'graduationYear': int.tryParse(graduationYear),
      if (linkedinUrl != null && linkedinUrl.isNotEmpty) 'linkedinUrl': linkedinUrl,
      if (githubUrl != null && githubUrl.isNotEmpty) 'githubUrl': githubUrl,
    });
  }
}
