import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/presentation/widgets/filter_widget.dart';
import 'package:meal_app/providers/filter_provider.dart';



class FilterScreen extends ConsumerStatefulWidget {
  const FilterScreen({super.key});


  @override
  ConsumerState<FilterScreen> createState() {
    return _FilterScreenState();
  }
}

class _FilterScreenState extends ConsumerState<FilterScreen> {

  var _glutineFreeSet = false;
  var _lactoseFree = false;
  var _VegeterianFree = false;
  var _VeganFree = false;

  @override
  void initState() {
    //reiverpod
    final activeFilters = ref.read(filterProvider);

    _glutineFreeSet = activeFilters[Filter.gluten]!;
    _VegeterianFree = activeFilters[Filter.vegetarian]!;
    _lactoseFree = activeFilters[Filter.lactose]!;
    _VeganFree = activeFilters[Filter.vegan]!;
    super.initState();
  }

  void _setGluten(bool newValue){
    setState(() {
      _glutineFreeSet = newValue;
    });
  }

  void _setLactose(bool newValue){
    setState(() {
      _lactoseFree = newValue; 
    });
  }

  void _setVegeterian(bool newValue){
    setState(() {
      _VegeterianFree = newValue;  
    });
  }

  void _setVegan(bool newValue){
    setState(() {
      _VeganFree= newValue;  
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: const Text('Your filters'),
      ),
      
      
      // transfer args use WillPopScope
      body: WillPopScope( 
              //will return to tabs when filter will be set up
        onWillPop: () async {
          ref.read(filterProvider.notifier).setFilters({
            Filter.vegan: _VeganFree,
            Filter.lactose:_lactoseFree,
            Filter.vegetarian:_VegeterianFree,
            Filter.gluten: _glutineFreeSet,
        });
          return true;
        },
        child: Column(  // removed the const keyword
          children: [
             FilterWidget(
              title: "Gluten free",
              subtitle: "Only include gluten free meals",
              value: _glutineFreeSet,
              onChanged: _setGluten,
            ),
            FilterWidget(
              title: "Lactose free",
              subtitle: "Only include lactose free meals",
              value: _lactoseFree,
              onChanged: _setLactose,
            ),
            FilterWidget(
              title: "Vegeterian free",
              subtitle: "Only include vegeterian free meals",
              value: _VegeterianFree,
              onChanged: _setVegeterian,
            ),
            FilterWidget(
              title: "Vegan free",
              subtitle: "Only include vegan free meals",
              value: _VeganFree,
              onChanged: _setVegan,
            ),
          ],
        ),
      ),
    );
  }
}
