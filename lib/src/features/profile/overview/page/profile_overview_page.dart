import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_book_store/src/core/config/dependencies.dart';
import 'package:my_book_store/src/core/routes/navigator_keys.dart';
import 'package:my_book_store/src/core/ui/alerts/alerts.dart';
import 'package:my_book_store/src/core/ui/styles/app_colors.dart';
import 'package:my_book_store/src/core/ui/styles/text_style.dart';
import 'package:my_book_store/src/core/ui/widgets/app_book_grid_view.dart';
import 'package:my_book_store/src/core/ui/widgets/app_loader.dart';
import 'package:my_book_store/src/core/ui/widgets/app_profile_image.dart';
import 'package:my_book_store/src/data/models/user/user_model.dart';
import 'package:my_book_store/src/features/books/details/page/book_details_page.dart';
import 'package:my_book_store/src/features/profile/edit/page/edit_profile_page.dart';
import 'package:my_book_store/src/features/profile/overview/bloc/profile_overview_bloc.dart';

class ProfileOverviewPage extends StatefulWidget {
  const ProfileOverviewPage({super.key, required this.user});

  final UserModel user;

  @override
  State<ProfileOverviewPage> createState() => _ProfileOverviewPageState();
}

class _ProfileOverviewPageState extends State<ProfileOverviewPage> {
  UserModel get user => widget.user;
  late final bloc = getIt.get<ProfileOverviewBloc>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bloc.add(ProfileOverviewGetDataEvent(isAdmin: user.isAdmin));
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
      body: BlocConsumer<ProfileOverviewBloc, ProfileOverviewState>(
        bloc: bloc,
        listener: (context, state) {
          if (state is ProfileOverviewFailure) {
            Alerts.showFailure(context, state.error);
          }
        },
        builder: (context, state) {
          if (state is ProfileOverviewLoading) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Center(child: const AppLoader())],
            );
          } else if (state is ProfileOverviewLoaded) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    AppProfileImage(name: user.name, size: Size(106, 106)),
                    const SizedBox(height: 24),
                    Text(
                      user.name,
                      style: context.textStyles.display.mediumBold.copyWith(
                        color: context.colors.grayScale.header,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.store.name,
                      style: context.textStyles.text.medium.copyWith(
                        color: context.colors.grayScale.label,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.store.slogan,
                      style: context.textStyles.text.small.copyWith(
                        color: context.colors.grayScale.label,
                      ),
                    ),
                    const SizedBox(height: 24),
                    OutlinedButton(
                      onPressed: () async {
                        Navigator.push(
                          NavigatorKeys.main.currentContext!,
                          MaterialPageRoute(
                            builder:
                                (context) => EditProfilePage(
                                  user: user,
                                  store: state.store,
                                ),
                          ),
                        );
                        bloc.add(
                          ProfileOverviewGetDataEvent(isAdmin: user.isAdmin),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: context.colors.grayScale.bg,
                        side: BorderSide(
                          color: context.colors.grayScale.line,
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: SizedBox(
                        height: 64,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.edit_outlined,
                              color: context.colors.primary.df,
                              size: 24,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              'Editar',
                              style: context.textStyles.link.medium.copyWith(
                                color: context.colors.primary.df,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    if (user.isAdmin)
                      OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          backgroundColor: context.colors.grayScale.bg,
                          side: BorderSide(
                            color: context.colors.grayScale.line,
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: SizedBox(
                          height: 64,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.local_fire_department_outlined,
                                color: context.colors.primary.df,
                                size: 24,
                              ),
                              const SizedBox(width: 16),
                              Text(
                                'Mais acessados',
                                style: context.textStyles.link.medium.copyWith(
                                  color: context.colors.primary.df,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (!user.isAdmin)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Livros salvos',
                            style: context.textStyles.link.large.copyWith(
                              color: context.colors.grayScale.header,
                            ),
                          ),
                          const SizedBox(height: 24),
                          AppBookGridView(
                            books: state.savedBooks,
                            onTap: (book) async {
                              await Navigator.push(
                                NavigatorKeys.main.currentContext!,
                                MaterialPageRoute(
                                  builder:
                                      (context) => BookDetailsPage(
                                        book: book,
                                        showFromAdminPage: false,
                                      ),
                                ),
                              );
                              bloc.add(
                                ProfileOverviewGetDataEvent(isAdmin: false),
                              );
                            },
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
