import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get.dart';
import 'package:kino_app/controller/home/home_controller.dart';
import 'package:kino_app/core/theme/app_colors.dart';
import 'package:kino_app/core/theme/text_styles.dart';
import 'package:kino_app/data/model/response/genre_response.dart';

class GenresWidget extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeController) => Column(
        children: [
          SizedBox(height: 12),
          Text(
            'Discover',
            style: styAppBarTitle,
          ),
          homeController.isLoading.value
              ? Center(child: CupertinoActivityIndicator())
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
                      physics: BouncingScrollPhysics(),
                      itemCount: homeController.genres.length,
                      itemBuilder: (context, index) {
                        Genre genre = homeController.genres[index];
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
                                      ? clrBlack
                                      : clrWhite,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
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
                                        ? clrBlack
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
/**Column(
    children: <Widget>[
    Container(
    decoration: BoxDecoration(
    border: Border.all(color: clrBlack),
    borderRadius: BorderRadius.circular(25),
    color: homeController
    .selectedGenreIndex.value !=
    index
    ? clrWhite
    : clrBlack,
    ),
    child: Text(
    genre.name.toUpperCase(),
    style: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: homeController
    .selectedGenreIndex
    .value !=
    index
    ? clrBlack
    : clrWhite,
    ),
    ),
    ),
    ],
    ),
    */
