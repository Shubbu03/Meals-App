import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/meal.dart';
import 'package:flutter_complete_guide/widgets/meal_item.dart';


class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/categories-meals';

  final List<Meal>  availableMeal;

  CategoryMealsScreen(this.availableMeal);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;
  var _loadedInitData = false;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      final categoryID = routeArgs['id'];
      displayedMeals = widget.availableMeal.where((meal) {
        return meal.categories.contains(categoryID);
      }).toList();
      _loadedInitData = true;
    }

    super.didChangeDependencies();
  }

  void _removeMeal(String mealID) {
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealID);
    });
  }

  // final String categoryID;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(categoryTitle)),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
                id: displayedMeals[index].id,
                title: displayedMeals[index].title,
                imagrUrl: displayedMeals[index].imageUrl,
                duration: displayedMeals[index].duration,
                affordability: displayedMeals[index].affordability,
                complexity: displayedMeals[index].complexity,
                );
          },
          itemCount: displayedMeals.length,
        ),
        );
  }
}
