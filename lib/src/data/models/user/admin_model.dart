import 'package:my_book_store/src/data/models/store_model.dart';
import 'package:my_book_store/src/data/models/user/user_model.dart';

class AdminModel extends UserModel {
  AdminModel({
    required super.id,
    required super.name,
    required this.store,
    super.username,
  }) : super(type: UserType.admin);

  final StoreModel store;

  factory AdminModel.fromMap(
    Map<String, dynamic> user,
    Map<String, dynamic> store,
  ) {
    return AdminModel(
      id: user['id'] as int,
      name: user['name'] as String,
      username: user['username'] as String?,
      store: StoreModel.fromMap(store),
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'store': store.toMap(), 'role': type.text};
  }
}
