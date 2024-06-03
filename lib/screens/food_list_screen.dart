import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:food_shopping_app/api_keys.dart';
import 'package:http/http.dart' as http;
import 'package:isar/isar.dart';
import 'package:food_shopping_app/models/food_item_schema.dart';
import 'package:path_provider/path_provider.dart';

class FoodListScreen extends StatefulWidget {
  @override
  _FoodListScreenState createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {
  late Future<List<FoodItem>> _foodItems;
  late Isar isar;

  @override
  void initState() {
    super.initState();
    _initializeIsar();
    _foodItems = fetchFoodData();
  }

  Future<void> _initializeIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [FoodItemSchema],
      directory: dir.path,
    );
  }

  Future<List<FoodItem>> fetchFoodData() async {
    final response = await http.get(Uri.parse('https://api.spoonacular.com/food/menuItems/search?apiKey=${ApiKeys.spoonacularApiKey}&query=burgers'));

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> data = jsonResponse['menuItems'];
      List<FoodItem> foodItems = data.map((item) => FoodItem.fromJson(item)).toList();

      await isar.writeTxn(() async {
        await isar.foodItems.clear();
        await isar.foodItems.putAll(foodItems);
      });

      return foodItems;
    } else {
      return isar.foodItems.where().findAll();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Items'),
      ),
      body: FutureBuilder<List<FoodItem>>(
        future: _foodItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].title),
                  subtitle: Text(snapshot.data![index].restaurantChain),
                  leading: Image.network(snapshot.data![index].imageUrl),
                );
              },
            );
          }
        },
      ),
    );
  }
}
