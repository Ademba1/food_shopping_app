import 'package:flutter/material.dart';
// import 'package:food_shopping_app/api_keys.dart';
import 'package:food_shopping_app/screens/food_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FoodListScreen(),
    );
  }
}
