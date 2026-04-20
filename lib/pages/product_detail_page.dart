import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key, required this.product, required this.onAddToCart});

  static const routeName = '/product-detail';

  final Product product;
  final VoidCallback onAddToCart;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Urun Detayi')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              product.image,
              height: 260,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            product.title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Chip(label: Text('Kategori: ${product.category}')),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.star, color: Colors.amber.shade700),
              const SizedBox(width: 6),
              Text('Puan: ${product.rating.toStringAsFixed(1)}'),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            '${product.price.toStringAsFixed(2)} TL',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.teal.shade700,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            product.description,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              onAddToCart();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Urun sepete eklendi')),
              );
            },
            icon: const Icon(Icons.shopping_cart_checkout),
            label: const Text('Sepete Ekle'),
          ),
        ],
      ),
    );
  }
}
