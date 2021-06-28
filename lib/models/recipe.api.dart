import 'dart:convert';
import 'recipe.dart';
import 'package:http/http.dart' as http;

class RecipeApi {
  // var req = unirest("GET", "https://yummly2.p.rapidapi.com/feeds/list");

  //req.query({
  //  "limit": "18",
  //  "start": "0",
  //  "tag": "list.recipe.popular"
  //});

  //req.headers({
  // "x-rapidapi-key": "9a6a441dd9mshe762d94238b1253p1602a1jsnb735fe311360",
  // "x-rapidapi-host": "yummly2.p.rapidapi.com",
  // "useQueryString": true
  // });
  static Future<List<Recipe>> getRecipe() async {
    var uri = Uri.http('yummly2.p.rapidapi.com', '/feeds/list',
        {"limit": "18", "start": "0", "tag": "list.recipe.popular"});

    final response = await http.get(uri, headers: {
      "x-rapidapi-key": "9a6a441dd9mshe762d94238b1253p1602a1jsnb735fe311360",
      "x-rapidapi-host": "yummly2.p.rapidapi.com",
      "useQueryString": "true"
    });

    Map data = jsonDecode(response.body);
    List _temp = [];

    for (var i in data['feed']) {
      _temp.add(i['content']['details']);
    }
    return Recipe.recipesFromSnapshot(_temp);
  }
}
