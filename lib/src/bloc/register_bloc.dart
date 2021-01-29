import 'dart:async';

import 'package:agroxpress/src/bloc/validators.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

class RegisterBloc with Validators {
  final _nameController = BehaviorSubject<String>();
  final _surnameController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _rePasswordController = BehaviorSubject<String>();

  // Get
  Stream<String> get nameStream =>
      _nameController.stream.transform(nameValidator);
  Stream<String> get surnameStream =>
      _surnameController.stream.transform(surnameValidator);
  Stream<String> get emailStream =>
      _emailController.stream.transform(validatorEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(pwdValidator);
  Stream<String> get rePasswordStream => _rePasswordController.stream
          .transform(rePwdValidator)
          .doOnData((String repwd) {
        if (0 != _passwordController.value.compareTo(repwd)) {
          _rePasswordController.addError("Las contraseñas deben coincidir");
        }
      });

  // Stream<bool> get formValidStream => Rx.combineLatest4(nameStream, emailStream,
  //     passwordStream, rePasswordStream, (n, e, p, rp) => (p == rp));

  // Validator stream
  Stream<bool> get formValidStream => Rx.combineLatest5(
      nameStream,
      surnameStream,
      emailStream,
      passwordStream,
      rePasswordStream,
      (n, sn, e, p, rp) => (p == rp));

  // Set
  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeSurname => _surnameController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeRePassword => _rePasswordController.sink.add;

  // Get latest data
  String get name => _nameController.value;
  String get surname => _surnameController.value;
  String get email => _emailController.value;
  String get password => _passwordController.value;
  String get rePassword => _rePasswordController.value;

  /// Close all streams
  void dispose() {
    _nameController.close();
    _surnameController.close();
    _emailController.close();
    _passwordController.close();
    _rePasswordController.close();
  }
}
