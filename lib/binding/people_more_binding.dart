import 'package:get/get.dart';
import 'package:kino_app/controller/people_more_controller.dart';
import 'package:kino_app/data/remote/remote_source.dart';
import 'package:kino_app/data/remote/client/api_client.dart';
import 'package:kino_app/data/repository/people_more_repository.dart';

class PeopleMoreBinding implements Bindings {
  @override
  void dependencies() async {
    var moreRepository = PeopleMoreRepository(
      remoteSource: RemoteSource(
        apiClient: ApiClient.getInstance(),
      ),
    );
    Get.lazyPut<PeopleMoreController>(
      () => PeopleMoreController(repository: moreRepository),
    );
  }
}
