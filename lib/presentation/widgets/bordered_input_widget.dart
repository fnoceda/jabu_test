import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BorderedInputWidget extends StatefulWidget {
  final TextEditingController controller;
  final String? initialValue;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final void Function()? onTap;
  final String? hintLabelText;
  final String errorTxt;
  final TextInputType? keyBoardType;
  final TextInputAction? textInputAction;
  final bool? obscureText;
  final Widget? sufixIcon;
  final double borderRound;
  final bool isMoney;
  final String? inputLabelName;
  final bool isEnabled;

  const BorderedInputWidget({
    super.key,
    required this.controller,
    this.hintLabelText,
    this.onChanged,
    this.errorTxt = 'Campo requerido',
    this.keyBoardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.obscureText = false,
    this.initialValue,
    this.validator,
    this.onTap,
    this.sufixIcon,
    this.borderRound = 10,
    this.isMoney = false,
    this.isEnabled = true,
    this.inputLabelName,
  });

  @override
  State<BorderedInputWidget> createState() => _BorderedInputWidgetState();
}

class _BorderedInputWidgetState extends State<BorderedInputWidget> {
  final doneFieldFocus = FocusNode();
  List<TextInputFormatter> inputFormatters = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.inputLabelName != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                widget.inputLabelName!,
              ),
            ),
          TextFormField(
            enabled: widget.isEnabled,
            inputFormatters: inputFormatters,
            // keyboardType: TextInputType.numberWithOptions(decimal: true),
            keyboardType:
                widget.isMoney ? TextInputType.number : TextInputType.text,

            onTap: widget.onTap,
            onChanged: widget.onChanged,
            obscureText: widget.obscureText ?? false,
            controller: widget.controller,
            initialValue: widget.initialValue,
            textInputAction: widget.textInputAction,
            validator: widget.validator,
            decoration: InputDecoration(
              suffixIcon: widget.sufixIcon,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              labelText: widget.hintLabelText,
              labelStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRound),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(widget.borderRound),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
