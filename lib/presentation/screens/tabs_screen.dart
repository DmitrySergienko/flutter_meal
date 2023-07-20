import 'package:flutter/material.dart';
import 'package:meal_app/data/dammy_data.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/presentation/screens/category_screen.dart';
import 'package:meal_app/presentation/screens/filter_screen.dart';
import 'package:meal_app/presentation/screens/meals_screen.dart';
import 'package:meal_app/presentation/widgets/main_drawer.dart';


const kInitialFilters = {
   Filter.gluten: false,
    Filter.vegan:false,
    Filter.lactose:false,
    Filter.vegetarian:false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  //for bottom navigation tab
  int _selectedTabIndex = 0;

  //to manage favorit meal
  final List<Meal> _favoritMeal = [];

  //to keep filter result use map as a container
  Map<Filter,bool> _selectedFilters = kInitialFilters;

  
  

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleFavorit(Meal meal) {
    final isExisting = _favoritMeal.contains(meal);
    if (isExisting) {
      setState(() {
        _favoritMeal.remove(meal);
      });
      _showInfoMessage("Meal in no longer a Fovorite");
    } else {
      setState(() {
        _favoritMeal.add(meal);
      });
      _showInfoMessage("Add to Favorite");
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

//async await use when the action will be in future 
  void _setSelectedScreen(String identifier) async {
    
    if (identifier == 'Filters') {
        //navigate to FilterScreen
        //result it will be map (collecton of key and values) where key is Filter and value bool
        final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) =>  FilterScreen(currentFilters: _selectedFilters,)),
      );
      print('result: $result');

      //update the map (we use it us conteiner where we keep our filters bool)
      //kInitialFilters - default values
      setState(() {
          _selectedFilters =result ?? kInitialFilters;
      });
    
    } 
    
    Navigator.of(context).pop(); // You can call pop() here, if you want to close the drawer after selecting a screen
}


  @override
  Widget build(BuildContext context) {

    final availableMeals = dummyMeals.where((element) {
      if(_selectedFilters[Filter.gluten]! && !element.isGlutenFree){
          return false;
        }
         if(_selectedFilters[Filter.lactose]! && !element.isLactoseFree){
          return false;
        }
         if(_selectedFilters[Filter.vegetarian]! && !element.isVegetarian){
          return false;
        }
         if(_selectedFilters[Filter.vegan]! && !element.isVegan){
          return false;
        }
        return true;
    } ).toList();
        
    

    Widget activePage = CategoryScreen(
      onToggleFavorit: _toggleFavorit,
      availableMeal: availableMeals,
    );
    var activePageTitle = 'Category';

    switch (_selectedTabIndex) {
      case 0:
        activePage = CategoryScreen(
          onToggleFavorit: _toggleFavorit,
          availableMeal: availableMeals,
        );
        break;
      case 1:
        activePage = MealsScreen(
          meals: _favoritMeal,
          onToggleFavorit: _toggleFavorit,
        );
        activePageTitle = 'Your Favorites';
        break;
      default:
        activePage = CategoryScreen(
          onToggleFavorit: _toggleFavorit,
          availableMeal: availableMeals,
        );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setSelectedScreen,
        
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedTabIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Category'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites')
        ],
      ),
    );
  }
}
