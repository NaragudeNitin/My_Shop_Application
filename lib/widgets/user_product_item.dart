import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_shop_app/providers/products.dart';
import 'package:my_shop_app/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';
class UserPRoductItem extends StatelessWidget {
  final String id;
    final String title;
    final String imageUrl;

  const UserPRoductItem(this.id,this.title, this.imageUrl ,{super.key, });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
        ),
        trailing: Container(
          width: 100,
          padding: const EdgeInsets.all(1.0),
          child: Row(
            children: [

              IconButton(onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName, arguments:id );
              }, icon: const Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
              ),

              IconButton(onPressed: () async{
                try {
                  await Provider.of<Products>(context , listen: false).deleteProduct(id);
                } catch (error) {
                  stdout.writeln("Delete Failed"); 
                //   ScaffoldMessenger.of(context).showSnackBar( 
                //    SnackBar(
                //     content:  Text(
                //       "Delete Failed" ,
                //       textAlign: TextAlign.center,
                //       style: TextStyle(
                //         color: Theme.of(context).errorColor
                //       ),
                //     ),
                //     duration: const Duration(seconds: 2),
                    
                //   ),
                // );
                }
              }, icon: const Icon(Icons.delete),
              color: Theme.of(context).colorScheme.error,
              ),
            ],
          ),
        ),
    );
  }
}