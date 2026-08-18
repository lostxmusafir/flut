import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:adv_basics/data/categories.dart';
import 'package:adv_basics/models/grocery_item.dart';
import 'package:adv_basics/widgets/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  late Future<List<GroceryItem>> _loadedItems;

  @override
  void initState() {
    super.initState();
    _loadedItems = _loadItems();
  }

  Future<List<GroceryItem>> _loadItems() async {
    final url = Uri.https(
        'flutter-course-a0c93-default-rtdb.firebaseio.com', 'shopping-list.json');
    
    final response = await http.get(url);

    if (response.statusCode >= 400) {
      throw Exception('Failed to fetch data. Please try again later.');
    }

    if (response.body == 'null') {
      return [];
    }

    final Map<String, dynamic> listData = json.decode(response.body);
    final List<GroceryItem> loadedItems = [];
    for (final entry in listData.entries) {
      final categoryEntry = categories.entries.firstWhere(
        (catItem) => catItem.value.title == entry.value['category'],
        orElse: () => categories.entries.first,
      );
      final category = categoryEntry.value;

      loadedItems.add(
        GroceryItem(
          id: entry.key,
          name: entry.value['name'],
          quantity: entry.value['quantity'],
          category: category,
        ),
      );
    }

    return loadedItems;
  }

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );

    if (newItem == null) {
      return;
    }

    setState(() {
      _loadedItems = _loadItems();
    });
  }

  void _removeItem(GroceryItem item, List<GroceryItem> items) async {
    final index = items.indexOf(item);
    setState(() {
      items.remove(item);
    });

    final url = Uri.https(
        'flutter-course-a0c93-default-rtdb.firebaseio.com', 'shopping-list/${item.id}.json');
    
    try {
      final response = await http.delete(url);

      if (response.statusCode >= 400) {
        if (!mounted) {
          return;
        }
        setState(() {
          items.insert(index, item);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to delete item. Please try again.'),
          ),
        );
      }
    } catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        items.insert(index, item);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to delete item. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _loadedItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }

          if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No items added yet.'),
            );
          }

          final items = snapshot.data!;

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (ctx, index) => Dismissible(
              onDismissed: (direction) {
                _removeItem(items[index], items);
              },
              key: ValueKey(items[index].id),
              child: ListTile(
                title: Text(items[index].name),
                leading: Container(
                  width: 24,
                  height: 24,
                  color: items[index].category.color,
                ),
                trailing: Text(
                  items[index].quantity.toString(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
