import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kino_app/base/base_functions.dart';
import 'package:kino_app/controller/movie_detail_controller.dart';
import 'package:kino_app/core/constants/constants.dart';
import 'package:kino_app/core/theme/app_colors.dart';
import 'package:kino_app/core/theme/text_styles.dart';
import 'package:kino_app/data/response/cast_response.dart';
import 'package:kino_app/data/response/screenshot.dart';
import 'package:kino_app/ui/movie_detail/widgets/cast_widget.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailPage extends GetView<MovieDetailController> {
  @override
  Widget build(BuildContext context) {
    final int movieId = Get.arguments;
    controller.setMovieId(movieId);
    return GetBuilder<MovieDetailController>(
      builder: (detailController) => detailController.isLoading.value
          ? const Center(child: const NutsActivityIndicator())
          : Scaffold(
              backgroundColor: clrAsset,
              body: Stack(
                children: [
                  ListView(
                    physics: const BouncingScrollPhysics(),
                    children: <Widget>[
                      Stack(
                        children: [
                          ClipRRect(
                            child: CachedNetworkImage(
                              imageUrl:
                                  '${Constants.ORIGINAL_IMAGE_BASE_URL}${detailController.movieDetail.backdropPath}',
                              height: Get.height / 2,
                              width: Get.width,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  const NutsActivityIndicator(),
                              errorWidget: (context, url, error) => Container(
                                child: Image.asset(
                                    'assets/images/png/no_image.png'),
                              ),
                            ),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: const Radius.circular(30),
                              bottomRight: const Radius.circular(30),
                            ),
                          ),
                          Container(
                            height: Get.height / 2,
                            decoration: const BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: const Radius.circular(30),
                                bottomRight: const Radius.circular(30),
                              ),
                              gradient: const LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: const [clrOpacityBlack, clrTransparent],
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 24),
                                  child: Center(
                                    child: Column(
                                      children: <Widget>[
                                        Material(
                                          color: clrTransparent,
                                          child: InkResponse(
                                            onTap: () async {
                                              final youtubeUrl =
                                                  'https://www.youtube.com/embed/${detailController.movieDetail.trailerId}';
                                              if (await canLaunch(youtubeUrl))
                                                await launch(youtubeUrl);
                                            },
                                            child: const Padding(
                                              padding: const EdgeInsets.all(24),
                                              child: const Icon(
                                                Icons.play_circle_outline,
                                                color: clrPink,
                                                size: 56,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          detailController.movieDetail.title,
                                          style: styBannerTitle,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          const SizedBox(height: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  detailController.movieDetail.overview,
                                  style: styVoteAverage,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const Text(
                                          'Release date',
                                          style: styVoteAverage,
                                        ),
                                        Text(
                                          BaseFunctions.getReleaseDate(
                                              detailController
                                                  .movieDetail.releaseDate),
                                          style: styGoldText,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const Text(
                                          'Run time',
                                          style: styVoteAverage,
                                        ),
                                        Text(
                                          BaseFunctions.getRuntime(
                                              detailController
                                                  .movieDetail.runtime),
                                          style: styGoldText,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        const Text(
                                          'Budget',
                                          style: styVoteAverage,
                                        ),
                                        Text(
                                          BaseFunctions.getBudget(
                                              detailController
                                                  .movieDetail.budget),
                                          style: styGoldText,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                              Visibility(
                                visible: detailController.movieDetail.movieImage
                                    .backdrops.isNotEmpty,
                                child: const Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: const Text(
                                    'Screenshots',
                                    style: styVoteAverage,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: detailController.movieDetail.movieImage
                                    .backdrops.isNotEmpty,
                                child: const SizedBox(height: 6),
                              ),
                              Visibility(
                                visible: detailController.movieDetail.movieImage
                                    .backdrops.isNotEmpty,
                                child: Container(
                                  height: 155,
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        const VerticalDivider(
                                      color: clrTransparent,
                                      width: 12,
                                    ),
                                    scrollDirection: Axis.horizontal,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: detailController.movieDetail
                                        .movieImage.backdrops.length,
                                    itemBuilder: (context, index) {
                                      final Screenshot image = detailController
                                          .movieDetail
                                          .movieImage
                                          .backdrops[index];
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: CachedNetworkImage(
                                          placeholder: (context, url) =>
                                              const Center(
                                            child:
                                                const NutsActivityIndicator(),
                                          ),
                                          imageUrl:
                                              '${Constants.MEDIUM_IMAGE_BASE_URL}${image.imagePath}',
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: const Text(
                                  'Casts',
                                  style: styVoteAverage,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Container(
                                height: 118,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (context, index) =>
                                      const VerticalDivider(
                                    color: clrTransparent,
                                    width: 6,
                                  ),
                                  itemCount: detailController
                                      .movieDetail.castList.length,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  itemBuilder: (context, index) {
                                    final Cast cast = detailController
                                        .movieDetail.castList[index];
                                    return CastWidget(cast: cast);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    top: 24,
                    child: Material(
                      color: clrTransparent,
                      child: InkResponse(
                        onTap: () => Get.back(),
                        child: const Padding(
                          padding: const EdgeInsets.all(24),
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: clrWhite,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}