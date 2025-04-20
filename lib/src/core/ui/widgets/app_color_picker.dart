import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:my_book_store/src/core/ui/styles/app_colors.dart';
import 'package:my_book_store/src/core/ui/styles/text_style.dart';
import 'package:my_book_store/src/core/ui/widgets/app_button.dart';
import 'package:my_book_store/src/core/ui/widgets/app_text_input.dart';

class AppColorPicker extends StatefulWidget {
  const AppColorPicker({super.key, required this.labelText, this.onChanged});

  final String labelText;
  final ValueChanged<Color>? onChanged;

  @override
  State<AppColorPicker> createState() => _AppColorPickerState();
}

class _AppColorPickerState extends State<AppColorPicker> {
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);
  final _colorEC = TextEditingController();

  void changeColor(Color color) {
    _colorEC.text = color
        .toARGB32()
        .toRadixString(16)
        .toUpperCase()
        .padLeft(8, '0');
    setState(() => pickerColor = color);
    widget.onChanged?.call(color);
  }

  @override
  void dispose() {
    _colorEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppTextInput(
      labelText: widget.labelText,
      controller: _colorEC,
      suffixIconButton: IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: context.colors.grayScale.bg,
                title: Text(
                  'Escolha uma cor',
                  style: context.textStyles.display.medium.copyWith(
                    color: context.colors.grayScale.header,
                  ),
                ),
                content: SingleChildScrollView(
                  child: ColorPicker(
                    pickerColor: pickerColor,
                    onColorChanged: changeColor,
                    // showLabel: true,
                    pickerAreaHeightPercent: 0.8,
                  ),
                ),
                actions: [
                  TextButton(
                    child: Text(
                      'Cancelar',
                      style: context.textStyles.link.small.copyWith(
                        color: context.colors.primary.df,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  Spacer(),
                  AppButton(
                    child: Text(
                      'Selecionar',
                      style: context.textStyles.link.small.copyWith(
                        color: context.colors.grayScale.bg,
                      ),
                    ),
                    onPressed: () {
                      setState(() => currentColor = pickerColor);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        icon: Icon(Icons.color_lens, color: currentColor),
      ),
    );
  }
}
