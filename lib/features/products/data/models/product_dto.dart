import '../../domain/entities/product.dart';

class ProductDto {
  const ProductDto({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.images,
    required this.categoryName,
  });

  final int id;
  final String title;
  final String description;
  final num price;
  final List<String> images;
  final String categoryName;

  factory ProductDto.fromJson(Map<String, dynamic> json) {
    return ProductDto(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? 'Untitled',
      description: json['description'] as String? ?? '',
      price: json['price'] as num? ?? 0,
      images: ((json['images'] as List<dynamic>?) ?? <dynamic>[])
          .map((image) => image.toString())
          .toList(),
      categoryName: _resolveCategoryName(
        (json['category'] as Map<String, dynamic>?)?['name'] as String?,
      ),
    );
  }

  Product toEntity() {
    return Product(
      id: id,
      title: title,
      description: description,
      subtitle: categoryName,
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

  static String _resolveCategoryName(String? raw) {
    if (raw == null || raw.trim().isEmpty) {
      return '---';
    }

    final lowerRaw = raw.toLowerCase();
    final hasSuspiciousPattern =
        lowerRaw.contains('<') ||
        lowerRaw.contains('>') ||
        lowerRaw.contains('script') ||
        lowerRaw.contains('javascript:') ||
        lowerRaw.contains('alert(');
    if (hasSuspiciousPattern) {
      return '---';
    }

    final withoutTags = raw.replaceAll(RegExp(r'<[^>]*>'), ' ');
    final withoutEntities = withoutTags.replaceAll(RegExp(r'&[^;\s]+;'), ' ');
    final normalized = withoutEntities.replaceAll(RegExp(r'\s+'), ' ').trim();
    if (normalized.isEmpty) {
      return '---';
    }

    return normalized;
  }
}
