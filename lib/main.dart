import 'package:flutter/material.dart';
import 'package:my_shop_app/screens/product_detail_screen.dart';
import 'package:my_shop_app/screens/products_overview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Shop',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: Colors.deepOrange),
        fontFamily: 'Lato',
      ),
      home: ProductsOverViewScreen(),
      routes:  {
        ProductDetailScreen.routeName:(context) => ProductDetailScreen(),

      },
    );
  }
}


/**
 * to avoid constructor call we can use CENTRAL STATE MANAGEMENT SOLUTION 
 */