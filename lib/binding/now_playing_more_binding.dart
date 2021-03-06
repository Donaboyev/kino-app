import 'package:get/get.dart';
import 'package:kino_app/controller/now_playing_more_controller.dart';
import 'package:kino_app/data/remote/remote_source.dart';
import 'package:kino_app/data/network/api_client.dart';
import 'package:kino_app/data/repository/now_playing_more_repository.dart';

class NowPlayingMoreBinding implements Bindings {
  @override
  void dependencies() async {
    var moreRepository = NowPlayingMoreRepository(
      remoteSource: RemoteSource(
        apiClient: ApiClient.getInstance()!,
      ),
    );
    Get.lazyPut<NowPlayingMoreController>(
      () => NowPlayingMoreController(repository: moreRepository),
    );
  }
}
