import 'package:flutter/material.dart';
import 'package:mastering/blocs/categories_bloc.dart';
import 'package:mastering/blocs/products_bloc.dart';
import 'package:mastering/models/category.dart';
import 'package:mastering/screens/cart_page.dart';
import 'package:mastering/screens/selected_category_page.dart';
import 'package:mastering/widgets/cart_button.dart';
import 'package:mastering/widgets/containers/bloc_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _categoriesBloc = BlocProvider.of<CategoriesBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("commerce"),
        actions: [CartButton()],
      ),
      body: StreamBuilder<List<Category>>(
        //takes stream and builder
        stream: _categoriesBloc.outCategories,
        builder: (BuildContext context, AsyncSnapshot categories) {
          if (categories.hasData) {
            return ListView.builder(
              itemCount: categories.data.length,
              itemBuilder: (BuildContext context, int index) {
                final category = categories.data[index];
                return ListTile(
                  onTap: () {
                    _navigateToSelectedCategory(
                      context,
                      category,
                    );
                  },
                  title: Text(
                    categories.data[index].name,
                    style: TextStyle(fontSize: 24),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) => CartPage()));
        },
        child: Icon(Icons.arrow_forward_ios),
      ),
    );
  }
}

void _navigateToSelectedCategory(context, category) {
  Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => BlocProvider<ProductsBloc>(
            bloc: ProductsBloc(category),
            child: SelectedCategoryPage(),
          )));
}
