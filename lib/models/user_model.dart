class UserModel {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? alamat;
  final String? roleId;
  final String? profilePicture;
  final String? isActive;
  final String? createdAt;
  final String? updatedAt;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.alamat,
    this.roleId,
    this.profilePicture,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone']?.toString(),
      alamat: json['alamat']?.toString(),
      roleId: json['role_id']?.toString(),
      profilePicture: json['profile_picture']?.toString(),
      isActive: json['is_active']?.toString(),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
    );
  }

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, roleId: $roleId)';
  }
}
