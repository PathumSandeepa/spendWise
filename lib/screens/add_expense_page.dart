import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddExpensePage extends StatefulWidget {
  const AddExpensePage({super.key});

  @override
  State<AddExpensePage> createState() => _AddExpensePageState();
}

class _AddExpensePageState extends State<AddExpensePage> {
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedCategory = 'Tea & Snacks'; // Default category

  final List<String> _categories = [
    'Tea & Snacks',
    'Coffee',
    'Gift',
    'Subscription',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        // CORRECTED: The back button should only navigate back.
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Add Amount',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Amount',
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
            TextField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.attach_money, size: 40),
                border: InputBorder.none,
                hintText: '0',
              ),
            ),
            const Divider(color: Colors.grey),
            const SizedBox(height: 30),
            const Text(
              'Expenses made for',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              items: _categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedCategory = newValue;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Description',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: 'Meeting and Snacks with Victor',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ],
        ),
      ),
      // ADDED: A dedicated button to save the expense.
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final title = _selectedCategory;
          final description = _descriptionController.text;
          final amount = double.tryParse(_amountController.text);

          if (title == null ||
              description.isEmpty ||
              amount == null ||
              amount <= 0) {
            print("Invalid data");
            return;
          }

          try {
            await FirebaseFirestore.instance.collection('expenses').add({
              'title': title,
              'description': description,
              'amount': amount,
              'date': Timestamp.now(),
            });

            if (mounted) {
              Navigator.pop(context);
            }
          } catch (e) {
            print("Failed to save expense: $e");
          }
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.check, color: Colors.white),
      ),
    );
  }
}
