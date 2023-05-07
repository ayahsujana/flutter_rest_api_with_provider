import 'package:flutter/material.dart';
import 'package:tubewithprovider/model/latest_model.dart';
import 'package:tubewithprovider/repo/repo_provider.dart';
import 'package:rxdart/rxdart.dart';

class HomeProvider extends ChangeNotifier {
  RepoProvider repoProvider = RepoProvider();
  BehaviorSubject<List<Videos>> video = BehaviorSubject<List<Videos>>();

  Stream<List<Videos>> get getlatestVideos => video.stream;

  getAllLatestVideos() async {
    List<Videos> home = await repoProvider.getHomeVideos();
    video.sink.add(home);
  }

  @override
  void dispose() {
    super.dispose();
    video.close();
  }
}
