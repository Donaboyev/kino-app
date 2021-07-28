import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kino_app/controller/home/home_controller.dart';
import 'package:kino_app/core/theme/app_colors.dart';
import 'package:kino_app/data/model/response/genre_response.dart';

class GenresWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeController) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            SizedBox(height: 12),
            homeController.isLoading.value
                ? Center(
                    child: CupertinoActivityIndicator(),
                  )
                : Container(
                    height: 45,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => VerticalDivider(
                        color: clrTransparent,
                        width: 5,
                      ),
                      scrollDirection: Axis.horizontal,
                      physics: BouncingScrollPhysics(),
                      itemCount: homeController.genres.length,
                      itemBuilder: (context, index) {
                        Genre genre = homeController.genres[index];
                        return Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.black45,
                                ),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25),
                                ),
                                color: clrWhite,
                              ),
                              child: Text(
                                genre.name.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: clrBlack,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
