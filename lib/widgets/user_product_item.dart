import 'package:flutter/material.dart';
class UserPRoductItem extends StatelessWidget {
    final String title;
    final String imageUrl;

  const UserPRoductItem(this.title, this.imageUrl ,{super.key, });

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
                
              }, icon: const Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
              ),
              IconButton(onPressed: () {
                
              }, icon: const Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              ),
            ],
          ),
        ),
    );
  }
}