import 'package:flutter/material.dart';

class CategoryFilter extends StatelessWidget {
  final List<String> categories;
  final String selected;
  final Function(String) onSelect;

  const CategoryFilter({
    super.key,
    required this.categories,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: categories.map((cat) {
        final bool active = cat == selected;
        return GestureDetector(
          onTap: () => onSelect(cat),
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            decoration: BoxDecoration(
              color: active ? Colors.red : Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              cat,
              style: TextStyle(color: active ? Colors.white : Colors.black),
            ),
          ),
        );
      }).toList(),
    );
  }
}
