import 'package:flutter/material.dart';
import 'package:my_shop_app/providers/cart.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  const CartItem(
      {super.key,
      required this.id,
      required this.productId,
      required this.price,
      required this.quantity,
      required this.title});
  final String id;
  final String productId;
  final double price;
  final int quantity;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 4,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
          context: context, 
          builder: (context) => AlertDialog(
            title: const Text("Are you sure?"),
            content: const Text("Do you want to remove item from a cart"),
            actions: [
              TextButton(onPressed: () {
                Navigator.of(context).pop(false);
              }, child: const Text("No"),),
               TextButton(onPressed: () {
                Navigator.of(context).pop(true);
              }, child: const Text("Yes"),),
            ],

          ),);
          
      },
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: FittedBox(child: Text("\$$price")),
              ),
            ),
            title: Text(title),
            subtitle: Text("Total: \$${price * quantity}"),
            trailing: Text("$quantity x"),
          ),
        ),
      ),
    );
  }
}
