import 'package:flutter/foundation.dart';

class AuthUiProvider extends ChangeNotifier {
  bool _submitting = false;
  bool get submitting => _submitting;

  Future<void> submitMockAction() async {
    if (_submitting) return;
    _submitting = true;
    notifyListeners();
    await Future<void>.delayed(const Duration(milliseconds: 450));
    _submitting = false;
    notifyListeners();
  }
}
