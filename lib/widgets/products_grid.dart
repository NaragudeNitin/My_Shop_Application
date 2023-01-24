import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../providers/products.dart';
import 'products_items.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({super.key});



  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context); //created object of Products class
    final products = productData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: products.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3/2,
        crossAxisSpacing: 10, 
        mainAxisSpacing: 10
        ), 
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        // create: (context) => products[index],
        value: products[index],
        child: ProductItem(
        // id: products[index].id,
        // title: products[index].title,
        // imageUrl: products[index].imageUrl,
      ),
      ),
      );
  }
}

/**
 * if we give give provider to item builder it will notify the change in the single item
 */