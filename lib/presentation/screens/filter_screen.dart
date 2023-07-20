import 'package:flutter/material.dart';
import 'package:meal_app/presentation/screens/tabs_screen.dart';
import 'package:meal_app/presentation/widgets/filter_widget.dart';
import 'package:meal_app/presentation/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

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

  void _setGluten(bool newValue){
    setState(() {
      _glutineFreeSet = newValue;
    });
  }

  void _setLactose(bool newValue){
    setState(() {
      _lactoseFree = newValue;  // corrected this line
    });
  }

    void _setVegeterian(bool newValue){
    setState(() {
      _VegeterianFree = newValue;  // corrected this line
    });
  }

    void _setVegan(bool newValue){
    setState(() {
      _VeganFree= newValue;  // corrected this line
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your filters'),
      ),
      drawer: MainDrawer(onSelectScreen: (identifier) {
        Navigator.of(context).pop();
        if (identifier == 'Meals') {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (ctx) => TabsScreen()));
        }
      }),
      body: Column(  // removed the const keyword
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
    );
  }
}
