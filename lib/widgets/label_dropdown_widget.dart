import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tasker/core/extensions/app_theme_extensions.dart';

///
class LabelDropdownWidget extends StatefulWidget {
  ///
  const LabelDropdownWidget({
    required this.label,
    required this.hint,
    required this.items,
    required this.isLabelBold,
    this.showLabel = true,
    this.isExpanded = true,
    this.value,
    this.onChanged,
    this.onDelete,
    super.key,
  });

  ///
  final String label;

  ///
  final String hint;

  ///
  final List<String> items;

  ///
  final bool isLabelBold;

  ///
  final bool showLabel;

  ///
  final bool isExpanded;

  ///
  final String? value;

  ///
  final void Function(String?)? onChanged;

  ///
  final VoidCallback? onDelete;

  @override
  State<LabelDropdownWidget> createState() => _LabelDropdownWidgetState();
}

class _LabelDropdownWidgetState extends State<LabelDropdownWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showLabel) ...[
          Text(
            widget.label,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight:
                  widget.isLabelBold ? FontWeight.bold : FontWeight.normal,
              color: Colors.black,
            ),
          ),
          const Gap(8),
        ],
        DropdownButtonFormField(
          isExpanded: widget.isExpanded,
          value: widget.value,
          items: widget.items
              .map(
                (e) => DropdownMenuItem(
                  key: Key('drop-down-$e'),
                  value: e,
                  child: Text(e),
                ),
              )
              .toList(),
          onChanged: widget.onChanged,
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Field cannot be empty!';
            }
            return null;
          },
          hint: Text(widget.hint),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            focusColor: context.colorScheme.primary,
          ),
        ),
      ],
    );
  }
}
