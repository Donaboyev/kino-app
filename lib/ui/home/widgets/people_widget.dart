import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'item_widgets/category_title_widget.dart';
import 'item_widgets/person_widget.dart';
import '../../ui.dart';

class PeopleWidget extends StatelessWidget {
  const PeopleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategoryTitleWidget(
          title: 'Popular people',
          onTap: () => Get.toNamed(AppRoutes.peopleMore),
        ),
        const SizedBox(height: 12),
        Column(
          children: [
            GetBuilder<HomeController>(
              builder: (homeController) => homeController.isLoading.value
                  ? const Center(child: NutsActivityIndicator())
                  : SizedBox(
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
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child:
                                        NutsActivityIndicator(radius: 12),
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
