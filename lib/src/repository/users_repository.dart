import 'package:dio/dio.dart';
import 'package:users_directory/src/model/user.dart';

abstract class IUsersRepository {
  Future<List<User>> getUsers();
}

class UsersRepository implements IUsersRepository {
  final Dio _dio = Dio();

  final String _url = 'https://randomuser.me/api/?results=50';

  @override
  Future<List<User>> getUsers() async {
    try {
      final response = await _dio.get(_url);

      if (response.statusCode == 200) {
        final users = <User>[];
        try {
          for (final user in response.data['results']) {
            users.add(User.fromJson(user));
          }
        } catch (e) {
          throw Exception(e);
        }

        return users;
      } else {
        throw Exception('Failed to load users.\n(Code ${response.statusCode})');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
