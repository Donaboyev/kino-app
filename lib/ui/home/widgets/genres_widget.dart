import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:kino_app/controller/home/home_controller.dart';
import 'package:kino_app/core/theme/app_colors.dart';
import 'package:kino_app/core/theme/text_styles.dart';
import 'package:kino_app/data/model/response/genre_response.dart';
import 'package:kino_app/ui/home/widgets/category_title_widget.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';

class GenresWidget extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeController) => Column(
        children: [
          CategoryTitleWidget(
            title: 'Discover movies',
            onTap: () {},
          ),
          homeController.isLoading.value
              ? Center(child: const NutsActivityIndicator())
              : SizedBox(
                  height: 45,
                  child: Align(
                    alignment: Alignment.center,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => VerticalDivider(
                        color: clrTransparent,
                        width: 5,
                      ),
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 7),
                      physics: const BouncingScrollPhysics(),
                      itemCount: homeController.genres.length,
                      itemBuilder: (context, index) {
                        final Genre genre = homeController.genres[index];
                        return Obx(
                          () => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RawMaterialButton(
                              onPressed: () async => await homeController
                                  .setSelectedGenreIndex(index),
                              elevation: 0,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
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
                                  genre.name,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: homeController
                                                .selectedGenreIndex.value !=
                                            index
                                        ? clrWhite
                                        : clrWhite,
                                  ),
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
