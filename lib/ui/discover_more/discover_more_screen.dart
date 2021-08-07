import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kino_app/controller/discover_more_controller.dart';
import 'package:kino_app/core/theme/app_colors.dart';
import 'package:kino_app/data/model/response/genre_response.dart';
import 'package:kino_app/data/model/response/movie_response.dart';
import 'package:kino_app/ui/home/widgets/movie_item_widget.dart';
import 'package:kino_app/ui/widgets/more_movie_item_widget.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';

class DiscoverMorePage extends GetView<DiscoverMoreController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: clrAsset,
      body: SafeArea(
        child: GetBuilder<DiscoverMoreController>(
          builder: (moreController) => moreController.isLoading.value
              ? Center(child: NutsActivityIndicator())
              : Stack(children: [
                  CustomScrollView(
                    controller: moreController.scrollController,
                    physics: BouncingScrollPhysics(),
                    slivers: [
                      SliverAppBar(
                        floating: true,
                        backgroundColor: clrAsset,
                        elevation: 0,
                        title: Text(
                          'Discover movies'.toUpperCase(),
                          style: Theme.of(context).textTheme.caption.copyWith(
                                color: clrWhite,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        leading: IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ),
                      SliverAppBar(
                        expandedHeight: 0,
                        backgroundColor: clrAsset,
                        toolbarHeight: 0,
                        pinned: true,
                        elevation: 0,
                        titleSpacing: 0,
                        bottom: PreferredSize(
                          preferredSize: Size.fromHeight(45),
                          child: SizedBox(
                            height: 45,
                            child: Align(
                              alignment: Alignment.center,
                              child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    VerticalDivider(
                                  color: clrTransparent,
                                  width: 5,
                                ),
                                scrollDirection: Axis.horizontal,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 7),
                                physics: const BouncingScrollPhysics(),
                                itemCount: moreController.genres.length,
                                itemBuilder: (context, index) {
                                  final Genre genre =
                                      moreController.genres[index];
                                  return Obx(
                                    () => Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: RawMaterialButton(
                                        onPressed: () async =>
                                            await moreController
                                                .setSelectedGenreIndex(index),
                                        elevation: 0,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        fillColor: moreController
                                                    .selectedGenreIndex.value ==
                                                index
                                            ? clrPink
                                            : clrMirage,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        focusElevation: 0,
                                        highlightElevation: 0,
                                        child: Center(
                                          child: Text(
                                            genre.name,
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                              color: moreController
                                                          .selectedGenreIndex
                                                          .value !=
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
                        ),
                      ),
                      moreController.isLoading.value
                          ? NutsActivityIndicator()
                          : SliverList(
                              delegate: SliverChildBuilderDelegate(
                                (context, index) {
                                  final Movie movie =
                                      moreController.moviesByGenre[index];
                                  return MoreMovieItemWidget(movie: movie);
                                },
                                childCount: moreController.moviesByGenre.length,
                              ),
                            )
                    ],
                  ),
                  Obx(
                    () => Visibility(
                      visible: moreController.isDiscoverLoading.value,
                      child: const Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: const Align(
                          alignment: Alignment.bottomCenter,
                          child: const NutsActivityIndicator(radius: 12),
                        ),
                      ),
                    ),
                  ),
                ]),
        ),
      ),
    );
  }
}
