import 'package:flutter/material.dart';
import 'package:my_shop_app/providers/cart.dart' show Cart;
import 'package:provider/provider.dart';
import 'package:my_shop_app/widgets/cart_item.dart' /* as ci */;

class CartScreen extends StatelessWidget {
  static const routeName = "/cart";
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount}',
                      style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .titleMedium
                              ?.color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "BUY NOW",
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10,),
          Expanded(
            child:ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) => /* ci. */CartItem(
                id: cart.items.values.toList()[index].id, 
                productId: cart.items.keys.toList()[index],
                title: cart.items.values.toList()[index].title, 
                quantity: cart.items.values.toList()[index].quantity, 
                price: cart.items.values.toList()[index].price),
              ), 
            ),
        ],
      ),
    );
  }
}
