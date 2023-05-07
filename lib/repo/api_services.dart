import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../model/detail_model.dart';
import '../model/latest_model.dart';
import '../network/api.dart';

class ApiServices extends ChangeNotifier {
  Future<List<Videos>> getHome() async {
    final res = await http.get(Uri.parse(ApiUrl.latestVideos));
    if (res.statusCode == 200) {
      return compute(videoListFromJson, res.body);
    } else {
      throw Exception("Failed to get data");
    }
  }

  Future<List<DetailModel>> getDetail(String id) async {
    final res = await http.get(Uri.parse('${ApiUrl.detailVideos}$id'));
      if (res.statusCode == 200) {
        return compute(detailListFromJson, res.body);
      } else {
        throw Exception("Failed to get data");
      }
  }
}
