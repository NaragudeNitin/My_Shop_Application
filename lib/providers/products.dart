import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:my_shop_app/providers/product.dart';
import 'package:http/http.dart' as http; 

class Products with ChangeNotifier {
 List<Product> _items = [
/*     Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ), */
  ];


  List<Product> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> fetchAndSetProducts() async{
    const url = 'https://myshopapp-becc5-default-rtdb.firebaseio.com/products.json';
    try {
          final response = await http.get(Uri.parse(url));
          // print(json.decode(response.body));
          final extractedData = json.decode(response.body) as Map<String, dynamic>;
          final List<Product> loadedProducts = [];
          extractedData.forEach((prodIdKey, prodDataValue) {
            loadedProducts.add(
              Product(
                id: prodIdKey, 
                title: prodDataValue['title'], 
                description: prodDataValue['description'], 
                price: prodDataValue['price'],
                imageUrl: prodDataValue['imageUrl'],
                isFavorite: prodDataValue['isFavorite'],
                )
            );
          });
          _items = loadedProducts;
          notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    const url = 'https://myshopapp-becc5-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.post(
        (Uri.parse(url)),
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,

        }),
      );
      stdout.writeln(response);

      stdout.writeln(json.decode(response.body));
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      notifyListeners();

      // _items.insert(0, newProduct); // at the start of the list

    } catch (error) {
      stdout.writeln(error);
      rethrow;
    }
  }

  void updateProduct(String id, Product newProduct){
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
    _items[prodIndex] = newProduct;
    notifyListeners();
    }else{
      stdout.writeln("....");
    }
  }

  void deleteProduct(String id){
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
