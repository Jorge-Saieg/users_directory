import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:users_directory/src/model/user.dart';

part 'users_state.freezed.dart';

@freezed
abstract class UsersState with _$UsersState {
  const factory UsersState.initial(List<User> data) = _Initial;

  const factory UsersState.loading() = _Loading;

  const factory UsersState.error(String message) = _Error;
}
