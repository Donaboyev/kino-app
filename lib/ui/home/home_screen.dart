import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kino_app/controller/home_controller.dart';
import 'package:kino_app/core/custom_widgets/nuts_activity_indicator.dart';
import 'package:kino_app/core/theme/app_colors.dart';
import 'package:kino_app/core/theme/text_styles.dart';
import 'package:kino_app/ui/home/widgets/discover_widget.dart';
import 'package:kino_app/ui/home/widgets/genres_widget.dart';
import 'package:kino_app/ui/home/widgets/home_banner_widget.dart';
import 'package:kino_app/ui/home/widgets/now_playing_widget.dart';
import 'package:kino_app/ui/home/widgets/people_widget.dart';
import 'package:kino_app/ui/home/widgets/popular_widget.dart';
import 'package:kino_app/ui/home/widgets/top_rated_widget.dart';

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
                          children: [
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
