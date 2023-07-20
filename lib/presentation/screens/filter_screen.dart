import 'package:flutter/material.dart';
import 'package:meal_app/presentation/widgets/filter_widget.dart';



enum Filter {
  gluten,
  lactose,
  vegetarian,
  vegan
}

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key, required this.currentFilters});

  final Map<Filter, bool> currentFilters;

  @override
  State<StatefulWidget> createState() {
    return _FilterScreenState();
  }
}

class _FilterScreenState extends State<FilterScreen> {

  var _glutineFreeSet = false;
  var _lactoseFree = false;
  var _VegeterianFree = false;
  var _VeganFree = false;

  @override
  void initState() {
    _glutineFreeSet = widget.currentFilters[Filter.gluten]!;
    _VegeterianFree = widget.currentFilters[Filter.vegetarian]!;
    _lactoseFree = widget.currentFilters[Filter.lactose]!;
    _VeganFree = widget.currentFilters[Filter.vegan]!;
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
        onWillPop: () async {

          Navigator.of(context).pop({
            //will return to tabs when filter will be set up
            Filter.vegan: _VeganFree,
            Filter.lactose:_lactoseFree,
            Filter.vegetarian:_VegeterianFree,
            Filter.gluten: _glutineFreeSet
          });
          return false;
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
