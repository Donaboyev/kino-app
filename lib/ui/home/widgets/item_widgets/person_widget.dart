import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kino_app/core/constants/constants.dart';
import 'package:kino_app/core/custom_widgets/nuts_activity_indicator.dart';
import 'package:kino_app/core/theme/app_colors.dart';
import 'package:kino_app/core/theme/text_styles.dart';
import 'package:kino_app/data/response/person_response.dart';
import 'package:kino_app/routes/app_routes.dart';

class PersonWidget extends StatelessWidget {
  final Person? person;

  const PersonWidget({Key? key, this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              child: ClipRRect(
                child: CachedNetworkImage(
                  imageUrl:
                      '${Constants.smallImageBaseUrl}${person!.profilePath}',
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
                  placeholder: (context, url) => const SizedBox(
                    width: 80,
                    height: 80,
                    child: Center(child: NutsActivityIndicator()),
                  ),
                  errorWidget: (context, url, error) => SizedBox(
                    width: 80,
                    height: 80,
                    child: Image.asset('assets/images/png/no_image.png'),
                  ),
                ),
              ),
            ),
            Center(
              child: Text(
                person!.name!,
                style: styPersonName,
              ),
            ),
            Center(
              child: Text(
                person!.knowForDepartment!,
                style: styPersonKnownFor,
              ),
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
    );
  }
}
