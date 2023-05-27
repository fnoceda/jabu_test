import 'dart:async';

import 'package:flutter/material.dart';

extension DeboucedTextField on TextFormField {
  TextFormField withDebounce({
    required Duration duration,
    required ValueChanged<String> onChanged,
    required TextEditingController controller,
    InputDecoration? decoration,
  }) {
    Timer? debounce;
    return TextFormField(
      textAlign: TextAlign.center,
      decoration: decoration,
      controller: controller,
      onChanged: (value) {
        if (debounce?.isActive ?? false) debounce!.cancel();
        debounce = Timer(duration, () {
          onChanged(value);
        });
      },
    );
  }
}
