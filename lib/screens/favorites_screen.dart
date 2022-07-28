import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  
  final List<Meal> favouriteMeals;

  FavoritesScreen(this.favouriteMeals);

  @override
  Widget build(BuildContext context) {

    if(favouriteMeals.isEmpty){
     return Center(
      child: Text('You have no favorites - start adding some!'),
    );
    }
    else{
      return ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
                id: favouriteMeals[index].id,
                title: favouriteMeals[index].title,
                imagrUrl: favouriteMeals[index].imageUrl,
                duration: favouriteMeals[index].duration,
                affordability: favouriteMeals[index].affordability,
                complexity: favouriteMeals[index].complexity,
                );
          },
          itemCount: favouriteMeals.length,
        );
    }
    
  }
}