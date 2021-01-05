import 'package:agroxpress/src/bloc/validators.dart';
import 'package:rxdart/subjects.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  // Get
  Stream<String> get emailStream =>
      _emailController.stream.transform(validatorEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(pwdValidator);

  Stream<bool> get formValidStream =>
      Rx.combineLatest2(emailStream, passwordStream, (a, b) => true);

  // Set
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  // Get latest data
  String get email => _emailController.value;
  String get password => _passwordController.value;

  /// Close all streams
  void dispose() {
    this._emailController.close();
    this._passwordController.close();
  }
}
