import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kino_app/base/base_functions.dart';
import 'package:kino_app/controller/person_detail_controller.dart';
import 'package:kino_app/core/theme/app_colors.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';

class PersonDetailPage extends GetView<PersonDetailController> {
  const PersonDetailPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int personId = Get.arguments;
    controller.setPersonId(personId);
    return GetBuilder<PersonDetailController>(
      builder: (detailController) => detailController.isLoading.value
          ? NutsActivityIndicator()
          : Scaffold(
              backgroundColor: clrAsset,
              body: Stack(
                children: [
                  ListView(
                    physics: BouncingScrollPhysics(),
                    children: <Widget>[
                      Stack(
                        children: [
                          Visibility(
                            visible:
                                detailController.person.profilePath != null,
                            child: ClipPath(
                              child: ClipRRect(
                                child: CachedNetworkImage(
                                  imageUrl:
                                      'https://image.tmdb.org/t/p/original/${detailController.person.profilePath ?? ''}',
                                  height: Get.height / 2,
                                  width: Get.width,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      NutsActivityIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                    child: Image.asset(
                                        'assets/images/png/no_image.png'),
                                  ),
                                ),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: Get.height / 2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                              gradient: LinearGradient(
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
                                          detailController.person.name,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 36,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Amatic',
                                          ),
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
                          SizedBox(height: 12),
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
                                          detailController.person.birthday !=
                                              null,
                                      child: Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Birthdate',
                                              style: TextStyle(color: clrWhite),
                                            ),
                                            Text(
                                              BaseFunctions.getReleaseDate(
                                                  detailController
                                                          .person.birthday ??
                                                      ''),
                                              style:
                                                  TextStyle(color: clrRating),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 6),
                                    Visibility(
                                      visible: detailController
                                              .person.placeOfBirth !=
                                          null,
                                      child: Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              'Place of birth',
                                              style: TextStyle(color: clrWhite),
                                            ),
                                            Text(
                                              detailController
                                                      .person.placeOfBirth ??
                                                  'No data',
                                              style:
                                                  TextStyle(color: clrRating),
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
                              SizedBox(height: 12),
                              Visibility(
                                visible:
                                    detailController.person.knownAs.isNotEmpty,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Text(
                                    'Also known as',
                                    style: TextStyle(color: clrWhite),
                                  ),
                                ),
                              ),
                              Visibility(
                                visible:
                                    detailController.person.knownAs.isNotEmpty,
                                child: SizedBox(height: 6),
                              ),
                              Visibility(
                                visible:
                                    detailController.person.knownAs.isNotEmpty,
                                child: Container(
                                  height: 36,
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        VerticalDivider(
                                      color: clrTransparent,
                                      width: 6,
                                    ),
                                    scrollDirection: Axis.horizontal,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    physics: BouncingScrollPhysics(),
                                    itemCount:
                                        detailController.person.knownAs.length,
                                    itemBuilder: (context, index) {
                                      String nickname = detailController
                                          .person.knownAs[index];
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
                                            style: TextStyle(color: clrWhite),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(height: 12),
                              Visibility(
                                visible:
                                    detailController.person.biography != null,
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: Text(
                                    detailController.person.biography,
                                    style: TextStyle(color: clrWhite),
                                  ),
                                ),
                              ),
                              SizedBox(height: 12),
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
                          child: Icon(
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
