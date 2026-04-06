import 'package:fake_store_demo/features/products/data/models/product_dto.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProductDto', () {
    test('maps json to entity with sanitized category and valid image', () {
      final dto = ProductDto.fromJson({
        'id': 11,
        'title': 'Headphones',
        'description': 'Noise cancelling',
        'price': 44.5,
        'images': ['invalid-url', 'https://cdn.example.com/image.png'],
        'category': {'name': '<script>alert(1)</script>'},
      });

      final entity = dto.toEntity();

      expect(entity.id, 11);
      expect(entity.title, 'Headphones');
      expect(entity.price, 44.5);
      expect(entity.imageUrl, 'https://cdn.example.com/image.png');
      expect(entity.subtitle, '---');
      expect(entity.rating, closeTo(4.1, 0.001));
    });

    test('falls back to empty image and placeholder category', () {
      final dto = ProductDto.fromJson({
        'id': 3,
        'title': 'Item',
        'description': '',
        'price': 1,
        'images': ['bad'],
        'category': {'name': ''},
      });

      final entity = dto.toEntity();

      expect(entity.imageUrl, '');
      expect(entity.subtitle, '---');
      expect(entity.rating, closeTo(4.3, 0.001));
    });
  });
}
