import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SpendWise'),
        backgroundColor: const Color.fromARGB(255, 55, 190, 21),
      ),
      body: const Center(child: Text('Your expenses will be listed here.')),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Add button pressed!');
        },
        tooltip: 'Add Expense',
        child: const Icon(Icons.add),
      ),
    );
  }
}
