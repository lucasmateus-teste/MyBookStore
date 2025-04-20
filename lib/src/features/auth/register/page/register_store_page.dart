import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_book_store/src/core/routes/routes.dart';
import 'package:my_book_store/src/core/ui/alerts/alerts.dart';
import 'package:my_book_store/src/core/ui/styles/app_colors.dart';
import 'package:my_book_store/src/core/ui/styles/text_style.dart';
import 'package:my_book_store/src/core/ui/widgets/app_bock_store_icon.dart';
import 'package:my_book_store/src/core/ui/widgets/app_button.dart';
import 'package:my_book_store/src/core/ui/widgets/app_header.dart';
import 'package:my_book_store/src/core/ui/widgets/app_image_pick_button.dart';
import 'package:my_book_store/src/core/ui/widgets/app_text_input.dart';
import 'package:my_book_store/src/data/dtos/store_create_dto.dart';
import 'package:my_book_store/src/data/dtos/user_create_dto.dart';
import 'package:my_book_store/src/features/auth/register/bloc/register_store_bloc.dart';

class RegisterStorePage extends StatefulWidget {
  const RegisterStorePage({super.key, required this.registerStoreBloc});

  final RegisterStoreBloc registerStoreBloc;

  @override
  State<RegisterStorePage> createState() => _RegisterStorePageState();
}

class _RegisterStorePageState extends State<RegisterStorePage> {
  RegisterStoreBloc get registerStoreBloc => widget.registerStoreBloc;

  final _formKey = GlobalKey<FormState>();
  final _storeNameEC = TextEditingController();
  final _storeSloganEC = TextEditingController();
  final _adminNameEC = TextEditingController();
  final _adminPhotoEC = TextEditingController();
  final _adminUsernameEC = TextEditingController();
  final _adminPasswordEC = TextEditingController();
  final _adminPasswordRepeatEC = TextEditingController();
  String? _storeBanner;

  @override
  void dispose() {
    _storeNameEC.dispose();
    _storeSloganEC.dispose();
    _adminNameEC.dispose();
    _adminPhotoEC.dispose();
    _adminUsernameEC.dispose();
    _adminPasswordEC.dispose();
    _adminPasswordRepeatEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterStoreBloc, RegisterStoreState>(
      listener: (context, state) {
        if (state is RegisterStoreSuccessState) {
          Alerts.showSuccess(context, 'Loja cadastrada com sucesso!');
          Navigator.pushReplacementNamed(
            context,
            Routes.navigation,
            arguments: state.authenticatedUser,
          );
        } else if (state is RegisterStoreFailureState) {
          Alerts.showFailure(context, state.message);
        }
      },
      bloc: registerStoreBloc,
      builder: (context, state) {
        final isLoading = state is RegisterStoreLoadingState;

        return Scaffold(
          persistentFooterButtons: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
              child: SizedBox(
                width: double.infinity,
                child: AppButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      final admin = UserCreateDto(
                        name: _adminNameEC.text,
                        username: _adminUsernameEC.text,
                        password: _adminPasswordEC.text,
                        base64Photo: _adminPhotoEC.text,
                      );

                      registerStoreBloc.add(
                        RegisterStoreSubmit(
                          store: StoreCreateDto(
                            name: _storeNameEC.text,
                            slogan: _storeSloganEC.text,
                            base64Banner: _storeBanner ?? '',
                            admin: admin,
                          ),
                        ),
                      );
                    }
                  },
                  child:
                      isLoading
                          ? CircularProgressIndicator(
                            color: AppColors.i.grayScale.bg,
                            strokeWidth: 2,
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
                  AppHeader(title: 'Cadastrar Loja'),
                  const SizedBox(height: 32),
                  AppBockStoreIcon(size: Size(132, 145)),
                  const SizedBox(height: 32),
                  Form(
                    key: _formKey,
                    child: Column(
                      spacing: 16,
                      children: [
                        AppTextInput(
                          labelText: 'Nome da Loja',
                          controller: _storeNameEC,
                        ),
                        AppTextInput(
                          labelText: 'Slogan da loja',
                          controller: _storeSloganEC,
                        ),
                        AppTextInput(
                          labelText: 'Nome do administrador',
                          controller: _adminNameEC,
                        ),
                        AppTextInput(
                          labelText: 'Usuario do administrador',
                          controller: _adminUsernameEC,
                        ),
                        AppTextInput(
                          labelText: 'Senha',
                          controller: _adminPasswordEC,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'A senha é obrigatória.';
                            }
                            if (value.length < 6 || value.length > 10) {
                              return 'A senha deve ter entre 6 e 10 caracteres.';
                            }
                            if (!RegExp(r'[A-Z]').hasMatch(value)) {
                              return 'A senha deve conter pelo menos uma letra maiúscula.';
                            }
                            if (!RegExp(
                              r'[!@#$%^&*(),.?":{}|<>]',
                            ).hasMatch(value)) {
                              return 'A senha deve conter pelo menos um caractere especial.';
                            }
                            return null;
                          },
                        ),
                        AppTextInput(
                          labelText: 'Repetir senha',
                          controller: _adminPasswordRepeatEC,
                          obscureText: true,
                          validator: (value) {
                            if (value != _adminPasswordEC.text) {
                              return 'As senhas não coincidem.';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: AppImagePickButton(
                            labelText: 'Selecione a imagem de banner',
                            onImageChanged: (image) {
                              _storeBanner = image;
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
