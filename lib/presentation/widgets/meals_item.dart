import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';

class MealsItem extends StatelessWidget {
  const MealsItem({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(meal.title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            )),
            Text(meal.duration.toString(),
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            )),
             Text(meal.complexity.name,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            )),
             Text(meal.affordability.name,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            )),
    ],); 
  }
}
