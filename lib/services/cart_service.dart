import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/pages/item.dart';

class CartService with ChangeNotifier, DiagnosticableTreeMixin {
  List<Items> _cart = [];
  List<Items> get cart => _cart;

  void addTocart({required Items item}) {
    _cart.add(item);

    notifyListeners();
  }

  bool isPersentIncart({required Items item}) {
    return _cart.where((element) => element.name == item.name).isNotEmpty;
  }

  void removeFromCart({required int index}) {
    _cart.removeAt(index);
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('cart', 1));
  }
}
