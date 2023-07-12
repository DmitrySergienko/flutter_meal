import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';


class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    required this.title,
    required this.meals,
  });

  final String title;
  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {

    Widget content = ListView.builder(
      itemBuilder: (ctx, index) => 
      Text(title),
    );

    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Spacer(),
            Text('The category is empty',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground)),
            Spacer(),
          ],
        ),
      );
    }

    return Scaffold(appBar: AppBar(title: Text(title)), body: content);
  }
}
