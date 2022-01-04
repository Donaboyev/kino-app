import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'item_widgets/category_title_widget.dart';
import '../../ui.dart';

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
