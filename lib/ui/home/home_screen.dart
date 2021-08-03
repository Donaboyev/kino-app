import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kino_app/controller/home/home_controller.dart';
import 'package:kino_app/core/custom_widgets/modal_progress_hud.dart';
import 'package:kino_app/core/theme/app_colors.dart';
import 'package:kino_app/data/model/response/genre_response.dart';
import 'package:kino_app/data/model/response/movie_response.dart';
import 'package:kino_app/ui/home/widgets/discover_widget.dart';
import 'package:kino_app/ui/home/widgets/genres_widget.dart';
import 'package:kino_app/ui/home/widgets/home_banner_widget.dart';
import 'package:kino_app/ui/home/widgets/now_playing_widget.dart';
import 'package:kino_app/ui/home/widgets/people_widget.dart';
import 'package:kino_app/ui/home/widgets/popular_widget.dart';
import 'package:kino_app/ui/home/widgets/top_rated_widget.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';

class HomePage extends GetView<HomeController> {
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
            style: Theme.of(context).textTheme.caption.copyWith(
                  color: clrWhite,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Column(
                  children: [
                    GetBuilder<HomeController>(
                      builder: (homeController) => controller.isLoading.value
                          ? Center(
                              child: NutsActivityIndicator(),
                            )
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
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
