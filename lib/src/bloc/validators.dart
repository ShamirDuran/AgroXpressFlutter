import 'dart:async';

class Validators {
  final nameValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (name, sink) {
      if (name.isEmpty) {
        sink.addError("Escriba su nombre");
      } else {
        if (name.length < 3) {
          sink.addError("Debe tener almenos 6 caracteres");
        } else {
          sink.add(name);
        }
      }
    },
  );

  final surnameValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (surname, sink) {
      if (surname.isEmpty) {
        sink.addError("Escriba su apellido");
      } else {
        if (surname.length < 3) {
          sink.addError("Debe tener almenos 3 caracteres");
        } else {
          sink.add(surname);
        }
      }
    },
  );

  final validatorEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp = RegExp(pattern);

      if (regExp.hasMatch(email)) {
        sink.add(email);
      } else {
        sink.addError("El email no es correcto");
      }
    },
  );

  final pwdValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (pwd, sink) {
      if (pwd.length < 6) {
        sink.addError("Debe tener minimo 6 caracteres");
      } else {
        sink.add(pwd);
      }
    },
  );

  final rePwdValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (repwd, sink) {
      if (repwd.isEmpty) {
        sink.addError("Confirme la contraseña");
      } else {
        sink.add(repwd);
      }
    },
  );
}
