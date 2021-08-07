import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:kino_app/core/theme/app_colors.dart';
import 'package:kino_app/data/model/response/movie_response.dart';
import 'package:kino_app/data/model/response/person_response.dart';
import 'package:kino_app/routes/app_routes.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';

class MorePeopleItemWidget extends StatelessWidget {
  final Person person;

  const MorePeopleItemWidget({Key key, this.person}) : super(key: key);

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
                      'https://image.tmdb.org/t/p/w780/${person.profilePath}',
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      width: 140,
                      height: 140,
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
                    width: 140,
                    height: 140,
                    child: const Center(child: const NutsActivityIndicator()),
                  ),
                  errorWidget: (context, url, error) => Container(
                    width: 140,
                    height: 140,
                    child: Image.asset('assets/images/png/no_image.png'),
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
                          person.name.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: clrWhite,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                      Visibility(
                        visible: person.knowForDepartment != null,
                        child: Text(
                          person.knowForDepartment,
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
                  Get.toNamed(AppRoutes.PERSON_DETAIL, arguments: person.id);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
