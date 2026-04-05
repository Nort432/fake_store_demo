class Product {
  const Product({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.imageUrl,
    required this.rating,
  });

  final int id;
  final String title;
  final String subtitle;
  final double price;
  final String imageUrl;
  final double rating;
}
