import 'package:get/get.dart';

import '../data/repository/popular_more_repository.dart';
import '../controller/popular_more_controller.dart';
import '../data/remote/remote_source.dart';
import '../data/network/api_client.dart';

class PopularMoreBinding implements Bindings {
  @override
  void dependencies() async {
    var moreRepository = PopularMoreRepository(
      remoteSource: RemoteSource(
        apiClient: ApiClient.getInstance()!,
      ),
    );
    Get.lazyPut<PopularMoreController>(
      () => PopularMoreController(repository: moreRepository),
    );
  }
}
