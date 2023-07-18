import 'package:flutter/material.dart';
import 'package:meal_app/presentation/screens/category_screen.dart';
import 'package:meal_app/presentation/screens/meals_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {

  //for bottom navigation tab
  int _selectedTabIndex =0;

  void _selectPage(int index){
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    Widget activePage =  const CategoryScreen();
    var activePageTitle = 'Category';

    switch(_selectedTabIndex){
      case 0:
      activePage = CategoryScreen();
      break;
      case 1:
      activePage = const MealsScreen(meals: []);
      activePageTitle = 'Your Favorites';
      break;
      default:
      activePage = CategoryScreen();

    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedTabIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: 'Category'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites')
        ],
        
      ),
    );
  }
}
