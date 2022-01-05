import 'package:get/get.dart';

import '../data/repository/person_detail_repository.dart';
import '../controller/person_detail_controller.dart';
import '../data/remote/remote_source.dart';
import '../data/network/api_client.dart';

class PersonDetailBinding implements Bindings {
  @override
  void dependencies() async {
    var personDetailRepository = PersonDetailRepository(
      remoteSource: RemoteSource(
        apiClient: ApiClient.getInstance()!,
      ),
    );
    Get.lazyPut<PersonDetailController>(
      () => PersonDetailController(repository: personDetailRepository),
    );
  }
}
