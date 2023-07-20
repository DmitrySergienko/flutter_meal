import 'package:flutter/material.dart';
import 'package:meal_app/presentation/screens/tabs_screen.dart';
import 'package:meal_app/presentation/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FilterScreen();
  }
}

class _FilterScreen extends State<FilterScreen> {
  var _glutineFreeSet = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your filters'),
      ),
      drawer: MainDrawer(onSelectScreen: (identifier){
        Navigator.of(context).pop();
        if(identifier == 'Meals'){
          Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx)=> TabsScreen()));
        }
      }),
      body: Column(
        children: [
          SwitchListTile(
            value: _glutineFreeSet,
            onChanged: (isChecked) {
              setState(() {
                _glutineFreeSet = isChecked;
              });
            },
            title: Text(
              "Gluten free",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            subtitle: Text(
              'Only include gluten free meals',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
            activeColor: Theme.of(context).colorScheme.tertiary,
            contentPadding: EdgeInsets.only(left: 24, right: 22),
          )
        ],
      ),
    );

    throw UnimplementedError();
  }
}
