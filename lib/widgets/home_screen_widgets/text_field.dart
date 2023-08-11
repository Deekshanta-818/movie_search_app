import 'package:flutter/material.dart';

class TextInput extends StatefulWidget {
  final void Function(String query) onQuery;

  const TextInput({super.key, required this.onQuery});

  @override
  // ignore: library_private_types_in_public_api
  _TextInputState createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Search Movies...',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            widget.onQuery(_searchController.text);
          },
        ),
      ),
    );
  }
}
