import 'package:get/get.dart';

import '../data/repository/now_playing_more_repository.dart';
import '../controller/now_playing_more_controller.dart';
import '../data/remote/remote_source.dart';
import '../data/network/api_client.dart';

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
