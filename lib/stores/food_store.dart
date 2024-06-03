import 'package:food_shopping_app/api_keys.dart';
import 'package:mobx/mobx.dart';
import 'package:isar/isar.dart';
import 'package:food_shopping_app/models/food_item_schema.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

part 'food_store.g.dart';

class FoodStore = _FoodStore with _$FoodStore;

abstract class _FoodStore with Store {
  late Isar isar;

  @observable
  ObservableList<FoodItem> foodItems = ObservableList<FoodItem>();

  @action
  Future<void> fetchFoodData() async {
    final response = await http.get(Uri.parse('https://api.spoonacular.com/food/menuItems/search?apiKey=${ApiKeys.spoonacularApiKey}&query=burgers'));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> data = jsonResponse['menuItems'];
      List<FoodItem> fetchedFoodItems = data.map((item) => FoodItem.fromJson(item)).toList();

      await isar.writeTxn(() async {
        await isar.foodItems.clear();
        await isar.foodItems.putAll(fetchedFoodItems);
      });

      foodItems.addAll(fetchedFoodItems);
    } else {
      List<FoodItem> localFoodItems = await isar.foodItems.where().findAll();
      foodItems.addAll(localFoodItems);
    }
  }
}
