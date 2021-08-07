import 'package:get/get.dart';
import 'package:kino_app/controller/discover_more_controller.dart';
import 'package:kino_app/controller/movie_detail_controller.dart';
import 'package:kino_app/controller/now_playing_more_controller.dart';
import 'package:kino_app/controller/person_detail_controller.dart';
import 'package:kino_app/data/data_sources/remote/remote_source.dart';
import 'package:kino_app/data/remote/api_client.dart';
import 'package:kino_app/data/repository/discover_more_repository.dart';
import 'package:kino_app/data/repository/movie_detail_repository.dart';
import 'package:kino_app/data/repository/now_playing_more_repository.dart';
import 'package:kino_app/data/repository/person_detail_repository.dart';

class NowPlayingMoreBinding implements Bindings {
  @override
  void dependencies() async {
    var moreRepository = NowPlayingMoreRepository(
      remoteSource: RemoteSource(
        apiClient: ApiClient.getInstance(),
      ),
    );
    Get.lazyPut<NowPlayingMoreController>(
      () => NowPlayingMoreController(repository: moreRepository),
    );
  }
}
