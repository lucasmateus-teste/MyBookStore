import 'package:flutter/material.dart';
import 'package:my_book_store/src/core/ui/styles/app_colors.dart';
import 'package:my_book_store/src/core/ui/styles/text_style.dart';
import 'package:my_book_store/src/core/ui/widgets/app_star_rating.dart';
import 'package:my_book_store/src/core/ui/widgets/app_text_input.dart';
import 'package:my_book_store/src/core/ui/widgets/app_toogle.dart';

class BookDetailsForm extends StatelessWidget {
  const BookDetailsForm({
    super.key,
    required this.formKey,
    required this.titleController,
    required this.authorController,
    required this.synopsisController,
    required this.dateController,
    this.rating = 0,
    this.isAvailable = false,
    this.onRatingChanged,
    this.onStatusChanged,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController authorController;
  final TextEditingController synopsisController;
  final TextEditingController dateController;
  final int rating;
  final bool isAvailable;
  final ValueChanged<int>? onRatingChanged;
  final ValueChanged<bool>? onStatusChanged;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          AppTextInput(labelText: 'Título', controller: titleController),
          const SizedBox(height: 16),
          AppTextInput(labelText: 'Autor', controller: authorController),
          const SizedBox(height: 16),
          AppTextInput(
            labelText: 'Sinópse',
            maxLines: 4,
            controller: synopsisController,
          ),
          const SizedBox(height: 16),
          AppTextInput(
            labelText: 'Ano de publicação',
            controller: dateController,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Avaliação',
                style: context.textStyles.text.small.copyWith(
                  color: context.colors.grayScale.label,
                ),
              ),
              AppStarRating(
                initialRating: rating,
                onRatingChanged: (value) {
                  onRatingChanged?.call(value);
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Status',
                style: context.textStyles.text.small.copyWith(
                  color: context.colors.grayScale.label,
                ),
              ),
              AppToogle(
                value: isAvailable,
                onChanged: (value) {
                  onStatusChanged?.call(value);
                },

                child: Row(
                  children: [
                    const SizedBox(width: 8),
                    Text(
                      'Estoque',
                      style: context.textStyles.text.small.copyWith(
                        color: context.colors.grayScale.header,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
