import 'package:get/get.dart';

import '../data/repository/discover_more_repository.dart';
import '../controller/discover_more_controller.dart';
import '../data/remote/remote_source.dart';
import '../data/network/api_client.dart';

class DiscoverMoreBinding implements Bindings {
  @override
  void dependencies() async {
    var moreRepository = DiscoverMoreRepository(
      remoteSource: RemoteSource(
        apiClient: ApiClient.getInstance()!,
      ),
    );
    Get.lazyPut<DiscoverMoreController>(
      () => DiscoverMoreController(repository: moreRepository),
    );
  }
}
