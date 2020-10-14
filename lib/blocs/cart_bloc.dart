import 'dart:async';

import 'package:mastering/models/cart.dart';
import 'package:mastering/models/product.dart';
import 'package:mastering/widgets/containers/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';

class CartBloc extends BlocBase {
  Cart _cart = Cart();

  //behavior subject acts sorta like sharedpreferences add functionality
  //product controller
  final _productsController = BehaviorSubject<List<Product>>();
  //event input
  Sink<List<Product>> get _inProducts => _productsController.sink;
  //event output
  Stream<List<Product>> get outProducts => _productsController.stream;

  //count controller
  final _countController = BehaviorSubject<int>();
  //event input
  Sink get _inCount => _countController.sink;
  //event output
  Stream get outCount => _countController.stream;

  @override
  void dispose() {
    _productsController.close();
    _countController.close();
  }

  void addProduct(Product product) {
    final products = _cart.products;
    if (products.contains(product)) {
      products[products.indexOf(product)].amount++;
    } else {
      product.amount = 1;
      products.add(product);
    }
    _cart.itemCount++;
    _inCount.add(_cart.itemCount);
    _inProducts.add(products);
  }
}
