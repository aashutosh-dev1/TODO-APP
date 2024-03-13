// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:tasker/core/extensions/app_theme_extensions.dart';

///
enum TextFieldType {
  ///
  text,

  ///
  email,

  ///
  password,

  ///
  number,
}

///
class LabelTextFormField extends StatefulWidget {
  ///
  const LabelTextFormField({
    this.key,
    required this.textFieldController,
    required this.label,
    required this.hintText,
    required this.textFieldType,
    this.enabled,
    this.isLabelBold = false,
    this.textInputAction,
    this.focusNode,
    this.suffixIcon,
    this.maxLines = 1,
    this.onFieldSubmitted,
  }) : super(key: key);

  ///
  final TextEditingController textFieldController;

  ///
  final String label;

  ///
  final String hintText;

  ///
  final TextFieldType textFieldType;

  ///
  final bool? enabled;

  ///
  final bool isLabelBold;

  ///
  final TextInputAction? textInputAction;

  ///
  final FocusNode? focusNode;

  ///
  final Widget? suffixIcon;

  ///
  final int? maxLines;

  ///
  final Key? key;

  ///
  final void Function(String)? onFieldSubmitted;

  @override
  State<LabelTextFormField> createState() => _LabelTextFormFieldState();
}

class _LabelTextFormFieldState extends State<LabelTextFormField> {
  bool isObscure = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isObscure = widget.textFieldType == TextFieldType.password;
    });
  }

  bool isValidEmail(String value) {
    return RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight:
                widget.isLabelBold ? FontWeight.bold : FontWeight.normal,
            color: Colors.black,
          ),
        ),
        const Gap(11),
        TextFormField(
          key: widget.key,
          focusNode: widget.focusNode,
          controller: widget.textFieldController,
          enabled: widget.enabled ?? true,
          obscureText: isObscure,
          validator: (value) {
            if (value!.isEmpty) {
              return 'Field cannot be empty!';
            } else if (widget.textFieldType == TextFieldType.email &&
                !isValidEmail(value)) {
              return 'Invalid email!';
            }
            return null;
          },
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onFieldSubmitted,
          maxLines: widget.maxLines,
          keyboardType: widget.textFieldType == TextFieldType.text
              ? TextInputType.text
              : TextInputType.number,
          decoration: InputDecoration(
            hintText: widget.hintText,
            suffixIcon: widget.textFieldType == TextFieldType.password
                ? InkWell(
                    onTap: () => setState(() {
                      isObscure = !isObscure;
                    }),
                    child: Icon(
                      isObscure
                          ? Icons.remove_red_eye_outlined
                          : Icons.remove_red_eye,
                    ),
                  )
                : widget.suffixIcon ?? const SizedBox(),
            border: const OutlineInputBorder(),
            focusColor: context.colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
