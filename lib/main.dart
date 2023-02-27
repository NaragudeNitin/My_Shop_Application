import 'package:flutter/material.dart';
import 'package:my_shop_app/providers/_auth.dart';
import 'package:my_shop_app/providers/cart.dart';
import 'package:my_shop_app/screens/auth_screen.dart';
import 'package:my_shop_app/screens/cart_screen.dart';
import 'package:my_shop_app/screens/edit_product_screen.dart';
import 'package:my_shop_app/screens/orders_screen.dart';
import 'package:my_shop_app/screens/product_detail_screen.dart';
import 'package:my_shop_app/screens/products_overview_screen.dart';
import 'package:my_shop_app/screens/user_products_screen.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';

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
      ChangeNotifierProvider.value(
      value:Auth() ),
      // ChangeNotifierProvider.value(
      // value: Products()),

      ChangeNotifierProvider.value(
      value: Cart()),
      // ChangeNotifierProvider.value(
      //   value: Orders(),),
      // ],
      // ChangeNotifierProxyProvider<Auth, Orders>(
      //         create: (_) => Orders('', '', []),
      //         update: (context, auth, previousOrder) => Orders(
      //             auth.token,
      //             auth.userId,
      //             previousOrder == null ? [] : previousOrder.orders))
        ],
    
      child: Consumer<Auth>(
        builder: (context, auth, _) =>  MaterialApp(
        title: 'My Shop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: Colors.deepOrange),
          fontFamily: 'Lato',
        ),
        home: auth.isAuth
                ? const ProductsOverViewScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (context, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? const SplashScreen()
                            : const AuthScreen()),
        routes:  {
          ProductDetailScreen.routeName:(context) => const ProductDetailScreen(),
          CartScreen.routeName:(context) => const CartScreen(),
          OrderScreen.routeName:(context) => const OrderScreen(),
          UserProductScreen.routeName:(context) => const UserProductScreen(),
          EditProductScreen.routeName:(context) => const EditProductScreen(),
          
        },
      ),
      key: key,
      child: const Text(""),
    ));
  }
}


/**
 * -to avoid constructor call we can use CENTRAL STATE MANAGEMENT SOLUTION
 * -in root level there are widgets registered therefore we need to provide data here
 *  the provided data will not not rebuild the application whenever there is some changes in data
 */