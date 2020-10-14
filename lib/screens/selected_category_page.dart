import 'package:flutter/material.dart';
import 'package:mastering/blocs/cart_bloc.dart';
import 'package:mastering/blocs/products_bloc.dart';
import 'package:mastering/models/product.dart';
import 'package:mastering/widgets/cart_button.dart';
import 'package:mastering/widgets/containers/bloc_provider.dart';

class SelectedCategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ProductsBloc _productsBloc = BlocProvider.of<ProductsBloc>(context);
    final CartBloc _cartBloc = BlocProvider.of<CartBloc>(context);

    return Scaffold(
        appBar: AppBar(
          actions: [CartButton()],
        ),
        body: StreamBuilder<List<Product>>(
          stream: _productsBloc.outProducts,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.error);
            }
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(
                  child: CircularProgressIndicator(),
                );
              default:
                return GridView.builder(
                    itemCount: snapshot.data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (BuildContext context, int index) {
                      final product = snapshot.data[index];
                      return Stack(
                        children: [
                          product.imageUrl != null
                              ? Positioned.fill(
                                  child: Image.network(
                                    product.imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Container(),
                          Positioned.fill(
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () => _cartBloc.addProduct(product),
                                child: Center(
                                  child: Text(
                                    snapshot.data[index].name,
                                    style: product.imageUrl != null
                                        ? TextStyle(color: Colors.white)
                                        : TextStyle(color: Colors.black),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    });
            }
          },
        ));
  }
}
