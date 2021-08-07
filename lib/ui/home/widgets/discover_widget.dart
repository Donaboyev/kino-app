import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kino_app/controller/home_controller.dart';
import 'package:kino_app/core/theme/app_colors.dart';
import 'package:kino_app/data/model/response/movie_response.dart';
import 'package:kino_app/ui/home/widgets/movie_item_widget.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';

class DiscoverWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeController) => Column(
        children: [
          const SizedBox(height: 12),
          homeController.isLoading.value
              ? Center(child: NutsActivityIndicator())
              : Container(
                  height: 300,
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (scrollNotification) {
                      if (scrollNotification.metrics.pixels ==
                              scrollNotification.metrics.maxScrollExtent &&
                          scrollNotification is ScrollUpdateNotification) {
                        homeController.getMoviesByGenre();
                        return true;
                      }
                      return false;
                    },
                    child: Stack(
                      children: [
                        ListView.separated(
                          separatorBuilder: (context, index) => VerticalDivider(
                            color: clrTransparent,
                            width: 15,
                          ),
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          physics: const BouncingScrollPhysics(),
                          controller: homeController.scrollController,
                          itemCount: homeController.moviesByGenre.length,
                          itemBuilder: (context, index) {
                            final Movie movie =
                                homeController.moviesByGenre[index];
                            return MovieItemWidget(movie: movie);
                          },
                        ),
                        Obx(
                          () => Visibility(
                            visible: homeController.isDiscoverLoading.value,
                            child: const Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: NutsActivityIndicator(radius: 25),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
