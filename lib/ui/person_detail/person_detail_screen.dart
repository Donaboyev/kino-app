import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kino_app/base/base_functions.dart';
import 'package:kino_app/controller/person_detail_controller.dart';
import 'package:kino_app/core/constants/constants.dart';
import 'package:kino_app/core/custom_widgets/nuts_activity_indicator.dart';
import 'package:kino_app/core/theme/app_colors.dart';
import 'package:kino_app/core/theme/text_styles.dart';

class PersonDetailPage extends GetView<PersonDetailController> {
  @override
  Widget build(BuildContext context) {
    final int? personId = Get.arguments;
    controller.setPersonId(personId);
    return GetBuilder<PersonDetailController>(
      builder: (detailController) => detailController.isLoading.value
          ? const NutsActivityIndicator()
          : Scaffold(
              backgroundColor: clrAsset,
              body: Stack(
                children: [
                  ListView(
                    physics: const BouncingScrollPhysics(),
                    children: <Widget>[
                      Stack(
                        children: [
                          Visibility(
                            visible:
                                detailController.person!.profilePath != null,
                            child: ClipPath(
                              child: ClipRRect(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      '${Constants.ORIGINAL_IMAGE_BASE_URL}${detailController.person!.profilePath ?? ''}',
                                  height: Get.height / 2,
                                  width: Get.width,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      const NutsActivityIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    child: Image.asset(
                                        'assets/images/png/no_image.png'),
                                  ),
                                ),
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: const Radius.circular(30),
                                  bottomRight: const Radius.circular(30),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: Get.height / 2,
                            decoration: const BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: const Radius.circular(30),
                                bottomRight: const Radius.circular(30),
                              ),
                              gradient: const LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: const [clrOpacityBlack, clrTransparent],
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 24),
                                  child: Center(
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          detailController.person!.name!,
                                          style: styBannerTitle,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          const SizedBox(height: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Visibility(
                                      visible:
                                          detailController.person!.birthday !=
                                              null,
                                      child: Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            const Text(
                                              'Birthdate',
                                              style: styVoteAverage,
                                            ),
                                            Text(
                                              BaseFunctions.getReleaseDate(
                                                  detailController
                                                          .person!.birthday ??
                                                      ''),
                                              style: styGoldText,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Visibility(
                                      visible: detailController
                                              .person!.placeOfBirth !=
                                          null,
                                      child: Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Place of birth',
                                              style: styVoteAverage,
                                            ),
                                            Text(
                                              detailController
                                                      .person!.placeOfBirth ??
                                                  'No data',
                                              style: styGoldText,
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                              Visibility(
                                visible: detailController
                                    .person!.knownAs!.isNotEmpty,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: const Text(
                                    'Also known as',
                                    style: styVoteAverage,
                                  ),
                                ),
                              ),
                              Visibility(
                                visible: detailController
                                    .person!.knownAs!.isNotEmpty,
                                child: const SizedBox(height: 6),
                              ),
                              Visibility(
                                visible: detailController
                                    .person!.knownAs!.isNotEmpty,
                                child: Container(
                                  height: 36,
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        const VerticalDivider(
                                      color: clrTransparent,
                                      width: 6,
                                    ),
                                    scrollDirection: Axis.horizontal,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: detailController
                                        .person!.knownAs!.length,
                                    itemBuilder: (context, index) {
                                      String nickname = detailController
                                          .person!.knownAs![index];
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: clrPink,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        padding: const EdgeInsets.all(6),
                                        child: Center(
                                          child: Text(
                                            nickname,
                                            style: styVoteAverage,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Visibility(
                                visible:
                                    detailController.person!.biography != null,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Text(
                                    detailController.person!.biography!,
                                    style: styVoteAverage,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    top: 24,
                    child: Material(
                      borderRadius: BorderRadius.circular(64),
                      color: clrLittleTransparent,
                      child: InkResponse(
                        onTap: () => Get.back(),
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: clrWhite,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
