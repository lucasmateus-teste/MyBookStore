import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_book_store/src/core/config/dependencies.dart';
import 'package:my_book_store/src/core/routes/navigator_keys.dart';
import 'package:my_book_store/src/core/ui/alerts/alerts.dart';
import 'package:my_book_store/src/core/ui/styles/app_colors.dart';
import 'package:my_book_store/src/core/ui/styles/text_style.dart';
import 'package:my_book_store/src/core/ui/widgets/app_confirmation_dialog.dart';
import 'package:my_book_store/src/core/ui/widgets/app_loader.dart';
import 'package:my_book_store/src/core/ui/widgets/app_profile_image.dart';
import 'package:my_book_store/src/features/employees/list/bloc/employees_bloc.dart';
import 'package:my_book_store/src/features/employees/form/page/employee_form_page.dart';

class EmployeesPage extends StatefulWidget {
  const EmployeesPage({super.key});

  @override
  State<EmployeesPage> createState() => _EmployeesPageState();
}

class _EmployeesPageState extends State<EmployeesPage> {
  late final bloc = getIt.get<EmployeesBloc>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.add(EmployeesGetEmployeesEvent());
    });
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        padding: const EdgeInsets.only(bottom: 68),
        child: FloatingActionButton(
          heroTag: 'registerEmployee',
          onPressed: () async {
            await Navigator.push(
              NavigatorKeys.main.currentContext!,
              MaterialPageRoute(builder: (context) => EmployeeFormPage()),
            );
            bloc.add(EmployeesGetEmployeesEvent());
          },
          backgroundColor: context.colors.primary.df,
          child: Icon(Icons.add, color: context.colors.primary.bg, size: 24),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Funcionários',
              style: context.textStyles.display.hugeBold.copyWith(
                color: context.colors.grayScale.header,
              ),
            ),
            const SizedBox(height: 32),
            BlocConsumer<EmployeesBloc, EmployeesState>(
              bloc: bloc,
              listener: (context, state) {
                if (state is EmployeesFailureState) {
                  Alerts.showFailure(context, state.error);
                } else if (state is EmployeesEmployeeDeletedState) {
                  bloc.add(EmployeesGetEmployeesEvent());
                }
              },
              builder: (context, state) {
                if (state is EmployeesLoadingState) {
                  return const Center(child: AppLoader());
                } else if (state is EmployeesLoadedState) {
                  return Expanded(
                    child: ListView.separated(
                      itemCount: state.employees.length,
                      separatorBuilder:
                          (context, index) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final employee = state.employees[index];
                        return Row(
                          children: [
                            AppProfileImage(name: employee.name),
                            const SizedBox(width: 16),
                            Text(
                              employee.name,
                              style: context.textStyles.link.small.copyWith(
                                color: context.colors.grayScale.body,
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  NavigatorKeys.main.currentContext!,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => EmployeeFormPage(
                                          employee: employee,
                                        ),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.edit_outlined),
                            ),
                            IconButton(
                              onPressed: () {
                                AppConfirmationDialog.show(
                                  context: NavigatorKeys.main.currentContext!,
                                  content: Text.rich(
                                    TextSpan(
                                      text: 'Deseja deletar o funcionário\n',
                                      style: context
                                          .textStyles
                                          .display
                                          .smallBold
                                          .copyWith(
                                            color:
                                                context.colors.grayScale.header,
                                          ),
                                      children: [
                                        TextSpan(
                                          text: employee.name,
                                          style: context
                                              .textStyles
                                              .display
                                              .smallBold
                                              .copyWith(
                                                color:
                                                    context
                                                        .colors
                                                        .grayScale
                                                        .header,
                                              ),
                                        ),
                                        TextSpan(
                                          text: ' ?',
                                          style: context
                                              .textStyles
                                              .display
                                              .smallBold
                                              .copyWith(
                                                color:
                                                    context
                                                        .colors
                                                        .grayScale
                                                        .header,
                                              ),
                                        ),
                                      ],
                                    ),
                                    textAlign:
                                        TextAlign
                                            .center, // Centraliza o texto no diálogo
                                  ),
                                  onConfirm: () {
                                    Navigator.pop(
                                      NavigatorKeys.main.currentContext!,
                                    );
                                    bloc.add(
                                      EmployeesDeleteEmployeeEvent(employee.id),
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Icons.delete_outline),
                            ),
                          ],
                        );
                      },
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
