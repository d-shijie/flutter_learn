// ignore_for_file: constant_identifier_names

// import 'package:flutter/material.dart';
// import 'package:redux/redux.dart';

class User {
  late String name;
  late int age;
  initState() {
    name = 'jack';
    age = 18;
  }

  User(this.name, this.age);
}

User reducer(User user, action) {
  if (action == UserActions.RESET) {
    return User('jack', 18);
  } else if (action == UserActions.ADD) {
    return User(user.name, user.age + 1);
  }
  return user;
}

enum UserActions {
  RESET,
  ADD,
}
