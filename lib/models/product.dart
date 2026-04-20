class Product {
  const Product({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.image,
  });

  final int id;
  final String category;
  final String title;
  final String description;
  final double price;
  final double rating;
  final String image;

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      category: (json['category'] as String?) ?? 'Genel',
      title: json['title'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      image: json['image'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'title': title,
      'description': description,
      'price': price,
      'rating': rating,
      'image': image,
    };
  }
}
