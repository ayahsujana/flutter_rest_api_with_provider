// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pod_player/pod_player.dart';
import 'package:tubewithprovider/provider/detail_provider.dart';

import '../../custom/loading_widget.dart';
import '../custom_view/image_view_detail.dart';

class DetailVideoPage extends StatefulWidget {
  const DetailVideoPage({super.key});

  @override
  State<DetailVideoPage> createState() => _DetailVideoPageState();
}

class _DetailVideoPageState extends State<DetailVideoPage> {
  DetailProvider detail = DetailProvider();
  late PodPlayerController _podController;

  @override
  void initState() {
    super.initState();
    detail.getDetailVideos(Get.arguments['id']);
    _podController = PodPlayerController(
        playVideoFrom: PlayVideoFrom.youtube(
            'https://youtu.be/${Get.arguments['videoId']}'))
      ..initialise();
  }

  @override
  void dispose() {
    super.dispose();
    _podController.dispose();
    detail.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(children: [
        PodVideoPlayer(
          controller: _podController,
        ),
        Padding(
            padding: const EdgeInsets.all(5),
            child: Expanded(
                child: StreamBuilder(
                    stream: detail.getDetailVideo,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return const Center(
                            child: Text('Connection Not Found'),
                          );
                        case ConnectionState.waiting:
                          return loadingWidget(context);
                        default:
                          if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.hasError}'),
                            );
                          }
                      }
                      return DetailPageView(states: snapshot.data!);
                    })))
      ]),
    ));
  }
}
