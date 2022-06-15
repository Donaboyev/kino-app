import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kino_app/controller/home_controller.dart';
import 'package:kino_app/core/custom_widgets/nuts_activity_indicator.dart';
import 'package:kino_app/core/theme/app_colors.dart';
import 'package:kino_app/data/response/movie_response.dart';
import 'package:kino_app/routes/app_routes.dart';
import 'package:kino_app/ui/home/widgets/item_widgets/category_title_widget.dart';
import 'package:kino_app/ui/home/widgets/item_widgets/movie_item_widget.dart';

class TopRatedWidget extends StatelessWidget {
  const TopRatedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeController) => Column(
        children: [
          CategoryTitleWidget(
            title: 'Top rated',
            onTap: () => Get.toNamed(AppRoutes.topRatedMore),
          ),
          const SizedBox(height: 12),
          homeController.isLoading.value
              ? const Center(child: NutsActivityIndicator())
              : SizedBox(
                  height: 300,
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (scrollNotification) {
                      if (scrollNotification.metrics.pixels ==
                              scrollNotification.metrics.maxScrollExtent &&
                          scrollNotification is ScrollUpdateNotification) {
                        homeController.getTopRatedMovies();
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
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          itemCount: homeController.topRatedMovies.length,
                          itemBuilder: (context, index) {
                            final Movie movie =
                                homeController.topRatedMovies[index];
                            return MovieItemWidget(movie: movie);
                          },
                        ),
                        Obx(
                          () => Visibility(
                            visible: homeController.isTopRatedLoading.value,
                            child: const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: NutsActivityIndicator(radius: 12),
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
