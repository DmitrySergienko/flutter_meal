import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/presentation/widgets/meal_item_treat.dart';
import 'package:transparent_image/transparent_image.dart';

import 'meal_item_details_screen.dart';

class MealsItem extends StatelessWidget {
  const MealsItem({super.key, required this.meal, required this.title,});

    final Meal meal;
    final String title;


  //to get enom 
  // make first letter upper case 
  String get complexityText {
    return meal.complexity.name[0].toUpperCase() + meal.complexity.name.substring(1);
  }

    String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() + meal.affordability.name.substring(1);
  }


   //Navigation
   goToDetails (BuildContext context){

    Navigator.of(context).push(MaterialPageRoute(
      builder: (ctx) => MealItemDetailsScreen(

        title: meal.title,
        meal: meal,
      )));
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8), 
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child:

          //use InkWell to ha have a clicable option
          InkWell(
        onTap:() => goToDetails(context),
        child: Stack(
          //Stack widget set all widgets top on each other starting with back->front
          children: [

            //1 object image
            FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
                ), // get image from internet
                
            Positioned( 
              bottom: 0, //set positioned object to top of the screen
              right: 0,
              left: 0,
              child: Container(
                color: Colors.black54,
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                child: Column(
                  children: [

                    //2 object text
                    Text(
                      meal.title,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    //3 object
                    const SizedBox(height: 12),

                    //4 object
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center, //set in center 
                      children: [
                         MealItemTreat(icon: Icons.schedule, title: '${meal.duration} min'), 

                         const SizedBox(width:12),

                         MealItemTreat(icon: Icons.work, title: complexityText), 
                         
                         const SizedBox(width:12),

                         MealItemTreat(icon: Icons.attach_money, title: affordabilityText), 
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
