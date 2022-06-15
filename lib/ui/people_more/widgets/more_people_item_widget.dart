import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kino_app/core/constants/constants.dart';
import 'package:kino_app/core/custom_widgets/nuts_activity_indicator.dart';
import 'package:kino_app/core/theme/app_colors.dart';
import 'package:kino_app/core/theme/text_styles.dart';
import 'package:kino_app/data/response/person_response.dart';
import 'package:kino_app/routes/app_routes.dart';

class MorePeopleItemWidget extends StatelessWidget {
  final Person? person;

  const MorePeopleItemWidget({Key? key, this.person}) : super(key: key);

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
                      '${Constants.bigImageBaseUrl}${person!.profilePath}',
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
                  placeholder: (context, url) => const SizedBox(
                    width: 140,
                    height: 140,
                    child: Center(child: NutsActivityIndicator()),
                  ),
                  errorWidget: (context, url, error) => SizedBox(
                    width: 140,
                    height: 140,
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
                        person!.name!.toUpperCase(),
                        style: styMorePersonName,
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                      ),
                      Visibility(
                        visible: person!.knowForDepartment != null,
                        child: Text(
                          person!.knowForDepartment!,
                          style: styVoteAverage,
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
                    Get.toNamed(AppRoutes.personDetail, arguments: person!.id),
              ),
            ),
          )
        ],
      ),
    );
  }
}
