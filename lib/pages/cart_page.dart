import 'package:flutter/material.dart';

import '../models/product.dart';

class CartPage extends StatefulWidget {
  const CartPage({
    super.key,
    required this.products,
    required this.quantities,
    required this.onIncrease,
    required this.onDecrease,
  });

  final List<Product> products;
  final Map<int, int> quantities;
  final void Function(Product product) onIncrease;
  final void Function(Product product) onDecrease;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late final Map<int, int> _localQuantities;

  @override
  void initState() {
    super.initState();
    _localQuantities = Map<int, int>.from(widget.quantities);
  }

  void _increase(Product product) {
    final current = _localQuantities[product.id] ?? 0;
    _localQuantities[product.id] = current + 1;
    setState(() {});
    widget.onIncrease(product);
  }

  void _decrease(Product product) {
    final current = _localQuantities[product.id] ?? 0;
    if (current <= 1) {
      _localQuantities.remove(product.id);
    } else {
      _localQuantities[product.id] = current - 1;
    }
    setState(() {});
    widget.onDecrease(product);
  }

  @override
  Widget build(BuildContext context) {
    final cartProducts = widget.products
        .where((product) => (_localQuantities[product.id] ?? 0) > 0)
        .toList();

    final total = cartProducts.fold<double>(0, (sum, product) {
      final quantity = _localQuantities[product.id] ?? 0;
      return sum + (product.price * quantity);
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Sepetim')),
      body: cartProducts.isEmpty
          ? const Center(child: Text('Sepetiniz su an bos'))
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: cartProducts.length,
                    separatorBuilder: (_, index) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final product = cartProducts[index];
                      final quantity = _localQuantities[product.id] ?? 0;
                      final itemTotal = product.price * quantity;

                      return Card(
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              product.image,
                              width: 56,
                              height: 56,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(product.title),
                          subtitle: Text(
                            'Adet: $quantity  -  ${itemTotal.toStringAsFixed(2)} TL',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () => _decrease(product),
                                icon: const Icon(Icons.remove_circle_outline),
                              ),
                              IconButton(
                                onPressed: () => _increase(product),
                                icon: const Icon(Icons.add_circle_outline),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SafeArea(
                  top: false,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                    decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: Colors.grey.shade300)),
                    ),
                    child: Text(
                      'Toplam: ${total.toStringAsFixed(2)} TL',
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
