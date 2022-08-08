import 'package:dio/dio.dart';
import 'package:wydad/model/pray_time.dart';

class WebServices {
  var dio = Dio();
  Future<PrayTime> getPraytime() async {
    String url = 'http://api.aladhan.com/v1/timingsByAddress?address=cairo';
    final response = await dio.get(url);
    if (response.statusCode == 200) {
      final result = response.data;
      var list = result['data']['timings'];
      print('ssssssss$list');
      var lists = PrayTime.fromJson(list);
      //  print('rrrrrr$lists');
      return lists;
    } else {
      throw Exception('Faild To Get Data');
    }
  }
}
