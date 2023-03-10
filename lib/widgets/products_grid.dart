import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../providers/products.dart';
import 'products_items.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({super.key, required this.showFavs});

  final bool showFavs;

  @override
  Widget build(BuildContext context) {
    final productData =
        Provider.of<Products>(context); //created object of Products class
    final products = showFavs ? productData.favoriteItems : productData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10),
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        // create: (context) => products[index],
        value: products[index],
        child: const ProductItem(),
      ),
    );
  }
}

/**
 * if we give give provider to item builder it will notify the change in the single item
 * // changed from stateless to statefull widget
 */