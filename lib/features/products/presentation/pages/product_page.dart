import 'package:flutter/material.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({required this.productId, super.key});

  final String productId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product')),
      body: Center(
        child: Text(
          'Product details for id=$productId will be implemented in Step 5',
        ),
      ),
    );
  }
}
