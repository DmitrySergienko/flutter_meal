import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:transparent_image/transparent_image.dart';

class MealsItem extends StatelessWidget {
  const MealsItem({super.key, required this.meal, required this.title});

  final Meal meal;
  final String title;

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
        onTap: () {},
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

                    Row(
                      children: [],
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
