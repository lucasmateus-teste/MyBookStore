import 'package:my_book_store/src/data/dtos/store_create_dto.dart';
import 'package:my_book_store/src/data/dtos/user_create_dto.dart';
import 'package:my_book_store/src/data/models/auth_model.dart';
import 'package:my_book_store/src/data/models/book_model.dart';
import 'package:my_book_store/src/data/models/store_model.dart';
import 'package:my_book_store/src/data/models/user/admin_model.dart';
import 'package:my_book_store/src/data/models/user/employee_model.dart';

final class AppMocks {
  static StoreModel get store => StoreModel(
    id: 1,
    name: "Minha Lojinha",
    slogan: "A melhor lojinha do sul do mundo!",
    banner: "imageBase64",
  );

  static AdminModel get admin => AdminModel(
    id: 1,
    name: "Julio Bitencourt",
    username: "julio.bitencourt",
    store: store,
  );

  static AuthModel get auth => AuthModel(
    token: "eyJ0eXAiOiJKV1...",
    refreshToken: "eyJ0eXAiOiJKV1QiL..",
    user: admin,
    store: store,
  );

  static EmployeeModel get employee1 => EmployeeModel(
    id: 2,
    name: "Fulaninho",
    username: "ful.aninho",
    password: "8ec4sJ7dx!*d",
  );

  static EmployeeModel get employee2 => EmployeeModel(
    id: 3,
    name: "Ciclaninho",
    username: "cic.laninho",
    password: null,
  );

  static BookModel get book => BookModel(
    id: 1,
    title: "O guia de Dart",
    author: "Julio Henrique Bitencourt",
    synopsis: "O MELHOR LIVRO DE DART",
    year: 2022,
    rating: 5,
    available: false,
    cover: "imageBase64",
  );

  static UserCreateDto get userCreateDto => UserCreateDto(
    name: "Julio Bitencourt",
    username: "julio.bitencourt",
    password: "8ec4sJ7dx!*d",
    base64Photo: "imageBase64",
  );

  static StoreCreateDto get storeCreateDto => StoreCreateDto(
    name: "Minha Lojinha",
    slogan: "A melhor lojinha do sul do mundo!",
    base64Banner: "imageBase64",
    admin: userCreateDto,
  );
}
