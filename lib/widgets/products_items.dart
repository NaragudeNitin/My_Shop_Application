import 'package:flutter/material.dart';
import 'package:my_shop_app/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  const ProductItem(
      {super.key,
      required this.id,
      required this.title,
      required this.imageUrl});
  final String id;
  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      //ClipRRect forces the widget to take certain shape
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
              color: Theme.of(context).colorScheme.secondary,
              onPressed: () {},
              icon: const Icon(Icons.favorite)),
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
              color: Theme.of(context).colorScheme.secondary,
              onPressed: () {},
              icon: const Icon(Icons.shopping_cart)),
        ),
        child: GestureDetector(
          onTap: () {
           Navigator.of(context).pushNamed(
            ProductDetailScreen.routeName, 
            arguments: id);
          },
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        
      ), 
    );
  }
}
