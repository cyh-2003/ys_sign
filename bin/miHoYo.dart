import 'package:http/http.dart' as http;
import 'dart:math';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'dart:io';

Random random = Random();
const String salt = r't0qEgfub6cvueAPgR5m9aQWWVciEer7v';

Future<dynamic> miHoYo_Sign(String cookie) async{
  final Uri url = Uri.https('api-takumi.mihoyo.com', 'event/luna/hk4e/sign');
  String ua_version = jsonDecode(await File('data.json').readAsString())['miHoYo_ua_version'];
  http.Response response = await http.post(url,headers: {
    "User-Agent": "Mozilla/5.0 (Linux; Android 12) Mobile miHoYoBBS/$ua_version",
    //"DS": await getDS(),
    "x-rpc-signgame": "hk4e",
    "Referer": "https://act.mihoyo.com/",
    "Cookie": cookie
  },body: jsonEncode({
    "act_id": "e202311201442471",
    "region": "cn_gf01",
    "uid": await getUid(),
    "lang": "zh-cn"
  })
  );
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body) as Map<String, dynamic>;
    if (data[r'retcode'] == 0) {
      return data;
    } else {
      return '请求失败${response.body}';
    }
  } else {
    return '请求失败${response.statusCode}';
  }
}

/// 获取uid
Future<String> getUid() async{
  final String uid = jsonDecode(await File('data.json').readAsString())['miHoYo_uid'];
  if (uid == ''){
    print('请在data.json中填写uid');
    exit(0);
  }
  return uid;
}

/// 获取DS算法
Future<String> getDS() async{
  final String t = (DateTime.now().millisecondsSinceEpoch /1000).toInt().toString();
  final String r = (100000 + random.nextInt(100000)).toString();
  final String body = '{"act_id":"e202311201442471","region":"cn_gf01","uid":"${await getUid()}","lang":"zh-cn"}';
  String main = 'salt=$salt&t=$t&r=$r&b=$body';
  String ds = getMD5(main);
  return "$t,$r,$ds";
}

/// 进行md5加密
String getMD5(String str){
  var content = Utf8Encoder().convert(str);
  return md5.convert(content).toString();
}
