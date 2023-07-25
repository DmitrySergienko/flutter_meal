import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/presentation/screens/category_screen.dart';
import 'package:meal_app/presentation/screens/filter_screen.dart';
import 'package:meal_app/presentation/screens/meals_screen.dart';
import 'package:meal_app/presentation/widgets/main_drawer.dart';
import 'package:meal_app/providers/favorit_meal_provider.dart';
import 'package:meal_app/providers/filter_provider.dart';
import 'package:meal_app/providers/meals_provider.dart';


const kInitialFilters = {
   Filter.gluten: false,
    Filter.vegan:false,
    Filter.lactose:false,
    Filter.vegetarian:false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {

  //for bottom navigation tab
  int _selectedTabIndex = 0;

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
        await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FilterScreen(),
          ),
      );
    } 
    
    Navigator.of(context).pop(); //close the drawer after selecting a screen
}


  @override
  Widget build(BuildContext context) {

    //riverpod
    final meals = ref.watch(mealsProvider);
    final activeFilters = ref.watch(filterProvider);

    final availableMeals = meals.where((element) {
      if(activeFilters[Filter.gluten]! && !element.isGlutenFree){
          return false;
        }
         if(activeFilters[Filter.lactose]! && !element.isLactoseFree){
          return false;
        }
         if(activeFilters[Filter.vegetarian]! && !element.isVegetarian){
          return false;
        }
         if(activeFilters[Filter.vegan]! && !element.isVegan){
          return false;
        }
        return true;
    } ).toList();
        
    

    Widget activePage = CategoryScreen(
      
      availableMeal: availableMeals,
    );
    var activePageTitle = 'Category';


    //riverpod
    final favoritMeals =  ref.watch(favoritMealProvider);

    switch (_selectedTabIndex) {

     

      case 0:
        activePage = CategoryScreen(
          
          availableMeal: availableMeals,
        );
        break;
      case 1:

        activePage = MealsScreen(
          meals: favoritMeals,
          
        );
        activePageTitle = 'Your Favorites';
        break;
      default:
        activePage = CategoryScreen(
          
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
