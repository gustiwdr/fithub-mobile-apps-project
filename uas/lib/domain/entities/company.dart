class Company {
  final int id;
  final String name;
  final String description;
  final String address;
  final String phone;
  final String email;
  final String logoUrl;

  Company({
    required this.id,
    required this.name,
    required this.description,
    required this.address,
    required this.phone,
    required this.email,
    required this.logoUrl,
  });

  factory Company.fromJson(Map<String, dynamic> json, String baseImageUrl) {
    // Convert 'logo' into 'logoUrl' here
    return Company(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
      logoUrl: json['logo'] != null
          ? baseImageUrl + json['logo']
          : '', // Handle 'logo' to 'logoUrl'
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'address': address,
      'phone': phone,
      'email': email,
      'logo_url': logoUrl, // This is for conversion to JSON if needed
    };
  }
}
