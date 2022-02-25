import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../ui.dart';

class HomeBannerWidget extends StatelessWidget {
  const HomeBannerWidget({Key? key}) : super(key: key);

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
                      '${Constants.bigImageBaseUrl}${movie.backdropPath ?? movie.posterPath}',
                  height: Get.height / 3,
                  width: Get.width,
                  fit: movie.backdropPath != null
                      ? BoxFit.cover
                      : BoxFit.scaleDown,
                  placeholder: (context, url) => const NutsActivityIndicator(),
                  errorWidget: (context, url, error) => Image.asset('assets/images/png/no_image.png'),
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [clrOpacityBlack, clrTransparent],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
                  child: Text(
                    movie.title!,
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
                    onTap: () => Get.toNamed(AppRoutes.movieDetail,
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
