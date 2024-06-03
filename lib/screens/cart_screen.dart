import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:food_shopping_app/stores/cart_store.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartStore = Provider.of<CartStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Observer(
        builder: (_) {
          if (cartStore.cartItems.isEmpty) {
            return Center(child: Text('Your cart is empty'));
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartStore.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartStore.cartItems[index];
                      return ListTile(
                        title: Text(item.title),
                        subtitle: Text(item.restaurantChain),
                        leading: Image.network(item.imageUrl),
                      );
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    cartStore.checkout();
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Checkout successful!')));
                  },
                  child: Text('Checkout'),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
