import 'package:flutter/material.dart';
import 'package:my_shop_app/providers/products.dart';
import 'package:provider/provider.dart';
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
      itemBuilder: (context, index) => ProductItem(
        id: products[index].id,
        title: products[index].title,
        imageUrl: products[index].imageUrl,
      ),);
  }
}