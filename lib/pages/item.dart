import 'dart:developer';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/services/cart_service.dart';

class Items {
  final String name;
  final String url;
  Items(this.name, this.url);
}

int selectedService = -1;
List<Items> items = [
  Items('Item1',
      'https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
  Items('Item2', 'https://googleflutter.com/sample_image.jpg'),
  Items('Item3',
      'https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
  Items('Item4',
      'https://images.pexels.com/photos/213780/pexels-photo-213780.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
];

class Item extends StatefulWidget {
  const Item({Key? key}) : super(key: key);

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    List<Items> cart = context.read<CartService>().cart;

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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/cart');
        },
        label: const Text("Cart", style: TextStyle(fontSize: 15)),
        icon: const Icon(
          Icons.directions,
          size: 20,
        ),
        backgroundColor: Colors.red,
      ),
      // backgroundColor: Colors.blue,

      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(35, 10, 0, 0),
                child: Text(
                  'Items',
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.grey.shade900,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ];
        },
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.0,
                        crossAxisSpacing: 20.0,
                        mainAxisSpacing: 20.0,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.network(items[index].url, height: 60),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                items[index].name,
                                style: const TextStyle(fontSize: 10),
                              ),
                              !context.watch<CartService>().isPersentIncart(
                                      item: Items(
                                          items[index].name, items[index].url))
                                  ? IconButton(
                                      icon: const Icon(Icons.shopping_cart),
                                      iconSize: 25,
                                      onPressed: () {
                                        context.read<CartService>().addTocart(
                                            item: Items(items[index].name,
                                                items[index].url));
                                        log('presses', name: 'press');
                                        log(
                                            context
                                                .read<CartService>()
                                                .isPersentIncart(
                                                    item: Items(
                                                        items[index].name,
                                                        items[index].url))
                                                .toString(),
                                            name: 'c');
                                        log(
                                            context
                                                .read<CartService>()
                                                .cart
                                                .toString(),
                                            name: "Cart");
                                        setState(() {
                                          cart;
                                        });
                                      })
                                  : IconButton(
                                      icon: const Icon(Icons.shopping_cart),
                                      iconSize: 25,
                                      color: Colors.grey,
                                      onPressed: () {})
                            ],
                          ),
                        );
                      }),
                ),
              ]),
        ),
      ),
    );
  }
}
