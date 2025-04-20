import 'package:flutter/material.dart';
import 'package:my_book_store/src/core/ui/styles/app_colors.dart';
import 'package:my_book_store/src/core/ui/styles/text_style.dart';

class AppTextInput extends StatefulWidget {
  const AppTextInput({
    super.key,
    this.formKey,
    this.controller,
    this.labelText,
    this.hintText,
    this.obscureText = false,
    this.suffixIconButton,
    this.maxLines = 1,
    this.keyboardType,
    this.validator,
  }) : assert(
         obscureText == true ? suffixIconButton == null : true,
         'obscureText não pode ser enviado em conjunto com suffixIconButton',
       );

  final GlobalKey<FormState>? formKey;
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final bool obscureText;
  final IconButton? suffixIconButton;
  final int maxLines;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  State<AppTextInput> createState() => _AppTextInputState();
}

class _AppTextInputState extends State<AppTextInput> {
  late bool _obscureText = widget.obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.formKey,
      controller: widget.controller,
      obscureText: _obscureText,
      maxLines: widget.maxLines,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        filled: true,
        fillColor: context.colors.grayScale.input,
        labelText: widget.labelText,
        labelStyle: context.textStyles.text.small.copyWith(
          color: context.colors.grayScale.label,
        ),
        hintText: widget.hintText,
        hintStyle: context.textStyles.text.small.copyWith(
          color: context.colors.grayScale.label,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide.none,
        ),
        suffixIcon:
            widget.obscureText
                ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: context.colors.grayScale.header,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
                : widget.suffixIconButton,
      ),
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    );
  }
}
