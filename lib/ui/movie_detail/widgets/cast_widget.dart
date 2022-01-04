import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../ui.dart';

class CastWidget extends StatelessWidget {
  final Cast? cast;

  const CastWidget({Key? key, this.cast}) : super(key: key);

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
                        '${Constants.SMALL_IMAGE_BASE_URL}${cast!.profilePath}',
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
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      width: 80,
                      height: 80,
                      child: Image.asset('assets/images/png/no_image.png'),
                    ),
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: Text(
                    cast!.name!,
                    style: styPersonName,
                  ),
                ),
              ),
              Container(
                child: Center(
                  child: Text(
                    cast!.character!,
                    style: styPersonKnownFor,
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
              onTap: () {
                if (cast!.id != null)
                  Get.toNamed(AppRoutes.PERSON_DETAIL, arguments: cast!.id);
              },
            ),
          ),
        )
      ],
    );
  }
}
