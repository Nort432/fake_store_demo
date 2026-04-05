class Product {
  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.rating,
  });

  final int id;
  final String title;
  final double price;
  final String imageUrl;
  final double rating;
}
