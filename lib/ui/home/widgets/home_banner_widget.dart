import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kino_app/controller/home_controller.dart';
import 'package:kino_app/core/constants/constants.dart';
import 'package:kino_app/core/theme/app_colors.dart';
import 'package:kino_app/core/theme/text_styles.dart';
import 'package:kino_app/data/response/movie_response.dart';
import 'package:kino_app/routes/app_routes.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';

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
                      '${Constants.BIG_IMAGE_BASE_URL}${movie.backdropPath ?? movie.posterPath}',
                  height: Get.height / 3,
                  width: Get.width,
                  fit: movie.backdropPath != null
                      ? BoxFit.cover
                      : BoxFit.scaleDown,
                  placeholder: (context, url) => const NutsActivityIndicator(),
                  errorWidget: (context, url, error) => Container(
                      child: Image.asset('assets/images/png/no_image.png')),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: const Radius.circular(12),
                    bottomRight: const Radius.circular(12),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: const [clrOpacityBlack, clrTransparent],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
                  child: Text(
                    movie.title,
                    style: styBannerTitle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
              Positioned.fill(
                child: Material(
                  color: clrTransparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => Get.toNamed(AppRoutes.MOVIE_DETAIL,
                        arguments: movie.id),
                  ),
                ),
              )
            ],
          );
        },
        options: CarouselOptions(
          enableInfiniteScroll: true,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 5),
          autoPlayAnimationDuration: const Duration(milliseconds: 1500),
          pauseAutoPlayOnTouch: true,
          viewportFraction: 0.8,
          enlargeCenterPage: true,
        ),
      ),
    );
  }
}
