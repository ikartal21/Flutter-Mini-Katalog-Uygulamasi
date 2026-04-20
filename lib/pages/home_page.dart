import 'package:flutter/material.dart';

import '../models/product.dart';
import '../services/product_repository.dart';
import '../widgets/product_card.dart';
import 'cart_page.dart';
import 'product_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProductRepository _repository = ProductRepository();
  final Map<int, int> _cartQuantities = <int, int>{};

  List<Product> _allProducts = <Product>[];
  List<Product> _filteredProducts = <Product>[];

  bool _isLoading = true;
  String _query = '';
  String _selectedCategory = 'Tum';

  int get _cartItemCount {
    return _cartQuantities.values.fold<int>(0, (sum, qty) => sum + qty);
  }

  List<String> get _categories {
    final categories = _allProducts
        .map((product) => product.category)
        .toSet()
        .toList()
      ..sort();
    return ['Tum', ...categories];
  }

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final products = await _repository.loadProducts();
    setState(() {
      _allProducts = products;
      _isLoading = false;
    });
    _applyFilters();
  }

  void _search(String value) {
    _query = value.trim().toLowerCase();
    _applyFilters();
  }

  void _applyFilters() {
    setState(() {
      _filteredProducts = _allProducts.where((product) {
        final queryMatches = product.title.toLowerCase().contains(_query) ||
            product.description.toLowerCase().contains(_query);
        final categoryMatches = _selectedCategory == 'Tum' ||
            product.category == _selectedCategory;
        return queryMatches && categoryMatches;
      }).toList();
    });
  }

  void _addToCart(Product product, {bool showFeedback = true}) {
    setState(() {
      _cartQuantities.update(product.id, (qty) => qty + 1, ifAbsent: () => 1);
    });
    if (showFeedback) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${product.title} sepete eklendi')),
      );
    }
  }

  void _removeFromCart(Product product) {
    final current = _cartQuantities[product.id] ?? 0;
    if (current <= 1) {
      setState(() {
        _cartQuantities.remove(product.id);
      });
      return;
    }
    setState(() {
      _cartQuantities[product.id] = current - 1;
    });
  }

  void _openCartPage() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => CartPage(
          products: _allProducts,
          quantities: _cartQuantities,
          onIncrease: (product) => _addToCart(product, showFeedback: false),
          onDecrease: _removeFromCart,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini Katalog Uygulamasi'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: IconButton(
                onPressed: _openCartPage,
                icon: Badge(
                  label: Text(_cartItemCount.toString()),
                  isLabelVisible: _cartItemCount > 0,
                  child: const Icon(Icons.shopping_cart_outlined),
                ),
              ),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Container(
                  margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/banner.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 140,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: TextField(
                    onChanged: _search,
                    decoration: InputDecoration(
                      hintText: 'Urun ara...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: _query.isEmpty
                          ? null
                          : IconButton(
                              onPressed: () {
                                _search('');
                              },
                              icon: const Icon(Icons.clear),
                            ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 44,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length,
                    separatorBuilder: (_, index) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final category = _categories[index];
                      return ChoiceChip(
                        label: Text(category),
                        selected: _selectedCategory == category,
                        onSelected: (_) {
                          _selectedCategory = category;
                          _applyFilters();
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: _filteredProducts.isEmpty
                      ? const Center(child: Text('Arama sonucu bulunamadi'))
                      : GridView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                          itemCount: _filteredProducts.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 0.62,
                          ),
                          itemBuilder: (context, index) {
                            final product = _filteredProducts[index];
                            return ProductCard(
                              product: product,
                              onTap: () async {
                                await Navigator.of(context).pushNamed(
                                  ProductDetailPage.routeName,
                                  arguments: {
                                    'product': product,
                                    'onAddToCart': () => _addToCart(product),
                                  },
                                );
                              },
                              onAddToCart: () => _addToCart(product),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}
