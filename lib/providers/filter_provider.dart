import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/providers/meals_provider.dart';

enum Filter { gluten, lactose, vegetarian, vegan }

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.gluten: false,
          Filter.lactose: false,
          Filter.vegan: false,
          Filter.vegetarian: false
        });

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }

  void setFilters(Map<Filter, bool> choosenFilters) {
    state = choosenFilters;
  }
}

final filterProvider = StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
    (ref) => FilterNotifier());

    final filterMealProvider = Provider((ref) {

      final meals = ref.watch(mealsProvider);
      final activeFilters = ref.watch(filterProvider);

      return meals.where((element) {
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
    });
