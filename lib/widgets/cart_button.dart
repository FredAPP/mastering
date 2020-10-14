import 'package:flutter/material.dart';
import 'package:mastering/blocs/cart_bloc.dart';
import 'package:mastering/screens/cart_page.dart';
import 'package:mastering/widgets/containers/bloc_provider.dart';

class CartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CartBloc _cartButton = BlocProvider.of<CartBloc>(context);
    return Stack(
      children: [
        IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => CartPage()));
            }),
        Positioned(
          right: 5,
          bottom: 5,
          child: CircleAvatar(
            radius: 8,
            backgroundColor: Colors.red,
            child: StreamBuilder<int>(
              initialData: 0,
              stream: _cartButton.outCount,
              builder: (context, snapshop) {
                return Text(
                  snapshop.data.toString(),
                  style: TextStyle(fontSize: 9),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
