import 'dart:convert';

// Define the FoodItem class
class FoodItem {
  final int id;
  final String title;
  final String imageUrl;
  final String restaurantChain;
  final double servings;

  FoodItem({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.restaurantChain,
    required this.servings,
  });

  // Factory method to create FoodItem from JSON
  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id'],
      title: json['title'],
      imageUrl: json['image'],
      restaurantChain: json['restaurantChain'],
      servings: json['servings']['number'] != null ? json['servings']['number'].toDouble() : 0.0,
    );
  }
}

// Parse the JSON data and create a list of FoodItem objects
void main() {
  String jsonString = '{"type":"menuItem","menuItems":[{"id":306187,"title":"Burger","image":"https://spoonacular.com/menuItemImages/hamburger.jpg","imageType":"jpg","restaurantChain":"Garfield\'s Restaurant & Pub","servings":{"number":1.0,"size":null,"unit":null}},{"id":381778,"title":"Cowboy Burger","image":"https://spoonacular.com/menuItemImages/hamburger.jpg","imageType":"jpg","restaurantChain":"Sam & Louie\'s Ny Pizza","servings":{"number":1.0,"size":null,"unit":null}},{"id":247615,"title":"Tony\'s Bodacious Burger w/ Fries, Max","image":"https://spoonacular.com/menuItemImages/hamburger.jpg","imageType":"jpg","restaurantChain":"Max & Erma\'s","servings":{"number":1.0,"size":null,"unit":null}},{"id":370301,"title":"Plain Jane Burger, Chicken","image":"https://spoonacular.com/menuItemImages/hamburger.jpg","imageType":"jpg","restaurantChain":"De Dutch Pannekoek House","servings":{"number":1.0,"size":231.0,"unit":"grams"}},{"id":321356,"title":"99 Top a Burger, Sauteed Peppers, 2 oz","image":"https://spoonacular.com/menuItemImages/hamburger.jpg","imageType":"jpg","restaurantChain":"Ninety Nine Restaurants","servings":{"number":1.0,"size":null,"unit":null}},{"id":388376,"title":"Cheddar Bacon Sub Papa\'s Burger","image":"https://spoonacular.com/menuItemImages/hamburger.jpg","imageType":"jpg","restaurantChain":"Papa Gino\'s","servings":{"number":1.0,"size":218.0,"unit":"g"}},{"id":420695,"title":"Wisconsin Buttery Burger","image":"https://img.spoonacular.com/menu-items/420695.png","imageType":"png","restaurantChain":"Steak N\' Shake","servings":{"number":1.0,"size":null,"unit":null}},{"id":268457,"title":"Gardein Classic Burger on Multigrain Bun w/ Blue Cheese","image":"https://spoonacular.com/menuItemImages/hamburger.jpg","imageType":"jpg","restaurantChain":"Yard House","servings":{"number":1.0,"size":null,"unit":null}},{"id":362917,"title":"Bleu Cheeseburger","image":"https://spoonacular.com/menuItemImages/cheeseburger.jpg","imageType":"jpg","restaurantChain":"Shari\'s","servings":{"number":1.0,"size":318.0,"unit":"g"}},{"id":236662,"title":"Double Del Cheeseburger","image":"https://spoonacular.com/menuItemImages/cheeseburger.jpg","imageType":"jpg","restaurantChain":"Del Taco","servings":{"number":1.0,"size":null,"unit":null}}],"offset":0,"number":10,"totalMenuItems":2908,"processingTimeMs":136}';

  Map<String, dynamic> jsonData = jsonDecode(jsonString);

  List<dynamic> menuItems = jsonData['menuItems'];

  List<FoodItem> foodItems = menuItems.map((json) => FoodItem.fromJson(json)).toList();

  // Print the list of FoodItems
  foodItems.forEach((foodItem) {
    print('ID: ${foodItem.id}, Title: ${foodItem.title}, Image URL: ${foodItem.imageUrl}, Restaurant Chain: ${foodItem.restaurantChain}, Servings: ${foodItem.servings}');
  });
}
