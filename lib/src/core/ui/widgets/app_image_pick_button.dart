import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:my_book_store/src/core/routes/navigator_keys.dart';
import 'package:my_book_store/src/core/ui/mixins/camera_mixin.dart';
import 'package:my_book_store/src/core/ui/styles/app_colors.dart';
import 'package:my_book_store/src/core/ui/styles/text_style.dart';
import 'package:my_book_store/src/core/ui/widgets/dashed_rect.dart';

class AppImagePickButton extends StatefulWidget {
  const AppImagePickButton({
    super.key,
    required this.labelText,
    this.intialImageBase64,
    this.onImageChanged,
    this.width,
    this.height,
  });

  final String labelText;
  final String? intialImageBase64;
  final ValueChanged<String?>? onImageChanged;
  final double? width;
  final double? height;

  @override
  State<AppImagePickButton> createState() => _AppImagePickButtonState();
}

class _AppImagePickButtonState extends State<AppImagePickButton>
    with CameraMixin {
  String? imageBase64;
  Uint8List? imageBytes;

  void _removeImage() {
    setState(() {
      imageBytes = null;
    });
  }

  void _setImage(String image) {
    setState(() {
      imageBytes = base64Decode(image);
    });
  }

  @override
  void initState() {
    super.initState();
    final isEmptyImage =
        widget.intialImageBase64 == null ||
        widget.intialImageBase64?.isEmpty == true;
    if (!isEmptyImage) {
      try {
        imageBytes = base64Decode(widget.intialImageBase64!);
      } catch (e) {
        imageBytes = null;
      }
      imageBase64 = widget.intialImageBase64;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        showModalBottomSheet(
          context: NavigatorKeys.main.currentContext!,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          builder: (context) {
            return Container(
              decoration: BoxDecoration(
                color: context.colors.grayScale.bg,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              padding: const EdgeInsets.all(24),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: Icon(Icons.photo_camera_outlined),
                      title: Text(
                        'Tirar foto',
                        style: context.textStyles.text.small,
                      ),
                      onTap: () async {
                        Navigator.pop(NavigatorKeys.main.currentContext!);
                        final imageBase64 = await openCamera(
                          maxWidth: widget.width,
                          maxHeight: widget.height,
                        );
                        if (imageBase64 != null) {
                          _setImage(imageBase64);
                          widget.onImageChanged?.call(imageBase64);
                        }
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.photo_library_outlined),
                      title: Text(
                        'Selecionar da galeria',
                        style: context.textStyles.text.small,
                      ),
                      onTap: () async {
                        Navigator.pop(NavigatorKeys.main.currentContext!);
                        final imageBase64 = await openGallery(
                          maxWidth: widget.width,
                          maxHeight: widget.height,
                        );
                        if (imageBase64 != null) {
                          widget.onImageChanged?.call(imageBase64);
                          _setImage(imageBase64);
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: context.colors.grayScale.bg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: DashedRect(
          color: context.colors.primary.df,
          strokeWidth: 2.5,
          child:
              imageBytes != null
                  ? Center(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.memory(
                                imageBytes!,
                                fit: BoxFit.cover,
                                width: widget.width,
                                height: widget.height,
                                // height: 150,
                              ),
                            ),
                            Positioned(
                              top: -8,
                              right: -8,
                              child: IconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: context.colors.danger.df,
                                ),
                                onPressed: () {
                                  _removeImage();
                                  widget.onImageChanged?.call(null);
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.file_upload_outlined,
                              color: context.colors.primary.df,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              widget.labelText,
                              style: context.textStyles.link.small.copyWith(
                                color: context.colors.primary.df,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                  : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.file_upload_outlined,
                        color: context.colors.primary.df,
                      ),
                      const SizedBox(width: 16),
                      Text(
                        widget.labelText,
                        style: context.textStyles.link.small.copyWith(
                          color: context.colors.primary.df,
                        ),
                      ),
                    ],
                  ),
        ),
      ),
    );
  }
}
