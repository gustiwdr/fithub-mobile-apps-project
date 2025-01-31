class Service {
  final int id;
  final int companyId;
  final String name;
  final String description;
  final double price;
  final int duration;

  Service({
    required this.id,
    required this.companyId,
    required this.name,
    required this.description,
    required this.price,
    required this.duration,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      companyId: json['company_id'],
      name: json['name'],
      description: json['description'],
      price: double.parse(json['price']),
      duration: json['duration'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_id': companyId,
      'name': name,
      'description': description,
      'price': price.toString(),
      'duration': duration,
    };
  }
}
