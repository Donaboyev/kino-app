import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kino_app/core/theme/app_colors.dart';
import 'package:kino_app/data/model/response/cast_response.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';

class CastWidget extends StatelessWidget {
  final Cast cast;

  const CastWidget({Key key, this.cast}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Column(
            children: [
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                elevation: 3,
                child: ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://image.tmdb.org/t/p/w200${cast.profilePath}',
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                    placeholder: (context, url) => Container(
                      width: 80,
                      height: 80,
                      child: const Center(child: const NutsActivityIndicator()),
                    ),
                    errorWidget: (context, url, error) => Container(
                      width: 80,
                      height: 80,
                      child: const Center(child: const Text('error')),
                    ),
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: Text(
                    cast.name,
                    style: const TextStyle(
                      color: clrWhite,
                      fontSize: 10,
                    ),
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: Text(
                    cast.character,
                    style: const TextStyle(
                      color: clrWhite,
                      fontSize: 8,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: Material(
            color: clrTransparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {},
            ),
          ),
        )
      ],
    );
  }
}
