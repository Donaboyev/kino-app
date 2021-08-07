import 'package:get/get.dart';
import 'package:kino_app/controller/people_more_controller.dart';
import 'package:kino_app/controller/popular_more_controller.dart';
import 'package:kino_app/controller/top_rated_more_controller.dart';
import 'package:kino_app/data/data_sources/remote/remote_source.dart';
import 'package:kino_app/data/remote/api_client.dart';
import 'package:kino_app/data/repository/people_more_repository.dart';
import 'package:kino_app/data/repository/popular_more_repository.dart';
import 'package:kino_app/data/repository/top_rated_more_repository.dart';

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
