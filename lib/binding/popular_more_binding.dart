import 'package:get/get.dart';
import 'package:kino_app/controller/popular_more_controller.dart';
import 'package:kino_app/data/remote/remote_source.dart';
import 'package:kino_app/data/remote/client/api_client.dart';
import 'package:kino_app/data/repository/popular_more_repository.dart';

class PopularMoreBinding implements Bindings {
  @override
  void dependencies() async {
    var moreRepository = PopularMoreRepository(
      remoteSource: RemoteSource(
        apiClient: ApiClient.getInstance(),
      ),
    );
    Get.lazyPut<PopularMoreController>(
      () => PopularMoreController(repository: moreRepository),
    );
  }
}
