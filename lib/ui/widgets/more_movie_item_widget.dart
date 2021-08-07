import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:kino_app/core/theme/app_colors.dart';
import 'package:kino_app/data/model/response/movie_response.dart';
import 'package:kino_app/routes/app_routes.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';

class MoreMovieItemWidget extends StatelessWidget {
  final Movie movie;

  const MoreMovieItemWidget({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                child: CachedNetworkImage(
                  imageUrl:
                      'https://image.tmdb.org/t/p/w780/${movie.backdropPath ?? movie.posterPath}',
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      width: 140,
                      height: 200,
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
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          movie.title.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: clrWhite,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 4, top: 4),
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
                      Visibility(
                        visible: movie.overview != null,
                        child: Text(
                          movie.overview,
                          style: TextStyle(color: clrWhite),
                          maxLines: 7,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: clrWhite,
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
      ),
    );
  }
}
