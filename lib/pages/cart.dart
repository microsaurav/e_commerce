import 'dart:developer';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/services/cart_service.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('', style: TextStyle(fontSize: 23.0)),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/');
              })),
      body: ListView.builder(
          itemCount: context.read<CartService>().cart.length,
          itemBuilder: (context, index) {
            log(context.read<CartService>().cart[index].name.toString(),
                name: 'print');
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0)),
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Image.network(
                        context.read<CartService>().cart[index].url,
                        height: 40,
                        width: 50,
                      ),
                    ),
                  ),
                  title: Text(
                      // ignore: unnecessary_string_interpolations
                      '${context.read<CartService>().cart[index].name}'),
                  trailing: IconButton(
                    onPressed: () {
                      context.read<CartService>().removeFromCart(index: index);
                      setState(() {
                        context.read<CartService>().cart;
                      });
                    },
                    icon: const Icon(Icons.remove),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
