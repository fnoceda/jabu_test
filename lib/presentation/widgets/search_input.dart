import 'package:flutter/material.dart';
import 'package:jabu_test/utils/extensions/debounce_text_field.dart';

class SearchInput extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onChange;

  const SearchInput(
      {super.key, required this.searchController, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField().withDebounce(
          key: const Key('SearchKey'),
          decoration: const InputDecoration(
            hintText: 'Search...',
          ),
          controller: searchController,
          duration: const Duration(milliseconds: 800),
          onChanged: (String? value) {
            if (value != null) {
              FocusScope.of(context).unfocus();
              onChange(value);
            }
          }),
    );
  }
}
