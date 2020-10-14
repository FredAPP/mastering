import 'package:flutter/material.dart';
import 'package:mastering/blocs/cart_bloc.dart';
import 'package:mastering/models/product.dart';
import 'package:mastering/widgets/containers/bloc_provider.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CartBloc _cartBloc = BlocProvider.of<CartBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: StreamBuilder<List<Product>>(
        initialData: [],
        stream: _cartBloc.outProducts,
        builder: (context, snapshot) {
          if (snapshot.data.isEmpty) {
            return Center(
              child: Text('No items added yet'),
            );
          } else {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  final product = snapshot.data[index];
                  return ListTile(
                    title: Text(product.name),
                    trailing: Text(product.amount.toString()),
                  );
                });
          }
        },
      ),
    );
  }
}
