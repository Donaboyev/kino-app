import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/cast_widget.dart';
import '../ui.dart';

class MovieDetailPage extends GetView<MovieDetailController> {
  const MovieDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int? movieId = Get.arguments;
    controller.setMovieId(movieId);
    return GetBuilder<MovieDetailController>(
      builder: (detailController) => detailController.isLoading.value
          ? const Center(child: NutsActivityIndicator())
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
                                  '${Constants.originalImageBaseUrl}${detailController.movieDetail!.backdropPath}',
                              height: Get.height / 2,
                              width: Get.width,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  const NutsActivityIndicator(),
                              errorWidget: (context, url, error) => Image.asset(
                                  'assets/images/png/no_image.png'),
                            ),
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                          ),
                          Container(
                            height: Get.height / 2,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [clrOpacityBlack, clrTransparent],
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
                                                  'https://www.youtube.com/embed/${detailController.movieDetail!.trailerId}';
                                              if (await canLaunch(youtubeUrl)) {
                                                await launch(youtubeUrl);
                                              }
                                            },
                                            child: const Padding(
                                              padding: EdgeInsets.all(24),
                                              child: Icon(
                                                Icons.play_circle_outline,
                                                color: clrPink,
                                                size: 56,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          detailController.movieDetail!.title!,
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
                                  detailController.movieDetail!.overview!,
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
                                                  .movieDetail!.releaseDate!),
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
                                                  .movieDetail!.runtime!),
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
                                                  .movieDetail!.budget!),
                                          style: styGoldText,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                              Visibility(
                                visible: detailController.movieDetail!
                                    .movieImage.backdrops!.isNotEmpty,
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Text(
                                    'Screenshots',
                                    style: styVoteAverage,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: detailController.movieDetail!
                                    .movieImage.backdrops!.isNotEmpty,
                                child: const SizedBox(height: 6),
                              ),
                              Visibility(
                                visible: detailController.movieDetail!
                                    .movieImage.backdrops!.isNotEmpty,
                                child: SizedBox(
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
                                    itemCount: detailController.movieDetail!
                                        .movieImage.backdrops!.length,
                                    itemBuilder: (context, index) {
                                      final Screenshot image = detailController
                                          .movieDetail!
                                          .movieImage
                                          .backdrops![index];
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: CachedNetworkImage(
                                          placeholder: (context, url) =>
                                              const Center(
                                            child:
                                                NutsActivityIndicator(),
                                          ),
                                          imageUrl:
                                              '${Constants.mediumImageBaseUrl}${image.imagePath}',
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Text(
                                  'Casts',
                                  style: styVoteAverage,
                                ),
                              ),
                              const SizedBox(height: 12),
                              SizedBox(
                                height: 118,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (context, index) =>
                                      const VerticalDivider(
                                    color: clrTransparent,
                                    width: 6,
                                  ),
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: detailController
                                      .movieDetail!.castList!.length,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  itemBuilder: (context, index) {
                                    final Cast cast = detailController
                                        .movieDetail!.castList![index];
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
                          padding: EdgeInsets.all(24),
                          child: Icon(
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
