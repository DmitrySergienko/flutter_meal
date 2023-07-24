import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/data/dammy_data.dart';

final mealsProvider = Provider((ref) => dummyMeals);
