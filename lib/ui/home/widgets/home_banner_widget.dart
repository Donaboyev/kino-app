import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kino_app/controller/home/home_controller.dart';
import 'package:kino_app/core/theme/app_colors.dart';
import 'package:kino_app/data/model/response/movie_response.dart';

class HomeBannerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeController) => CarouselSlider.builder(
        itemCount: homeController.upcomingMovies.length,
        itemBuilder: (context, itemIndex, pageViewIndex) {
          Movie movie = homeController.upcomingMovies[itemIndex];
          return Stack(
            alignment: Alignment.bottomLeft,
            children: [
              ClipRRect(
                child: CachedNetworkImage(
                  imageUrl:
                      'https://image.tmdb.org/t/p/w780/${movie.backdropPath}',
                  height: Get.height / 3,
                  width: Get.width,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => CupertinoActivityIndicator(),
                  errorWidget: (context, url, error) => Container(
                    child: Text('error'),
                  ),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [clrBlack, clrTransparent]),
                ),
                child: Text(
                  movie.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Positioned.fill(
                child: Material(
                  color: clrTransparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      print(
                          '======================> id: ${movie.id} name: ${movie.title}');
                    },
                  ),
                ),
              )
            ],
          );
        },
        options: CarouselOptions(
          enableInfiniteScroll: true,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 5),
          autoPlayAnimationDuration: Duration(milliseconds: 1500),
          pauseAutoPlayOnTouch: true,
          viewportFraction: 0.8,
          enlargeCenterPage: true,
        ),
      ),
    );
  }
}
