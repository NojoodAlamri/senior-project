
import '../const/messges.dart';

validate(String val, int max, int min) {
  if (val.isEmpty) {
    return messageEmpty;
  }
  if (val.length < min) {
    return "$messagemin$min";
  }
  if (val.length > max) {
    return "$messagemin$max";
  }
  if (val.isEmpty) {
    return messageEmpty;
  }
}
