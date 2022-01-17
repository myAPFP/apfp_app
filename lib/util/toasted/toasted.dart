import 'package:fluttertoast/fluttertoast.dart';

class Toasted {
  static void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg, toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM);
  }
}