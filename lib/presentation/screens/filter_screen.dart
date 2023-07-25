import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/presentation/widgets/filter_widget.dart';
import 'package:meal_app/providers/filter_provider.dart';



class FilterScreen extends ConsumerWidget {
  const FilterScreen({super.key});


  // void _setGluten(bool newValue){
  //   setState(() {
  //     _glutineFreeSet = newValue;
  //   });
  // }

  // void _setLactose(bool newValue){
  //   setState(() {
  //     _lactoseFree = newValue; 
  //   });
  // }

  // void _setVegeterian(bool newValue){
  //   setState(() {
  //     _VegeterianFree = newValue;  
  //   });
  // }

  // void _setVegan(bool newValue){
  //   setState(() {
  //     _VeganFree= newValue;  
  //   });
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final activeFilter = ref.watch(filterProvider);

    return Scaffold(
      
      appBar: AppBar(
        title: const Text('Your filters'),
      ),
      
      body: 
        Column(  // removed the const keyword
          children: [
             FilterWidget(
              title: "Gluten free",
              subtitle: "Only include gluten free meals",
              value: activeFilter[Filter.gluten]!,
              onChanged: (isChecked){
                ref.read(filterProvider.notifier).setFilter(Filter.gluten, isChecked);
               },
            ),

            FilterWidget(
              title: "Lactose free",
              subtitle: "Only include lactose free meals",
              value: activeFilter[Filter.lactose]!,
              onChanged: (isChecked){
                ref.read(filterProvider.notifier).setFilter(Filter.lactose, isChecked);
               },
            ),
            FilterWidget(
              title: "Vegeterian",
              subtitle: "Only include vegeterian meals",
              value: activeFilter[Filter.vegetarian]!,
              onChanged: (isChecked){
                ref.read(filterProvider.notifier).setFilter(Filter.vegetarian, isChecked);
               },
            ),

            FilterWidget(
              title: "Vegan",
              subtitle: "Only include vegan meals",
              value: activeFilter[Filter.vegan]!,
              onChanged: (isChecked){
                ref.read(filterProvider.notifier).setFilter(Filter.vegan, isChecked);
               },
            ),
         
          ],
        ),
      );

  }
}
