import 'package:flutter/material.dart';
import 'package:my_shop_app/providers/products.dart';
import 'package:provider/provider.dart';
import '../widgets/products_grid.dart';

enum FilterOptions{
  favorites,
  all,
}

class ProductsOverViewScreen extends StatelessWidget {
   const ProductsOverViewScreen({super.key});



  @override
  Widget build(BuildContext context) {
    final productsContainer = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Shop"),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              
              if (value == FilterOptions.favorites) {
                productsContainer.showFavoritesOnly();
              }else{
                productsContainer.showAll();
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem(value: FilterOptions.favorites,child: Text("only favorites"),
              ),
              const PopupMenuItem(value: FilterOptions.all,child: Text("Show All"),
              ),
              
            ],
            ),
        ],
      ),
      body: const ProductsGrid(),
    );
  }
}