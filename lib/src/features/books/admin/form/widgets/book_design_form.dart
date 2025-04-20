import 'package:flutter/material.dart';
import 'package:my_book_store/src/core/ui/styles/app_colors.dart';
import 'package:my_book_store/src/core/ui/styles/text_style.dart';
import 'package:my_book_store/src/core/ui/widgets/app_color_picker.dart';
import 'package:my_book_store/src/core/ui/widgets/app_image_pick_button.dart';

class BookDesignForm extends StatefulWidget {
  const BookDesignForm({super.key, this.onImageChanged, this.imageBase64});

  @override
  State<BookDesignForm> createState() => _BookDesignFormState();

  final String? imageBase64;
  final ValueChanged<String?>? onImageChanged;
}

class _BookDesignFormState extends State<BookDesignForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/livro.png'),
          const SizedBox(height: 32),
          AppColorPicker(labelText: 'Cor da capa'),
          const SizedBox(height: 16),
          AppColorPicker(labelText: 'Cor das linhas'),
          const SizedBox(height: 16),
          AppColorPicker(labelText: 'Cor de sombra'),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: AppImagePickButton(
              labelText: 'Selecione a imagem de capa',
              width: 124,
              height: 176,
              intialImageBase64: widget.imageBase64,
              onImageChanged: widget.onImageChanged,
            ),
          ),
          const SizedBox(height: 16),
          const SizedBox(height: 16),
          Text(
            'Tamanho máximo:  124 X 176. Formato: PNG, JPEG',
            style: context.textStyles.text.x.copyWith(
              color: context.colors.grayScale.label,
            ),
          ),
        ],
      ),
    );
  }
}
