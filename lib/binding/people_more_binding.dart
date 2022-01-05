import 'package:get/get.dart';

import '../data/repository/people_more_repository.dart';
import '../controller/people_more_controller.dart';
import '../data/remote/remote_source.dart';
import '../data/network/api_client.dart';

class PeopleMoreBinding implements Bindings {
  @override
  void dependencies() async {
    var moreRepository = PeopleMoreRepository(
      remoteSource: RemoteSource(
        apiClient: ApiClient.getInstance()!,
      ),
    );
    Get.lazyPut<PeopleMoreController>(
      () => PeopleMoreController(repository: moreRepository),
    );
  }
}
