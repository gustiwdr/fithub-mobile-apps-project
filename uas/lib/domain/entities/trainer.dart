class Trainer {
  final int id;
  final int companyId;
  final String name;
  final String expertise;
  final String phone;
  final String email;
  final String profilePicture;

  Trainer({
    required this.id,
    required this.companyId,
    required this.name,
    required this.expertise,
    required this.phone,
    required this.email,
    required this.profilePicture,
  });

  factory Trainer.fromJson(Map<String, dynamic> json) {
    return Trainer(
      id: json['id'],
      companyId: json['company_id'],
      name: json['name'],
      expertise: json['expertise'],
      phone: json['phone'],
      email: json['email'],
      profilePicture: json['profile_picture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_id': companyId,
      'name': name,
      'expertise': expertise,
      'phone': phone,
      'email': email,
      'profile_picture': profilePicture,
    };
  }
}
