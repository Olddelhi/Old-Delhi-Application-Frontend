import 'package:flutter/material.dart';

class RoundedDropdown extends StatefulWidget {
  final List<String> items;

  const RoundedDropdown({Key? key, required this.items}) : super(key: key);

  @override
  _RoundedDropdownState createState() => _RoundedDropdownState();
}

class _RoundedDropdownState extends State<RoundedDropdown> {
  String? _selectedItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey[200],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: DropdownButton<String>(
        isExpanded: true,
        underline: const SizedBox(),
        value: _selectedItem,
        onChanged: (String? value) {
          setState(() {
            _selectedItem = value;
          });
        },
        items: widget.items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
