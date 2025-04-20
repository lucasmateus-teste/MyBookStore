import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_book_store/src/core/config/dependencies.dart';
import 'package:my_book_store/src/core/routes/navigator_keys.dart';
import 'package:my_book_store/src/core/ui/alerts/alerts.dart';
import 'package:my_book_store/src/core/ui/styles/app_colors.dart';
import 'package:my_book_store/src/core/ui/styles/text_style.dart';
import 'package:my_book_store/src/core/ui/widgets/app_button.dart';
import 'package:my_book_store/src/core/ui/widgets/app_header.dart';
import 'package:my_book_store/src/core/ui/widgets/app_image_pick_button.dart';
import 'package:my_book_store/src/core/ui/widgets/app_profile_image.dart';
import 'package:my_book_store/src/core/ui/widgets/app_text_input.dart';
import 'package:my_book_store/src/data/models/store_model.dart';
import 'package:my_book_store/src/data/models/user/user_model.dart';
import 'package:my_book_store/src/features/profile/edit/bloc/edit_profile_bloc.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, required this.user, required this.store});

  final UserModel user;
  final StoreModel store;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final bloc = getIt.get<EditProfileBloc>();
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _sloganEC = TextEditingController();
  final _usernameEC = TextEditingController();
  final _passwordEC = TextEditingController();
  final _repeatPasswordEC = TextEditingController();
  late String? _imageBase64;

  @override
  void initState() {
    super.initState();
    _nameEC.text = widget.store.name;
    _sloganEC.text = widget.store.slogan;
    _usernameEC.text = widget.user.username ?? '';
    _imageBase64 = widget.store.banner;
  }

  @override
  void dispose() {
    _nameEC.dispose();
    _sloganEC.dispose();
    _usernameEC.dispose();
    _passwordEC.dispose();
    _repeatPasswordEC.dispose();
    _imageBase64 = null;
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileBloc, EditProfileState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is EditProfileFailure) {
          Alerts.showFailure(context, state.error);
        } else if (state is EditProfileSuccess) {
          Alerts.showSuccess(context, 'Perfil atualizado com sucesso!');
          Navigator.pop(NavigatorKeys.main.currentContext!);
        }
      },
      builder: (context, state) {
        return Scaffold(
          persistentFooterButtons: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
              child: SizedBox(
                width: double.infinity,
                child: AppButton(
                  onPressed: () {
                    final updatedStore = widget.store.copyWith(
                      name: _nameEC.text,
                      slogan: _sloganEC.text,
                    );
                    bloc.add(EditProfileUpdateEvent(store: updatedStore));
                  },
                  child:
                      state is EditProfileLoading
                          ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: context.colors.grayScale.bg,
                              strokeWidth: 2,
                            ),
                          )
                          : Text(
                            'Salvar',
                            style: context.textStyles.link.small.copyWith(
                              color: context.colors.grayScale.bg,
                            ),
                          ),
                ),
              ),
            ),
          ],
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  AppHeader(title: 'Editar Perfil'),
                  const SizedBox(height: 24),
                  AppProfileImage(name: widget.user.name, size: Size(105, 105)),
                  const SizedBox(height: 24),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        AppTextInput(
                          labelText: 'Nome da loja',
                          controller: _nameEC,
                        ),
                        const SizedBox(height: 16),
                        AppTextInput(
                          labelText: 'Slogan da loja',
                          controller: _sloganEC,
                        ),
                        const SizedBox(height: 16),
                        AppTextInput(
                          labelText: 'Nome do usuário',
                          controller: _usernameEC,
                        ),
                        const SizedBox(height: 16),
                        AppTextInput(
                          labelText: 'Senha',
                          obscureText: true,
                          controller: _passwordEC,
                        ),
                        const SizedBox(height: 16),
                        AppTextInput(
                          labelText: 'Repetir senha',
                          obscureText: true,
                          controller: _repeatPasswordEC,
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: AppImagePickButton(
                            labelText: 'Selecione a imagem de banner',
                            intialImageBase64: _imageBase64,
                            onImageChanged: (image) {
                              _imageBase64 = image;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
