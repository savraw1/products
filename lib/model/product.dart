class Product {
  final int id;
  final String title;
  final String description;
  final String thumbnail;
  final double price;
  final double rating;
  final double discountPercentage;
  final int stock;
  final String brand;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.thumbnail,
      required this.price,
      required this.rating,
      required this.discountPercentage,
      required this.stock,
      required this.brand});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        thumbnail: json['thumbnail'],
        price: (json['price'] as num).toDouble(),
        rating: (json['rating'] as num).toDouble(),
        discountPercentage: (json['discountPercentage'] as num).toDouble(),
        stock: json['stock'],
        brand: json['brand'] ?? "Unknown");
  }
}