import 'package:flutter/material.dart';

import 'bordered_input_widget.dart';

class SearchBoxWidget extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String?)? onChanged;
  const SearchBoxWidget({super.key, required this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: BorderedInputWidget(
        key: const Key('SearchBoxWidget.Key'),
        controller: controller,
        hintLabelText: '',
        onChanged: (value) => onChanged,
      ),
    );
  }
}

/*
class SearchBoxWidget extends StatefulWidget {
  final TextEditingController controller;

  const SearchBoxWidget({
    super.key,
    required this.controller,
  });

  @override
  State<SearchBoxWidget> createState() => _SearchBoxWidgetState();
}

class _SearchBoxWidgetState extends State<SearchBoxWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: BorderedInputWidget(
        key: const Key('SearchBoxWidget.Key'),
        controller: widget.controller,
        hintLabelText: '',
        onChanged: (value) {},
      ),
    );
  }
}

*/
