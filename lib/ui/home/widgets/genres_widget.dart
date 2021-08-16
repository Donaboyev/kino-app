import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:kino_app/controller/home_controller.dart';
import 'package:kino_app/core/custom_widgets/nuts_activity_indicator.dart';
import 'package:kino_app/core/theme/app_colors.dart';
import 'package:kino_app/core/theme/text_styles.dart';
import 'package:kino_app/data/response/genre_response.dart';
import 'package:kino_app/routes/app_routes.dart';
import 'package:kino_app/ui/home/widgets/item_widgets/category_title_widget.dart';

class GenresWidget extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeController) => Column(
        children: [
          CategoryTitleWidget(
            title: 'Discover movies',
            onTap: () => Get.toNamed(AppRoutes.DISCOVER_MORE),
          ),
          homeController.isLoading.value
              ? const Center(child: const NutsActivityIndicator())
              : SizedBox(
                  height: 45,
                  child: Align(
                    alignment: Alignment.center,
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          const VerticalDivider(
                        color: clrTransparent,
                        width: 0,
                      ),
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      physics: const BouncingScrollPhysics(),
                      itemCount: homeController.genres!.length,
                      itemBuilder: (context, index) {
                        final Genre genre = homeController.genres![index];
                        return Obx(
                          () => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RawMaterialButton(
                              onPressed: () async => await homeController
                                  .setSelectedGenreIndex(index),
                              elevation: 0,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              fillColor:
                                  homeController.selectedGenreIndex.value ==
                                          index
                                      ? clrPink
                                      : clrMirage,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              focusElevation: 0,
                              highlightElevation: 0,
                              child: Center(
                                child: Text(
                                  genre.name!,
                                  style: styGenreTitle,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
