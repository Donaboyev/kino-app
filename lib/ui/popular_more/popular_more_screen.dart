import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/more_movie_item_widget.dart';
import '../ui.dart';

class PopularMorePage extends GetView<PopularMoreController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: clrAsset,
      body: SafeArea(
        child: GetBuilder<PopularMoreController>(
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
                            'Popular'.toUpperCase(),
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
                              final Movie movie =
                                  moreController.popularMovies[index];
                              return MoreMovieItemWidget(movie: movie);
                            },
                            childCount: moreController.popularMovies.length,
                          ),
                        )
                      ],
                    ),
                    Obx(
                      () => Visibility(
                        visible: moreController.isPopularLoading.value,
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
