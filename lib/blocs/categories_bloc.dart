import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mastering/api/db_api.dart';
import 'package:mastering/models/category.dart';
import 'package:mastering/widgets/containers/bloc_provider.dart';

class CategoriesBloc implements BlocBase {
  List<Category> _categories = List();

  //handles streams, act as a pipe getting the input and return the output
  StreamController<List<Category>> _categoriesController =
      StreamController<List<Category>>();
  //event input
  Sink<List<Category>> get _inCategories => _categoriesController.sink;
  //event output
  Stream<List<Category>> get outCategories => _categoriesController.stream;

  CategoriesBloc() {
    getCategories();
  }
  // get categories from Api
  void getCategories() {
    DbApi dbApi = DbApi();
    dbApi.getCategory().listen((snapshot) {
      List<Category> tempCategories = List();
      for (DocumentSnapshot doc in snapshot.docs) {
        Category category = Category.fromFirestore(doc.data());
        category.id = doc.id;
        tempCategories.add(category);
      }
      _categories.clear();
      _categories.addAll(tempCategories);
      _inCategories.add(_categories);
    });
  }

  @override
  void dispose() {
    _categoriesController.close();
  }
}
