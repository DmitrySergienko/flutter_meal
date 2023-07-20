import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/presentation/screens/category_screen.dart';
import 'package:meal_app/presentation/screens/filter_screen.dart';
import 'package:meal_app/presentation/screens/meals_screen.dart';
import 'package:meal_app/presentation/widgets/main_drawer.dart';

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

  void _setSelectedScreen(String identifier) {

    //alwais calos drawer
    Navigator.of(context).pop();

    if (identifier == 'Filters') {
      //navigate to FilterScreen
      Navigator.of(context).push(
        MaterialPageRoute(builder: (ctx) => const FilterScreen()),
      );
    } 
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoryScreen(
      onToggleFavorit: _toggleFavorit,
    );
    var activePageTitle = 'Category';

    switch (_selectedTabIndex) {
      case 0:
        activePage = CategoryScreen(
          onToggleFavorit: _toggleFavorit,
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
