import 'package:flutter/material.dart';
import 'package:meal_app/data/dammy_data.dart';
import 'package:meal_app/models/category.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/presentation/widgets/category_grid_item.dart';

import 'meals_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({
    super.key,
    required this.availableMeal,
  });

  final List<Meal> availableMeal;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        lowerBound: 0,
        upperBound: 1);

    _animationController.forward();
  }

  //animation
  @override
  void dispose() {
    //to be shure the animation will be sw-off avoid memory leak
    super.dispose();
    _animationController.dispose();
  }

  void navigateToMealList(BuildContext context, Category category) {
    //1. match Meal list with concret category filter by category
    //Meal and Category have same parameter id ('c1' 'c2' etc..) if Meal category contains id like in Category
    final listOfMeals = widget.availableMeal
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    //2.navigate to MealsScreen
    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => MealsScreen(
        title: category.title,
        meals: listOfMeals,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        children: [
          //availableCategories.map((category) =>CategoryGridItem(category: category) ).toList()
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectCategory: () {
                navigateToMealList(context, category);
              },
            )
        ],
      ),
      builder: (context, child) => SlideTransition(
          position: Tween(
            begin: const Offset(0, 0.3),
            end: const Offset(0, 0),
          ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut)),
          child: child,
      ),
    );
  }
}
