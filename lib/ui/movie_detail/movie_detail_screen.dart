import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kino_app/base/base_functions.dart';
import 'package:kino_app/controller/movie_detail/movie_detail_controller.dart';
import 'package:kino_app/core/theme/app_colors.dart';
import 'package:kino_app/data/model/response/cast_response.dart';
import 'package:kino_app/data/model/response/screenshot.dart';
import 'package:kino_app/ui/movie_detail/widgets/cast_widget.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailPage extends GetView<MovieDetailController> {
  @override
  Widget build(BuildContext context) {
    int movieId = Get.arguments;
    controller.setMovieId(movieId);
    return GetBuilder<MovieDetailController>(
      builder: (detailController) => detailController.isLoading.value
          ? Center(child: NutsActivityIndicator())
          : Scaffold(
              backgroundColor: clrAsset,
              body: Stack(
                children: [
                  ListView(
                    physics: BouncingScrollPhysics(),
                    children: <Widget>[
                      Stack(
                        children: [
                          ClipPath(
                            child: ClipRRect(
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://image.tmdb.org/t/p/original/${detailController.movieDetail.backdropPath}',
                                height: Get.height / 2,
                                width: Get.width,
                                fit: BoxFit.cover,
                                placeholder: (context, url) =>
                                    NutsActivityIndicator(),
                                errorWidget: (context, url, error) => Container(
                                  child: Text('error'),
                                ),
                              ),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                            ),
                          ),
                          Container(
                            height: Get.height / 2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                              gradient: LinearGradient(
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
                                            child: Padding(
                                              padding: const EdgeInsets.all(24),
                                              child: Icon(
                                                Icons.play_circle_outline,
                                                color: clrPink,
                                                size: 56,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          detailController.movieDetail.title,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Amatic',
                                          ),
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
                          SizedBox(height: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  detailController.movieDetail.overview,
                                  style: TextStyle(color: clrWhite),
                                ),
                              ),
                              SizedBox(height: 12),
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
                                        Text(
                                          'Release date',
                                          style: TextStyle(color: clrWhite),
                                        ),
                                        Text(
                                          BaseFunctions.getReleaseDate(
                                              detailController
                                                  .movieDetail.releaseDate),
                                          style: TextStyle(color: clrRating),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Run time',
                                          style: TextStyle(color: clrWhite),
                                        ),
                                        Text(
                                          BaseFunctions.getRuntime(
                                              detailController
                                                  .movieDetail.runtime),
                                          style: TextStyle(color: clrRating),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Budget',
                                          style: TextStyle(color: clrWhite),
                                        ),
                                        Text(
                                          BaseFunctions.getBudget(
                                              detailController
                                                  .movieDetail.budget),
                                          style: TextStyle(color: clrRating),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 12),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Text(
                                  'Screenshots',
                                  style: TextStyle(color: clrWhite),
                                ),
                              ),
                              SizedBox(height: 6),
                              Container(
                                height: 155,
                                child: ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      VerticalDivider(
                                    color: clrTransparent,
                                    width: 12,
                                  ),
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  physics: BouncingScrollPhysics(),
                                  itemCount: detailController
                                      .movieDetail.movieImage.backdrops.length,
                                  itemBuilder: (context, index) {
                                    Screenshot image = detailController
                                        .movieDetail
                                        .movieImage
                                        .backdrops[index];
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: CachedNetworkImage(
                                        placeholder: (context, url) => Center(
                                          child: NutsActivityIndicator(),
                                        ),
                                        imageUrl:
                                            'https://image.tmdb.org/t/p/w500${image.imagePath}',
                                        fit: BoxFit.cover,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: 12),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Text(
                                  'Casts',
                                  style: TextStyle(color: clrWhite),
                                ),
                              ),
                              SizedBox(height: 12),
                              Container(
                                height: 118,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  separatorBuilder: (context, index) =>
                                      VerticalDivider(
                                    color: Colors.transparent,
                                    width: 6,
                                  ),
                                  itemCount: detailController
                                      .movieDetail.castList.length,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  itemBuilder: (context, index) {
                                    Cast cast = detailController
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
                        child: Padding(
                          padding: const EdgeInsets.all(24),
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
