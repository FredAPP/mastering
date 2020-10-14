import 'package:flutter/material.dart';
import 'package:mastering/blocs/cart_bloc.dart';
import 'package:mastering/blocs/categories_bloc.dart';
import 'package:mastering/screens/home_page.dart';
import 'package:mastering/widgets/containers/bloc_provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    BlocProvider<CartBloc>(
      bloc: CartBloc(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider<CategoriesBloc>(
        bloc: CategoriesBloc(),
        child: HomePage(),
      ),
    );
  }
}
