import 'package:flutter/material.dart';
import 'package:my_shop_app/providers/cart.dart';
import 'package:my_shop_app/screens/product_detail_screen.dart';
import 'package:my_shop_app/screens/products_overview_screen.dart';
import 'package:provider/provider.dart';
import 'providers/products.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
      ChangeNotifierProvider(
      create: (context) => Products()),
      ChangeNotifierProvider(
      create:(context) => Cart()),

      ],
    
      child: MaterialApp(
        title: 'My Shop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: Colors.deepOrange),
          fontFamily: 'Lato',
        ),
        home: const ProductsOverViewScreen(),
        routes:  {
          ProductDetailScreen.routeName:(context) => const ProductDetailScreen(),
    
        },
      ),
    );
  }
}


/**
 * -to avoid constructor call we can use CENTRAL STATE MANAGEMENT SOLUTION
 * -in root level there are widgets registered therefore we need to provide data here
 *  the provided data will not not rebuild the application whenever there is some changes in data
 */