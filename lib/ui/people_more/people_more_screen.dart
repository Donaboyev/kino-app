import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/more_people_item_widget.dart';
import '../ui.dart';

class PeopleMorePage extends GetView<PeopleMoreController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: clrAsset,
      body: SafeArea(
        child: GetBuilder<PeopleMoreController>(
          builder: (moreController) => moreController.isLoading.value
              ? const Center(child: const NutsActivityIndicator())
              : Stack(
                  children: [
                    CustomScrollView(
                      controller: moreController.scrollController,
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverAppBar(
                          floating: true,
                          backgroundColor: clrAsset,
                          elevation: 0,
                          title: Text(
                            'Popular people'.toUpperCase(),
                            style: stySectionTitle,
                          ),
                          leading: IconButton(
                            icon: const Icon(Icons.arrow_back_ios),
                            onPressed: () => Get.back(),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final Person person =
                                  moreController.people[index];
                              return MorePeopleItemWidget(person: person);
                            },
                            childCount: moreController.people.length,
                          ),
                        )
                      ],
                    ),
                    Obx(
                      () => Visibility(
                        visible: moreController.isPeopleLoading.value,
                        child: const Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: const Align(
                            alignment: Alignment.bottomCenter,
                            child: const NutsActivityIndicator(radius: 12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
