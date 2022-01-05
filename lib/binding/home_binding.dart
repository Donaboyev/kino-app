import 'package:get/get.dart';

import '../data/repository/home_repository.dart';
import '../controller/home_controller.dart';
import '../data/remote/remote_source.dart';
import '../data/network/api_client.dart';

class HomeBinding implements Bindings {
  @override
  Future<void> dependencies() async {
    final homeRepository = HomeRepository(
      remoteSource: RemoteSource(
        apiClient: ApiClient.getInstance()!,
      ),
    );
    await Get.putAsync<HomeController>(
      () async => HomeController(repository: homeRepository),
    );
  }
}
