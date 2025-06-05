class Service {
  final String id;
  final String title;
  final String description;
  final String city;
  final double price;
  final double rating;

  Service({
    required this.id,
    required this.title,
    required this.description,
    required this.city,
    required this.price,
    required this.rating,
  });

  factory Service.fromMap(Map<String, dynamic> map) {
    return Service(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      city: map['city'] as String,
      price: (map['price'] as num).toDouble(),
      rating: (map['rating'] as num).toDouble(),
    );
  }
}