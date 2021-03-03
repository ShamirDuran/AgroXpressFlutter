import 'dart:async';

import 'package:rxdart/rxdart.dart';

class PurchaseBloc {
  final _amountController = BehaviorSubject<int>();
  static int _availableUnits;

  // Get
  Stream<int> get amountStream =>
      _amountController.stream.transform(amountValidator);

  // Set
  // Function(int) get changeAmount => _amountController.sink.add;
  set changeAmount(String availableUnits) {
    _amountController.sink.add(int.parse(availableUnits));
  }

  set availableUnits(int availableUnits) {
    _availableUnits = availableUnits;
  }

  void dispose() {
    _amountController.close();
  }

  final amountValidator = StreamTransformer<int, int>.fromHandlers(
    handleData: (amount, sink) {
      if (amount > _availableUnits) {
        sink.addError("Cantidad superior a la disponible");
      } else {
        if (amount <= 0) {
          sink.addError("Ingrese una cantidad valida");
        } else {
          sink.add(amount);
        }
      }
    },
  );
}
