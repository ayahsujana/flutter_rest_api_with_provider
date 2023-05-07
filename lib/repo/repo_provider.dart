import 'package:tubewithprovider/model/detail_model.dart';
import 'package:tubewithprovider/model/latest_model.dart';
import 'package:tubewithprovider/repo/api_services.dart';

class RepoProvider {
  ApiServices apiServices = ApiServices();

  Future<List<Videos>> getHomeVideos() => apiServices.getHome();
  Future<List<DetailModel>> getDetailVideo(String id) => apiServices.getDetail(id);
}
