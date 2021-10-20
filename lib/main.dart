import 'package:e_commerce/pages/cart.dart';
import 'package:e_commerce/services/cart_service.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/pages/item.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartService()),
      ],
      child: MaterialApp(initialRoute: '/', routes: {
        '/': (context) => const Item(),
        '/cart': (context) => const CartPage(),
      })));
}
