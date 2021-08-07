import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:kino_app/core/theme/app_colors.dart';
import 'package:kino_app/data/model/response/movie_response.dart';
import 'package:kino_app/routes/app_routes.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';

class MovieItemWidget extends StatelessWidget {
  final Movie movie;

  const MovieItemWidget({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              child: CachedNetworkImage(
                imageUrl:
                    'https://image.tmdb.org/t/p/w780/${movie.backdropPath ?? movie.posterPath}',
                imageBuilder: (context, imageProvider) {
                  return Container(
                    width: 180,
                    height: 246,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
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
                  child: const Center(child: const NutsActivityIndicator()),
                ),
                errorWidget: (context, url, error) => Container(
                  width: 180,
                  height: 250,
                  child: const Center(child: const Text('error')),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: 180,
              child: Text(
                movie.title.toUpperCase(),
                style: const TextStyle(
                  fontSize: 12,
                  color: clrWhite,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 6),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: <Widget>[
                    RatingBarIndicator(
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: clrRating,
                      ),
                      rating: (double.parse(movie.voteAverage) / 2),
                      itemCount: 5,
                      itemSize: 18,
                      unratedColor: clrUnrated,
                      direction: Axis.horizontal,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      movie.voteAverage.toString(),
                      style: const TextStyle(
                        color: clrWhite,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned.fill(
          child: Material(
            color: clrTransparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                Get.toNamed(AppRoutes.MOVIE_DETAIL, arguments: movie.id);
              },
            ),
          ),
        )
      ],
    );
  }
}
