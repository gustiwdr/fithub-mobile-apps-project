class User {
  final int id;
  final String name;
  final String email;
  final String? avatarUrl;
  final String? emailVerifiedAt;
  final String theme;
  final String themeColor;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
    this.emailVerifiedAt,
    required this.theme,
    required this.themeColor,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    // Handle jika response API mengembalikan data langsung di root
    return User(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      email: json['email'] ?? 'Unknown',
      avatarUrl: json['avatar_url'],
      emailVerifiedAt: json['email_verified_at'],
      theme: json['theme'] ?? 'default',
      themeColor: json['theme_color'] ?? 'default',
    );
  }
}
