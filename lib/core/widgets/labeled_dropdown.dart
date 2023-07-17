import '../../core_imports.dart';

class CustomLabeledDropdown extends StatelessWidget {
  final String label;
  final List<dynamic> items;
  final Function onSelect;
  final dynamic selectedValue;
  final String? hint;
  final TextInputType? textInputType;
  final EdgeInsets? contentPadding;
  final String? prefix;
  final TextStyle? labelStyle;
  final bool? obscureText;
  final bool? readOnly;
  final double? borderRadius;
  final Color? bgColor;

  const CustomLabeledDropdown({
    super.key,
    required this.label,
    required this.items,
    required this.onSelect,
    required this.selectedValue,
    this.hint,
    this.textInputType,
    this.contentPadding,
    this.prefix,
    this.labelStyle,
    this.obscureText,
    this.readOnly,
    this.borderRadius,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: labelStyle ?? CustomTextStyle.black14w700(),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius ?? 16),
            border: Border.all(color: Colors.grey.shade400),
            color: bgColor,
          ),
          child: DropdownButton(
            underline: const SizedBox(),
            hint: Text('Pilih $label'),
            value: selectedValue,
            isExpanded: true,
            items: items
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ),
                )
                .toList(),
            onChanged: (value) => onSelect(value),
          ),
        ),
      ],
    );
  }
}
