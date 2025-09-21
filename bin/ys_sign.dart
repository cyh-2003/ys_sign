import 'dart:convert';
import 'miHoYo.dart';
import 'HoYoLAB.dart';
import 'dart:io';

void main() async {
  String miHoYo_cookie = jsonDecode(
    await File('data.json').readAsString(),
  )['miHoYo_cookie'];
  if (miHoYo_cookie != '') {
    print('开始米游社签到');
    var msg = await miHoYo_Sign(miHoYo_cookie);
    print(msg);
  }
  String HoYoLAB_cookie = jsonDecode(
    await File('data.json').readAsString(),
  )['HoYoLAB_cookie'];
  if (HoYoLAB_cookie != '') {
    print('开始HoYoLAB签到');
    var msg = await HoYoLAB_Sign(HoYoLAB_cookie);
    print(msg);
  }
  print('签到完成');
  sleep(Duration(seconds: 5));
}
