import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:kino_app/core/constants/constants.dart';
import 'package:kino_app/core/custom_widgets/nuts_activity_indicator.dart';
import 'package:kino_app/core/theme/app_colors.dart';
import 'package:kino_app/core/theme/text_styles.dart';
import 'package:kino_app/data/response/movie_response.dart';
import 'package:kino_app/routes/app_routes.dart';

class MoreMovieItemWidget extends StatelessWidget {
  final Movie? movie;

  const MoreMovieItemWidget({Key? key, this.movie}) : super(key: key);

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
                      '${Constants.bigImageBaseUrl}${movie!.backdropPath ?? movie!.posterPath}',
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
                  placeholder: (context, url) => const SizedBox(
                    width: 140,
                    height: 200,
                    child: Center(child: NutsActivityIndicator()),
                  ),
                  errorWidget: (context, url, error) => SizedBox(
                    width: 140,
                    height: 200,
                    child: Image.asset('assets/images/png/no_image.png'),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie!.title!.toUpperCase(),
                        style: styMovieTitle,
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: <Widget>[
                            RatingBarIndicator(
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: clrRating,
                              ),
                              rating: (double.parse(movie!.voteAverage!) / 2),
                              itemCount: 5,
                              itemSize: 18,
                              unratedColor: clrUnrated,
                              direction: Axis.horizontal,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              movie!.voteAverage.toString(),
                              style: styVoteAverage,
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: movie!.overview != null,
                        child: Text(
                          movie!.overview!,
                          style: styMovieDescription,
                          maxLines: 7,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Icon(
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
                onTap: () =>
                    Get.toNamed(AppRoutes.movieDetail, arguments: movie!.id),
              ),
            ),
          )
        ],
      ),
    );
  }
}
