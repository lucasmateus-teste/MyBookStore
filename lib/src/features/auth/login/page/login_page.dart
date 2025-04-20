import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_book_store/src/core/routes/routes.dart';
import 'package:my_book_store/src/core/ui/alerts/alerts.dart';
import 'package:my_book_store/src/core/ui/styles/app_colors.dart';
import 'package:my_book_store/src/core/ui/widgets/app_bock_store_icon.dart';
import 'package:my_book_store/src/core/ui/widgets/app_button.dart';
import 'package:my_book_store/src/core/ui/widgets/app_text_input.dart';
import 'package:my_book_store/src/data/models/credentials_model.dart';
import 'package:my_book_store/src/features/auth/login/bloc/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.loginBloc});

  final LoginBloc loginBloc;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc get loginBloc => widget.loginBloc;

  final _formKey = GlobalKey<FormState>();
  final _usernameEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _usernameEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: BlocConsumer<LoginBloc, LoginState>(
        bloc: loginBloc,
        listener: (context, state) {
          if (state is LoginFailureState) {
            Alerts.showFailure(context, state.message);
          } else if (state is LoginSuccessState) {
            Navigator.pushReplacementNamed(
              context,
              Routes.navigation,
              arguments: state.authenticatedUser,
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is LoginLoadingState;

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 64),
                  AppBockStoreIcon(size: Size(132, 145)),
                  const SizedBox(height: 64),
                  Center(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          AppTextInput(
                            controller: _usernameEC,
                            labelText: 'Username',
                            // hintText: 'Enter your username',
                          ),
                          const SizedBox(height: 16),
                          AppTextInput(
                            controller: _passwordEC,
                            labelText: 'Password',
                            obscureText: true,
                            // hintText: 'Enter your password',
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 64),
                  AppButton(
                    onPressed:
                        isLoading
                            ? null
                            : () {
                              final credentials = CredentialsModel(
                                user: _usernameEC.text,
                                password: _passwordEC.text,
                              );
                              loginBloc.add(
                                LoginSubmit(credentials: credentials),
                              );
                            },
                    child: SizedBox(
                      width: double.infinity,
                      child: Center(
                        child:
                            isLoading
                                ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: context.colors.grayScale.bg,
                                  ),
                                )
                                : const Text('Login'),
                      ),
                    ),
                  ),
                  const SizedBox(height: 64),

                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.registerStore);
                    },
                    child: Text(
                      'Cadastre a sua loja',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: context.colors.primary.df,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
