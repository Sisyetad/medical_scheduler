import 'package:medical_scheduler/data/model/branch_model.dart';
import 'package:medical_scheduler/domain/entities/response/user.dart';

class HeadOffice extends User {
  int headofficeId;
  String location;
  String contactPhone;

  HeadOffice({
    required this.headofficeId,
    required String name,
    required this.location,
    required String contactEmail,
    required this.contactPhone,
    required super.role,
    super.password,
    required super.createdAt,
    required super.updatedAt,
  }) : super(
          userId: headofficeId, 
          username: name,
          email: contactEmail,
        );

  @override
  HeadOffice copyWith({
    String? username,
    String? email,
    String? password,
    String? updatedAt,
    List<BranchModel>? branches, 
  }) {
    return HeadOffice(
      headofficeId: headofficeId,
      name: username ?? this.username,
      location: location,
      contactEmail: email ?? this.email,
      contactPhone: contactPhone,
      password: password ?? '',
      createdAt: createdAt,
      updatedAt: updatedAt ?? DateTime.now().toIso8601String(),
      role: role,
    );
  }

  void updateLocation(String newLocation) {
    location = newLocation;
  }

  void updateContactPhone(String newPhone) {
    contactPhone = newPhone;
  }

}
