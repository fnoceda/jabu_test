import 'package:flutter/material.dart';
import 'package:jabu_test/utils/extensions/debounce_text_field.dart';

class SearchInput extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onChange;

  const SearchInput(
      {super.key, required this.searchController, required this.onChange});
  // final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField().withDebounce(
          decoration: const InputDecoration(
            hintText: 'Search...',
          ),
          controller: searchController,
          duration: const Duration(milliseconds: 800),
          onChanged: (String? value) {
            if (value != null) {
              onChange(value);

              FocusScope.of(context).unfocus();
            }
          }),
    );
  }
}
