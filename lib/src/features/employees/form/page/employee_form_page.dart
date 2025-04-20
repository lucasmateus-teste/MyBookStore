import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_book_store/src/core/config/dependencies.dart';
import 'package:my_book_store/src/core/routes/navigator_keys.dart';
import 'package:my_book_store/src/core/ui/alerts/alerts.dart';
import 'package:my_book_store/src/core/ui/styles/app_colors.dart';
import 'package:my_book_store/src/core/ui/styles/text_style.dart';
import 'package:my_book_store/src/core/ui/widgets/app_button.dart';
import 'package:my_book_store/src/core/ui/widgets/app_header.dart';
import 'package:my_book_store/src/core/ui/widgets/app_profile_image.dart';
import 'package:my_book_store/src/core/ui/widgets/app_text_input.dart';
import 'package:my_book_store/src/data/models/user/employee_model.dart';
import 'package:my_book_store/src/features/employees/form/bloc/employee_form_bloc.dart';

class EmployeeFormPage extends StatefulWidget {
  const EmployeeFormPage({super.key, this.employee});

  final EmployeeModel? employee;

  @override
  State<EmployeeFormPage> createState() => _EmployeeFormPageState();
}

class _EmployeeFormPageState extends State<EmployeeFormPage> {
  EmployeeModel? get employee => widget.employee;

  late final bloc = getIt.get<EmployeeFormBloc>();
  late final bool isEditMode = employee != null;
  late final TextEditingController _nameEC;
  late final TextEditingController _usernameEC;
  late final TextEditingController _passwordEC;

  @override
  void initState() {
    super.initState();
    _nameEC = TextEditingController(text: widget.employee?.name ?? '');
    _usernameEC = TextEditingController(text: widget.employee?.username ?? '');
    _passwordEC = TextEditingController(text: widget.employee?.password ?? '');
  }

  @override
  void dispose() {
    _nameEC.dispose();
    _usernameEC.dispose();
    _passwordEC.dispose();
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeFormBloc, EmployeeFormState>(
      bloc: bloc,
      listener: (context, state) {
        if (state is EmployeeFormFailureState) {
          Alerts.showFailure(context, state.error);
        } else if (state is EmployeeFormCreatedState) {
          Alerts.showSuccess(context, 'Funcionário criado com sucesso!');
          Navigator.pop(NavigatorKeys.main.currentContext!);
        } else if (state is EmployeeFormUpdatedState) {
          Alerts.showSuccess(context, 'Funcionário atualizado com sucesso!');
          Navigator.pop(NavigatorKeys.main.currentContext!);
        }
      },
      builder: (context, state) {
        return Scaffold(
          extendBody: true,
          persistentFooterButtons: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
              child: SizedBox(
                width: double.infinity,
                child: AppButton(
                  onPressed: () {
                    if (isEditMode) {
                      final updatedEmployee = employee!.copyWith(
                        name: _nameEC.text,
                        username: _usernameEC.text,
                        password: _passwordEC.text,
                      );
                      bloc.add(EmployeeFormUpdateEvent(updatedEmployee));
                    } else {
                      final newEmployee = EmployeeModel(
                        id: -1,
                        name: _nameEC.text,
                        username: _usernameEC.text,
                        password: _passwordEC.text,
                      );
                      bloc.add(EmployeeFormCreateEvent(newEmployee));
                    }
                  },
                  child:
                      (state is EmployeeFormLoadingState)
                          ? SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: context.colors.grayScale.bg,
                            ),
                          )
                          : Text(
                            isEditMode ? 'Atualizar' : 'Salvar',
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
                  const SizedBox(height: 32),
                  AppHeader(
                    title:
                        isEditMode ? 'Editar Funcionário' : 'Novo Funcionário',
                  ),
                  const SizedBox(height: 32),
                  AppProfileImage(name: _nameEC.text, size: Size(105, 105)),
                  const SizedBox(height: 32),
                  AppTextInput(controller: _nameEC, labelText: 'Nome'),
                  const SizedBox(height: 16),
                  AppTextInput(controller: _usernameEC, labelText: 'Usuário'),
                  const SizedBox(height: 16),
                  AppTextInput(
                    controller: _passwordEC,
                    labelText: 'Senha',
                    obscureText: true,
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
