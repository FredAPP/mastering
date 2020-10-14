import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mastering/api/db_api.dart';
import 'package:mastering/models/category.dart';
import 'package:mastering/models/product.dart';
import 'package:mastering/widgets/containers/bloc_provider.dart';

class ProductsBloc implements BlocBase {
  List<Product> _products = List();

  StreamController<List<Product>> _productsController =
      StreamController<List<Product>>();
  //event input
  Sink<List<Product>> get _inProducts => _productsController.sink;
  //event output
  Stream<List<Product>> get outProducts => _productsController.stream;

  ProductsBloc(Category category) {
    getProducts(category);
  }

  @override
  void dispose() {
    _productsController.close();
  }

  void getProducts(Category category) {
    DbApi dbApi = DbApi();
    dbApi.getProducts(category).listen((snapshot) {
      List<Product> tempProducts = List();

      for (DocumentSnapshot doc in snapshot.docs) {
        Product product = Product.fromFirestore(doc.data());
        product.id = doc.id;
        tempProducts.add(product);
      }
      _products.clear();
      _products.addAll(tempProducts);
      _inProducts.add(_products);
    });

    // _productsController.addError('error');
  }
}
