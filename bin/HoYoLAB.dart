import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async{
  String HoYoLAB_cookie = jsonDecode(await File('data.json').readAsString())['HoYoLAB_cookie'];
  checkSign(HoYoLAB_cookie);

  HoYoLAB_Sign(HoYoLAB_cookie);
}

/// 此接口可查询签到状态
Future<dynamic> checkSign(String cookie) async{
  final Uri uri = Uri.https(r'sg-hk4e-api.hoyolab.com', 'event/sol/info',{'lang': 'zh-cn','act_id':'e202102251931481'});
  Map<String, String>? head = {'cookie':cookie};
  http.Response response = await http.get(uri,headers: head);
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body) as Map<String, dynamic>;
    if (data[r'retcode'] == 0) {
      print(data);
      return data['data']['is_sign'];
    } else {
      print('请求失败${response.body}');
    }
  } else {
    print('请求失败${response.body}');
  }
}

/// 签到接口
Future<dynamic> HoYoLAB_Sign(String cookie) async{
  final Uri uri = Uri.https(r'sg-hk4e-api.hoyolab.com', 'event/sol/sign',{'lang': 'zh-cn'});
  String ua_version = jsonDecode(await File('data.json').readAsString())['HoYoLAB_ua_version'];
  Map<String, String>? head = {
    'User-Agent': "Mozilla/5.0 (Linux; Android 12) Mobile miHoYoBBSOversea/$ua_version",
    'Referer': "https://act.hoyolab.com/",
    'Cookie':cookie
  };
  http.Response response = await http.post(uri,headers: head,body: jsonEncode({'act_id':'e202102251931481'}));
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

