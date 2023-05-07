import 'package:flutter/material.dart';
import 'package:tubewithprovider/custom/animate_content.dart';
import 'package:tubewithprovider/custom/loading_widget.dart';
import 'package:tubewithprovider/model/latest_model.dart';
import 'package:tubewithprovider/provider/home_provider.dart';

import '../custom_view/image_view_video.dart';

class HomeVideosPage extends StatefulWidget {
  const HomeVideosPage({super.key});

  @override
  State<HomeVideosPage> createState() => _HomeVideosPageState();
}

class _HomeVideosPageState extends State<HomeVideosPage> {
  HomeProvider latestHome = HomeProvider();

  @override
  void initState() {
    super.initState();
    latestHome.getAllLatestVideos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kids Funny Videos'),
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: StreamBuilder(
          stream: latestHome.getlatestVideos,
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
            return AnimatedContent(
                show: snapshot.data!.isNotEmpty,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    Videos s = snapshot.data![index];
                    return ImageVideoRow(
                        id: s.id,
                        videoId: s.videoId,
                        title: s.videoTitle,
                        category: s.categoryName,
                        watched: s.totelViewer);
                  },
                  itemCount: snapshot.data!.length,
                ));
          }),
    );
  }
}
