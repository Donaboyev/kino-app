import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kino_app/controller/top_rated_more_controller.dart';
import 'package:kino_app/core/custom_widgets/nuts_activity_indicator.dart';
import 'package:kino_app/core/theme/app_colors.dart';
import 'package:kino_app/core/theme/text_styles.dart';
import 'package:kino_app/data/response/movie_response.dart';
import 'package:kino_app/ui/widgets/more_movie_item_widget.dart';

class TopRatedMorePage extends GetView<TopRatedMoreController> {
  const TopRatedMorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: clrAsset,
      body: SafeArea(
        child: GetBuilder<TopRatedMoreController>(
          builder: (moreController) => moreController.isLoading.value
              ? const Center(child: NutsActivityIndicator())
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
                            'Top rated'.toUpperCase(),
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
                                  moreController.topRatedMovies[index];
                              return MoreMovieItemWidget(movie: movie);
                            },
                            childCount: moreController.topRatedMovies.length,
                          ),
                        )
                      ],
                    ),
                    Obx(
                      () => Visibility(
                        visible: moreController.isTopRatedLoading.value,
                        child: const Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: NutsActivityIndicator(radius: 12),
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
