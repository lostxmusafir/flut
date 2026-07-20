import 'package:flutter/material.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({
    super.key,
    required this.currentFilters,
  });

  final Map<Filter, bool> currentFilters;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFreeFilterActive = false;
  var _lactoseFreeFilterActive = false;
  var _vegetarianFilterActive = false;
  var _veganFilterActive = false;

  @override
  void initState() {
    super.initState();
    _glutenFreeFilterActive = widget.currentFilters[Filter.glutenFree] ?? false;
    _lactoseFreeFilterActive = widget.currentFilters[Filter.lactoseFree] ?? false;
    _vegetarianFilterActive = widget.currentFilters[Filter.vegetarian] ?? false;
    _veganFilterActive = widget.currentFilters[Filter.vegan] ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          Navigator.of(context).pop({
            Filter.glutenFree: _glutenFreeFilterActive,
            Filter.lactoseFree: _lactoseFreeFilterActive,
            Filter.vegetarian: _vegetarianFilterActive,
            Filter.vegan: _veganFilterActive,
          });
        },
        child: Column(
          children: [
            SwitchListTile(
              value: _glutenFreeFilterActive,
              onChanged: (isChecked) {
                setState(() {
                  _glutenFreeFilterActive = isChecked;
                });
              },
              title: Text(
                'Gluten-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              subtitle: Text(
                'Only include gluten-free meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              activeThumbColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            ),
            SwitchListTile(
              value: _lactoseFreeFilterActive,
              onChanged: (isChecked) {
                setState(() {
                  _lactoseFreeFilterActive = isChecked;
                });
              },
              title: Text(
                'Lactose-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              subtitle: Text(
                'Only include lactose-free meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              activeThumbColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            ),
            SwitchListTile(
              value: _vegetarianFilterActive,
              onChanged: (isChecked) {
                setState(() {
                  _vegetarianFilterActive = isChecked;
                });
              },
              title: Text(
                'Vegetarian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              subtitle: Text(
                'Only include vegetarian meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              activeThumbColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            ),
            SwitchListTile(
              value: _veganFilterActive,
              onChanged: (isChecked) {
                setState(() {
                  _veganFilterActive = isChecked;
                });
              },
              title: Text(
                'Vegan',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              subtitle: Text(
                'Only include vegan meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              activeThumbColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            ),
          ],
        ),
      ),
    );
  }
}
