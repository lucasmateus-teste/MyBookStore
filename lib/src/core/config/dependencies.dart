import 'package:get_it/get_it.dart';
import 'package:my_book_store/src/core/environment/environment.dart';
import 'package:my_book_store/src/core/http/client/dio/dio_http_client.dart';
import 'package:my_book_store/src/core/http/client/http_client.dart';
import 'package:my_book_store/src/core/local_storage/local_storage.dart';
import 'package:my_book_store/src/core/local_storage/shared_pref/shared_pref_local_storage.dart';
import 'package:my_book_store/src/services/auth_service.dart';
import 'package:my_book_store/src/services/book_service.dart';
import 'package:my_book_store/src/services/employee_service.dart';
import 'package:my_book_store/src/services/store_service.dart';
import 'package:my_book_store/src/data/models/book_model.dart';
import 'package:my_book_store/src/data/repositories/book/book_repository.dart';
import 'package:my_book_store/src/data/repositories/book/book_repository_impl.dart';
import 'package:my_book_store/src/data/repositories/employee/employee_repository.dart';
import 'package:my_book_store/src/data/repositories/employee/employee_repository_impl.dart';
import 'package:my_book_store/src/data/repositories/store/store_repository.dart';
import 'package:my_book_store/src/data/repositories/store/store_repository_impl.dart';
import 'package:my_book_store/src/data/repositories/user/user_repository.dart';
import 'package:my_book_store/src/data/repositories/user/user_repository_impl.dart';
import 'package:my_book_store/src/features/auth/login/bloc/login_bloc.dart';
import 'package:my_book_store/src/features/auth/register/bloc/register_store_bloc.dart';
import 'package:my_book_store/src/features/books/admin/form/bloc/book_admin_form_bloc.dart';
import 'package:my_book_store/src/features/books/admin/list/bloc/book_admin_bloc.dart';
import 'package:my_book_store/src/features/books/details/bloc/book_details_bloc.dart';
import 'package:my_book_store/src/features/books/saved/bloc/saved_books_bloc.dart';
import 'package:my_book_store/src/features/employees/form/bloc/employee_form_bloc.dart';
import 'package:my_book_store/src/features/employees/list/bloc/employees_bloc.dart';
import 'package:my_book_store/src/features/home/bloc/home_bloc.dart';
import 'package:my_book_store/src/features/profile/edit/bloc/edit_profile_bloc.dart';
import 'package:my_book_store/src/features/profile/overview/bloc/profile_overview_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  final sharedPrefs = await SharedPreferences.getInstance();

  getIt.registerLazySingleton<HttpClient>(
    () => DioHttpClient(Environment.baseUrl),
  );
  getIt.registerLazySingleton<LocalStorage>(
    () => SharedPrefLocalStorage(sharedPreferences: sharedPrefs),
  );

  //Repositories
  getIt.registerFactory<UserRepository>(
    () => UserRepositoryImpl(httpService: getIt.get<HttpClient>()),
  );
  getIt.registerFactory<StoreRepository>(
    () => StoreRepositoryImpl(httpClient: getIt.get<HttpClient>()),
  );
  getIt.registerFactory<BookRepository>(
    () => BookRepositoryImpl(httpClient: getIt.get<HttpClient>()),
  );
  getIt.registerFactory<EmployeeRepository>(
    () => EmployeeRepositoryImpl(httpClient: getIt.get<HttpClient>()),
  );

  //Services
  getIt.registerFactory(
    () => AuthService(
      userRepository: getIt.get<UserRepository>(),
      storeRepository: getIt.get<StoreRepository>(),
      localStorage: getIt.get<LocalStorage>(),
    ),
  );
  getIt.registerFactory(
    () => BookService(
      repository: getIt.get<BookRepository>(),
      localStorage: getIt.get<LocalStorage>(),
    ),
  );
  getIt.registerFactory(
    () => EmployeeService(
      repository: getIt.get<EmployeeRepository>(),
      localStorage: getIt.get<LocalStorage>(),
    ),
  );
  getIt.registerFactory(
    () => StoreService(
      repository: getIt.get<StoreRepository>(),
      localStorage: getIt.get<LocalStorage>(),
    ),
  );

  //Blocs
  getIt.registerFactory(() => LoginBloc(authService: getIt.get<AuthService>()));
  getIt.registerFactory(
    () => RegisterStoreBloc(authService: getIt.get<AuthService>()),
  );
  getIt.registerFactory(() => HomeBloc(bookService: getIt.get<BookService>()));
  getIt.registerFactory(
    () => BookAdminBloc(bookService: getIt.get<BookService>()),
  );
  getIt.registerFactory(
    () => BookAdminFormBloc(bookService: getIt.get<BookService>()),
  );
  getIt.registerFactoryParam<BookDetailsBloc, BookModel, void>(
    (book, _) =>
        BookDetailsBloc(book: book, bookService: getIt.get<BookService>()),
  );
  getIt.registerFactory(
    () => SavedBooksBloc(bookService: getIt.get<BookService>()),
  );
  getIt.registerFactory(
    () => EmployeesBloc(employeeService: getIt.get<EmployeeService>()),
  );
  getIt.registerFactory(
    () => EmployeeFormBloc(employeeService: getIt.get<EmployeeService>()),
  );
  getIt.registerFactory(
    () => ProfileOverviewBloc(
      storeService: getIt.get<StoreService>(),
      bookService: getIt.get<BookService>(),
    ),
  );
  getIt.registerFactory(
    () => EditProfileBloc(storeRepository: getIt.get<StoreRepository>()),
  );
}
