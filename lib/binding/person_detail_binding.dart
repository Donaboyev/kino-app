import 'package:get/get.dart';
import 'package:kino_app/controller/movie_detail_controller.dart';
import 'package:kino_app/controller/person_detail_controller.dart';
import 'package:kino_app/data/data_sources/remote/remote_source.dart';
import 'package:kino_app/data/remote/api_client.dart';
import 'package:kino_app/data/repository/movie_detail_repository.dart';
import 'package:kino_app/data/repository/person_detail_repository.dart';

class PersonDetailBinding implements Bindings {
  @override
  void dependencies() async {
    var personDetailRepository = PersonDetailRepository(
      remoteSource: RemoteSource(
        apiClient: ApiClient.getInstance(),
      ),
    );
    Get.lazyPut<PersonDetailController>(
      () => PersonDetailController(repository: personDetailRepository),
    );
  }
}
