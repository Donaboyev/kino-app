import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kino_app/controller/home_controller.dart';
import 'package:kino_app/core/theme/app_colors.dart';
import 'package:kino_app/data/model/response/movie_response.dart';
import 'package:kino_app/routes/app_routes.dart';
import 'package:kino_app/ui/home/widgets/category_title_widget.dart';
import 'package:kino_app/ui/home/widgets/movie_item_widget.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';

class PopularWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeController) => Column(
        children: [
          CategoryTitleWidget(
            title: 'Popular',
            onTap: () {
              Get.toNamed(AppRoutes.POPULAR_MORE);
            },
          ),
          const SizedBox(height: 12),
          homeController.isLoading.value
              ? const Center(child: const NutsActivityIndicator())
              : Container(
                  height: 300,
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (scrollNotification) {
                      if (scrollNotification.metrics.pixels ==
                              scrollNotification.metrics.maxScrollExtent &&
                          scrollNotification is ScrollUpdateNotification) {
                        homeController.getPopularMovies();
                        return true;
                      }
                      return false;
                    },
                    child: Stack(
                      children: [
                        ListView.separated(
                          separatorBuilder: (context, index) =>
                              const VerticalDivider(
                            color: clrTransparent,
                            width: 15,
                          ),
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          itemCount: homeController.popularMovies.length,
                          itemBuilder: (context, index) {
                            final Movie movie =
                                homeController.popularMovies[index];
                            return MovieItemWidget(movie: movie);
                          },
                        ),
                        Obx(
                          () => Visibility(
                            visible: homeController.isPopularLoading.value,
                            child: const Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: const Align(
                                alignment: Alignment.centerRight,
                                child: const NutsActivityIndicator(radius: 25),
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
