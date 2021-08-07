import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kino_app/controller/now_playing_more_controller.dart';
import 'package:kino_app/core/theme/app_colors.dart';
import 'package:kino_app/data/model/response/movie_response.dart';
import 'package:kino_app/ui/home/widgets/movie_item_widget.dart';
import 'package:kino_app/ui/widgets/more_movie_item_widget.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';

class NowPlayingMorePage extends GetView<NowPlayingMoreController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: clrAsset,
      body: SafeArea(
        child: GetBuilder<NowPlayingMoreController>(
          builder: (moreController) => moreController.isLoading.value
              ? Center(child: NutsActivityIndicator())
              : Stack(
                  children: [
                    CustomScrollView(
                      controller: moreController.scrollController,
                      physics: BouncingScrollPhysics(),
                      slivers: [
                        SliverAppBar(
                          floating: true,
                          backgroundColor: clrAsset,
                          elevation: 0,
                          title: Text(
                            'Now playing'.toUpperCase(),
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  color: clrWhite,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                          leading: IconButton(
                            icon: Icon(Icons.arrow_back_ios),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final Movie movie =
                                  moreController.nowPlayingMovies[index];
                              return MoreMovieItemWidget(movie: movie);
                            },
                            childCount: moreController.nowPlayingMovies.length,
                          ),
                        )
                      ],
                    ),
                    Obx(
                      () => Visibility(
                        visible: moreController.isNowPlayingLoading.value,
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
