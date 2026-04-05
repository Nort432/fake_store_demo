import '../../domain/entities/product.dart';

class ProductDto {
  const ProductDto({
    required this.id,
    required this.title,
    required this.price,
    required this.images,
  });

  final int id;
  final String title;
  final num price;
  final List<String> images;

  factory ProductDto.fromJson(Map<String, dynamic> json) {
    return ProductDto(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? 'Untitled',
      price: json['price'] as num? ?? 0,
      images: ((json['images'] as List<dynamic>?) ?? <dynamic>[])
          .map((image) => image.toString())
          .toList(),
    );
  }

  Product toEntity() {
    return Product(
      id: id,
      title: title,
      price: price.toDouble(),
      imageUrl: _resolveImage(images),
      rating: _resolveRating(id),
    );
  }

  String _resolveImage(List<String> images) {
    for (final image in images) {
      final uri = Uri.tryParse(image);
      if (uri != null && uri.hasScheme) {
        return image;
      }
    }

    return '';
  }

  double _resolveRating(int id) {
    return 4 + ((id % 10) / 10);
  }
}
