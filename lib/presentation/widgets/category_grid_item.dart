import 'package:flutter/material.dart';
import 'package:meal_app/models/category.dart';


class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({
    super.key,
    required this.category, required this.onSelectCategory,
  });

  final Category category;
  final Function() onSelectCategory;
 

  @override
  Widget build(BuildContext context) {
    var title = category.title;
    return InkWell(
      onTap: onSelectCategory,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                category.color.withOpacity(0.55),
                category.color.withOpacity(0.55),
              ],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            )),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      ),
    );
  }
}
