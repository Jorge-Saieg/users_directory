import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:users_directory/src/repository/users_repository.dart';
import 'package:users_directory/src/controller/users_provider/users_state.dart';
import 'package:users_directory/src/controller/users_provider/users_state_notifier.dart';

///Dependency Injection

//* Logic / StateNotifier
final usersNotifierProvider = StateNotifierProvider<UsersNotifier, UsersState>((ref) => UsersNotifier(
      usersRepository: ref.watch(_usersRepositoryProvider),
    ));

// * Repository
final _usersRepositoryProvider = Provider<IUsersRepository>(
  (ref) => UsersRepository(),
);
