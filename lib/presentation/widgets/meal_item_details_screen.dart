import 'package:flutter/material.dart';
import 'package:meal_app/main.dart';
import 'package:meal_app/models/meal.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItemDetailsScreen extends StatelessWidget {
  const MealItemDetailsScreen(
      {super.key, required this.title, required this.meal, required this.onToggleFavorit});

  final String title;
  final Meal meal;

  //to manage favorite mark
  final void Function(Meal meal) onToggleFavorit;

  @override
  Widget build(BuildContext context) {

    Widget content = Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: ListView( //it is scrolable Column
        children: [
         
          //1 object image (from internet)
          FadeInImage(
            placeholder: MemoryImage(kTransparentImage),
            image: NetworkImage(meal.imageUrl),
            fit: BoxFit.cover,
            height: 200,
            width: double.infinity,
          ), 

          const SizedBox(height: 14),
         
          //2 object text
          Text(
            "Ingridients",
            maxLines: 1,
            textAlign: TextAlign.center,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,fontWeight: FontWeight.bold
            ),
          ),

          const SizedBox(height: 14),

           //3 object list of ingridients
           Column(children: [
              for (final ingridient in meal.ingredients)
              Text(ingridient,  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),)
           ],),

           const SizedBox(height: 14),

            //4 object text
          Text(
            "Steps",
            maxLines: 1,
            textAlign: TextAlign.center,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 14),

           //5 object list of ingridients
           Column(children: [
              for (final step in meal.steps)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8
                ),
                child: Text(step,
                textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
                          ),),
              )
           ],),
        ],
      ),
    );

    return Scaffold(
       appBar: AppBar(title: Text(title),
       actions: [
        IconButton(
          onPressed: (){
            onToggleFavorit(meal);
            },
           icon: const Icon(Icons.star)),
       ],
       ),
       body: content,
    );
  }
}
