import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kino_app/controller/home/home_controller.dart';
import 'package:kino_app/core/theme/app_colors.dart';
import 'package:kino_app/data/model/response/person_response.dart';

class PeopleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Trending persons on this week'.toUpperCase(),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.black45,
          ),
        ),
        SizedBox(height: 12),
        Column(
          children: [
            GetBuilder<HomeController>(
              builder: (homeController) => Container(
                height: 110,
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: homeController.people.length,
                  separatorBuilder: (context, index) => VerticalDivider(
                    color: Colors.transparent,
                    width: 5,
                  ),
                  itemBuilder: (context, index) {
                    Person person = homeController.people[index];
                    return Container(
                      child: Column(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                100,
                              ),
                            ),
                            elevation: 3,
                            child: ClipRRect(
                              child: CachedNetworkImage(
                                imageUrl:
                                    'https://image.tmdb.org/t/p/w200${person.profilePath}',
                                imageBuilder: (context, imageProvider) {
                                  return Container(
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(100),
                                      ),
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
                                  child: Center(
                                    child: CupertinoActivityIndicator(),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  width: 80,
                                  height: 80,
                                  child: Center(child: Text('error')),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Center(
                              child: Text(
                                person.name.toUpperCase(),
                                style: TextStyle(
                                  color: clrBlack,
                                  fontSize: 8,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            child: Center(
                              child: Text(
                                person.knowForDepartment.toUpperCase(),
                                style: TextStyle(
                                  color: clrBlack,
                                  fontSize: 8,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
