
 import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/meal.dart';

class FavoritMealsNotifier extends StateNotifier<List<Meal>>{
  FavoritMealsNotifier(super.state);


  bool toggleMealFavoritStatus(Meal meal){
    final mealIsFavorite =  state.contains(meal);

    if(mealIsFavorite){
      state = state.where((element) => element.id != meal.id ).toList();
      return true;
    }else{
      state =[...state,meal];
      return false;
    }


    state = [];
  }
}

final favoritMealProvider = StateNotifierProvider<FavoritMealsNotifier, List<Meal>>((ref) => 
  FavoritMealsNotifier([])
);