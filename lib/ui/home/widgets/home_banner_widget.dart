import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kino_app/controller/home/home_controller.dart';
import 'package:kino_app/data/model/response/movie_response.dart';

class HomeBannerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeController) => CarouselSlider.builder(
        itemCount: homeController.nowPlayingMovies.length,
        itemBuilder: (context, itemIndex, pageViewIndex) {
          Movie movie = homeController.nowPlayingMovies[itemIndex];
          return Stack(
            alignment: Alignment.bottomLeft,
            children: [
              ClipRRect(
                child: CachedNetworkImage(
                  imageUrl:
                      'https://image.tmdb.org/t/p/original/${movie.backdropPath}',
                  height: Get.height / 3,
                  width: Get.width,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => CupertinoActivityIndicator(),
                  errorWidget: (context, url, error) => Container(
                    child: Text('error'),
                  ),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  bottom: 15,
                  left: 15,
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
