import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'item_widgets/category_title_widget.dart';
import 'item_widgets/movie_item_widget.dart';
import '../../ui.dart';

class NowPlayingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeController) => Column(
        children: [
          CategoryTitleWidget(
            title: 'Now playing',
            onTap: () => Get.toNamed(AppRoutes.NOW_PLAYING_MORE),
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
                        homeController.getNowPlayingMovies();
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
                            width: 12,
                          ),
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          physics: const BouncingScrollPhysics(),
                          itemCount: homeController.nowPlayingMovies.length,
                          itemBuilder: (context, index) {
                            final Movie movie =
                                homeController.nowPlayingMovies[index];
                            return MovieItemWidget(movie: movie);
                          },
                        ),
                        Obx(
                          () => Visibility(
                            visible: homeController.isNowPlayingLoading.value,
                            child: const Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: const Align(
                                alignment: Alignment.centerRight,
                                child: const NutsActivityIndicator(radius: 12),
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
