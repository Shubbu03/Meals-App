import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/dummy_data.dart';
import 'package:flutter_complete_guide/screens/filters_screen.dart';
import 'package:flutter_complete_guide/screens/meal_detail_screen.dart';
import 'package:flutter_complete_guide/screens/tabs_screen.dart';
import 'screens/category_meals_screen.dart';
import 'screens/categories_screen.dart';
import 'meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Map<String,bool> _filters = {
    'gluten' : false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeal = DUMMY_MEALS;
  List<Meal> _favoriteMeal = [];

  void _setFilters(Map<String , bool> filterData){
      setState(() {
        _filters = filterData;

        _availableMeal = DUMMY_MEALS.where((meal) {
            
            if(_filters['gluten'] && !meal.isGlutenFree){
              return false;
            }
             if(_filters['lactose'] && !meal.isLactoseFree){
              return false;
            }
             if(_filters['vegan'] && !meal.isVegan){
              return false;
            }
             if(_filters['vegetarian'] && !meal.isVegetarian){
              return false;
            }

            return true;
        }).toList();
      });

  }

   void _toggleFavorite(String mealID){
   final existingIndex = _favoriteMeal.indexWhere((meal) => meal.id == mealID);

    if(existingIndex >= 0){
      setState(() {
        _favoriteMeal.removeAt(existingIndex);
      });
    }
    else{
      setState(() {
        _favoriteMeal.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealID));
      });
    }
   }

   bool _isMealFavorite(String id){
    return _favoriteMeal.any((meal) => meal.id == id);
   }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foodie',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        
        
      ),
      // home: CategoriesScreen(), 
      initialRoute: '/',
      routes: {
        '/': (ctx) => TabsScreen(_favoriteMeal), 
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(_availableMeal),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavorite,_isMealFavorite),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters,_setFilters),
      },

      onGenerateRoute: (settings){
        print(settings.arguments);
        // return MaterialPageRoute(builder: (ctx) => CategoriesScreen(),);
      },

      onUnknownRoute: (settings){
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
      
    );
  }
}

