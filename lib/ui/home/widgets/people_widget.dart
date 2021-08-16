import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kino_app/controller/home_controller.dart';
import 'package:kino_app/core/custom_widgets/nuts_activity_indicator.dart';
import 'package:kino_app/core/theme/app_colors.dart';
import 'package:kino_app/data/response/person_response.dart';
import 'package:kino_app/routes/app_routes.dart';
import 'package:kino_app/ui/home/widgets/item_widgets/category_title_widget.dart';
import 'package:kino_app/ui/home/widgets/item_widgets/person_widget.dart';

class PeopleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategoryTitleWidget(
          title: 'Popular people',
          onTap: () => Get.toNamed(AppRoutes.PEOPLE_MORE),
        ),
        const SizedBox(height: 12),
        Column(
          children: [
            GetBuilder<HomeController>(
              builder: (homeController) => homeController.isLoading.value
                  ? const Center(child: const NutsActivityIndicator())
                  : Container(
                      height: 118,
                      child: NotificationListener<ScrollNotification>(
                        onNotification: (scrollNotification) {
                          if (scrollNotification.metrics.pixels ==
                                  scrollNotification.metrics.maxScrollExtent &&
                              scrollNotification is ScrollUpdateNotification) {
                            homeController.getTrendingPeople();
                            return true;
                          }
                          return false;
                        },
                        child: Stack(
                          children: [
                            ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: homeController.people.length,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              separatorBuilder: (context, index) =>
                                  const VerticalDivider(
                                color: clrTransparent,
                                width: 5,
                              ),
                              itemBuilder: (context, index) {
                                final Person person =
                                    homeController.people[index];
                                return PersonWidget(person: person);
                              },
                            ),
                            Obx(
                              () => Visibility(
                                visible: homeController.isPeopleLoading.value,
                                child: const Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: const Align(
                                    alignment: Alignment.centerRight,
                                    child:
                                        const NutsActivityIndicator(radius: 12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        )
      ],
    );
  }
}
