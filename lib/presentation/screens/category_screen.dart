import 'package:flutter/material.dart';
import 'package:meal_app/data/dammy_data.dart';
import 'package:meal_app/models/category.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/presentation/widgets/category_grid_item.dart';

import 'meals_screen.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key, required this.onToggleFavorit, required this.availableMeal,});
   
   final void Function(Meal meal) onToggleFavorit;

   final List<Meal> availableMeal;

   void navigateToMealList(BuildContext context, Category category) {

    //1. match Meal list with concret category filter by category
    //Meal and Category have same parameter id ('c1' 'c2' etc..) if Meal category contains id like in Category
    final listOfMeals = availableMeal.where((meal) => meal.categories.contains(category.id)).toList();

    //2.navigate to MealsScreen
    Navigator.of(context).push(MaterialPageRoute(
    builder: (ctx) =>MealsScreen(
        title:  category.title,
        meals: listOfMeals,
        onToggleFavorit: onToggleFavorit,
        ),
    ));
  }


  @override
  Widget build(BuildContext context) {
    return  GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20, 
            mainAxisSpacing: 20),
        children: [

          //availableCategories.map((category) =>CategoryGridItem(category: category) ).toList() 
          for (final category in availableCategories)
            CategoryGridItem(category: category,onSelectCategory:() { 
              navigateToMealList(context,category);
            },)
        ],
      );
  }
}
