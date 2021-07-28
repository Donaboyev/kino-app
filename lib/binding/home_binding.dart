import 'package:get/get.dart';
import 'package:kino_app/controller/home/home_controller.dart';
import 'package:kino_app/data/data_sources/remote/remote_source.dart';
import 'package:kino_app/data/remote/api_client.dart';
import 'package:kino_app/data/repository/home_repository.dart';

class HomeBinding implements Bindings {
  @override
  Future<void> dependencies() async {
    final homeRepository = HomeRepository(
      remoteSource: RemoteSource(
        apiClient: ApiClient.getInstance(),
      ),
    );
    await Get.putAsync<HomeController>(
      () async {
        return HomeController(repository: homeRepository);
      },
    );
  }
}
