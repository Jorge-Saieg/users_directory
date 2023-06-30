import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:users_directory/src/model/user.dart';
import 'package:users_directory/src/repository/users_repository.dart';
import 'package:users_directory/src/controller/users_provider/users_state.dart';

class UsersNotifier extends StateNotifier<UsersState> {
  UsersNotifier({required IUsersRepository usersRepository})
      : _usersRepository = usersRepository,
        super(const UsersState.loading()) {
    getUsers();
  }
  final IUsersRepository _usersRepository;

  List<User> _usersList = [];
  List<User> get usersList => _usersList;

  List<User> _filteredUsersList = [];
  List<User> get filteredUsersList => _filteredUsersList;
  set filteredUsersList(List<User> value) {
    _filteredUsersList = value;
    state = UsersState.initial(_filteredUsersList);
  }

  Future<void> getUsers() async {
    state = const UsersState.loading();
    try {
      final users = await _usersRepository.getUsers();
      _usersList = users;
      _filteredUsersList = users;
      state = UsersState.initial(_filteredUsersList);
    } catch (_) {
      state = const UsersState.error('Error!!');

      throw Exception('Error!!');
    }
  }

  final TextEditingController _searchController = TextEditingController();
  TextEditingController get searchController => _searchController;

  void filterUsers(String value) {
    _filteredUsersList = _usersList
        .where((user) =>
            user.name.first.toLowerCase().contains(value.toLowerCase()) ||
            user.name.last.toLowerCase().contains(value.toLowerCase()) ||
            user.email.toLowerCase().contains(value.toLowerCase()))
        .toList();
    state = UsersState.initial(_filteredUsersList);
  }
}
