import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/presentation/widgets/meals_item.dart';


class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals, required this.onToggleFavorit,
  });

  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavorit;

  @override
  Widget build(BuildContext context) {

    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (ctx, index) => 
      MealsItem(meal: meals[index], title: title?? '',onToggleFavorit: onToggleFavorit,),
    );

    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(),
            Text('The category is empty',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground)),
            const Spacer(),
          ],
        ),
      );
    }

    if(title == null){
      return content;
    }else{
       return Scaffold(
      appBar: AppBar(title: Text(title!)), 
      body: content);
    }
  }
}
