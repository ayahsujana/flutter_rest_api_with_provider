import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tubewithprovider/model/detail_model.dart';

import '../repo/repo_provider.dart';

class DetailProvider extends ChangeNotifier {
  RepoProvider repoProvider = RepoProvider();
  BehaviorSubject<List<DetailModel>> detail = BehaviorSubject<List<DetailModel>>();

  Stream<List<DetailModel>> get getDetailVideo => detail.stream;

  getDetailVideos(String id) async {
    List<DetailModel> vDetail = await repoProvider.getDetailVideo(id);
    detail.sink.add(vDetail);
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    detail.close();
  }
}
