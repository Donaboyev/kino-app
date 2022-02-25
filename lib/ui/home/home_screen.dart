import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/home_banner_widget.dart';
import 'widgets/now_playing_widget.dart';
import 'widgets/top_rated_widget.dart';
import 'widgets/discover_widget.dart';
import 'widgets/popular_widget.dart';
import 'widgets/genres_widget.dart';
import 'widgets/people_widget.dart';
import '../ui.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: clrAsset,
        appBar: AppBar(
          backgroundColor: clrTransparent,
          elevation: 0,
          title: Text(
            'Kino App'.toUpperCase(),
            style: styMainAppBar,
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: GetBuilder<HomeController>(
                  builder: (homeController) => controller.isLoading.value
                      ? const Center(child: NutsActivityIndicator())
                      : Column(
                          children: const [
                            HomeBannerWidget(),
                            GenresWidget(),
                            DiscoverWidget(),
                            NowPlayingWidget(),
                            PopularWidget(),
                            TopRatedWidget(),
                            PeopleWidget(),
                          ],
                        ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
