import 'package:get/get.dart';

import '../data/repository/top_rated_more_repository.dart';
import '../controller/top_rated_more_controller.dart';
import '../data/remote/remote_source.dart';
import '../data/network/api_client.dart';

class TopRatedMoreBinding implements Bindings {
  @override
  void dependencies() async {
    var moreRepository = TopRatedMoreRepository(
      remoteSource: RemoteSource(
        apiClient: ApiClient.getInstance()!,
      ),
    );
    Get.lazyPut<TopRatedMoreController>(
      () => TopRatedMoreController(repository: moreRepository),
    );
  }
}
