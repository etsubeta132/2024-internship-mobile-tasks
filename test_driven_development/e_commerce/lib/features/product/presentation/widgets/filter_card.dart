

import 'package:flutter/material.dart';

class FilterCard extends StatefulWidget {
  final void Function(String category, double productValue) onFilter;

  const FilterCard({Key? key, required this.onFilter}) : super(key: key);

  @override
  _FilterCardState createState() => _FilterCardState();
}

class _FilterCardState extends State<FilterCard> {
  double _sliderValue = 0.0;
  String _category = '';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Category Selection',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              onChanged: (value) {
                setState(() {
                  _category = value;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Product Value: $_sliderValue',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            Slider(
              value: _sliderValue,
              min: 0,
              max: 100,
              onChanged: (value) {
                setState(() {
                  _sliderValue = value;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                // Pass selected filters back to parent widget
                widget.onFilter(_category, _sliderValue);
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Apply Filters'),
            ),
          ],
        ),
      ),
    );
  }
}
