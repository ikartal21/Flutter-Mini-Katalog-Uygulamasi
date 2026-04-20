import 'package:flutter/material.dart';

import 'models/product.dart';
import 'pages/home_page.dart';
import 'pages/product_detail_page.dart';

void main() {
  runApp(const MiniKatalogApp());
}

class MiniKatalogApp extends StatelessWidget {
  const MiniKatalogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mini Katalog',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomePage(),
      onGenerateRoute: (settings) {
        if (settings.name == ProductDetailPage.routeName) {
          final args = settings.arguments as Map<String, dynamic>;
          final product = args['product'] as Product;
          final onAddToCart = args['onAddToCart'] as VoidCallback;
          return MaterialPageRoute(
            builder: (_) => ProductDetailPage(
              product: product,
              onAddToCart: onAddToCart,
            ),
          );
        }
        return null;
      },
    );
  }
}
