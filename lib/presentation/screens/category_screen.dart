import 'package:flutter/material.dart';
import 'package:meal_app/data/dammy_data.dart';
import 'package:meal_app/presentation/widgets/category_grid_item.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pick your category')),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20, 
            mainAxisSpacing: 20),
        children: [

          //availableCategories.map((category) =>CategoryGridItem(category: category) ).toList() 
          for (final category in availableCategories)
            CategoryGridItem(category: category)
        ],
      ),
    );
  }
}
