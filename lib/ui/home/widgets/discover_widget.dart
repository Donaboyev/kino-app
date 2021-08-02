import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kino_app/controller/home/home_controller.dart';
import 'package:kino_app/core/theme/app_colors.dart';
import 'package:kino_app/data/model/response/movie_response.dart';

class DiscoverWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeController) => Column(
        children: [
          SizedBox(height: 12),
          homeController.isLoading.value
              ? Center(
                  child: CupertinoActivityIndicator(),
                )
              : Container(
                  height: 300,
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (scrollNotification) {
                      if (scrollNotification.metrics.pixels ==
                              scrollNotification.metrics.maxScrollExtent &&
                          scrollNotification is ScrollUpdateNotification) {
                        homeController.getMoviesByGenre();
                        return true;
                      }
                      return false;
                    },
                    child: Stack(
                      children: [
                        ListView.separated(
                          separatorBuilder: (context, index) => VerticalDivider(
                            color: clrTransparent,
                            width: 15,
                          ),
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          controller: homeController.scrollController,
                          itemCount: homeController.moviesByGenre.length,
                          itemBuilder: (context, index) {
                            Movie movie = homeController.moviesByGenre[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'https://image.tmdb.org/t/p/w780/${movie.backdropPath}',
                                    imageBuilder: (context, imageProvider) {
                                      return Container(
                                        width: 180,
                                        height: 250,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(12),
                                          ),
                                          image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    },
                                    placeholder: (context, url) => Container(
                                      width: 180,
                                      height: 250,
                                      child: Center(
                                        child: CupertinoActivityIndicator(),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Container(
                                      width: 180,
                                      height: 250,
                                      child: Center(child: Text('error')),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 12),
                                Container(
                                  width: 180,
                                  child: Text(
                                    movie.title.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: clrBlack,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.star,
                                          color: Colors.yellow, size: 14),
                                      Icon(Icons.star,
                                          color: Colors.yellow, size: 14),
                                      Icon(Icons.star,
                                          color: Colors.yellow, size: 14),
                                      Icon(Icons.star,
                                          color: Colors.yellow, size: 14),
                                      Icon(Icons.star,
                                          color: Colors.yellow, size: 14),
                                      Text(
                                        movie.voteAverage,
                                        style: TextStyle(
                                          color: clrBlack,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        Obx(
                          () => Visibility(
                            visible: homeController.isDiscoverLoading.value,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: CupertinoActivityIndicator(radius: 25),
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
