import 'package:mobx/mobx.dart';
import 'package:food_shopping_app/models/food_item.dart';

part 'cart_store.g.dart';

class CartStore = _CartStore with _$CartStore;

abstract class _CartStore with Store {
  @observable
  ObservableList<FoodItem> cartItems = ObservableList<FoodItem>();

  @action
  void addToCart(FoodItem item) {
    cartItems.add(item);
  }

  @action
  void checkout() {
    // POST request to dummy endpoint
    // Simulate checkout success
    cartItems.clear();
  }
}
