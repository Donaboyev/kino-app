import 'package:get/get.dart';
import 'package:kino_app/controller/discover_more_controller.dart';
import 'package:kino_app/data/network/api_client.dart';
import 'package:kino_app/data/remote/remote_source.dart';
import 'package:kino_app/data/repository/discover_more_repository.dart';

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
