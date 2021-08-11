import 'package:get/get.dart';
import 'package:kino_app/controller/movie_detail_controller.dart';
import 'package:kino_app/data/remote/remote_source.dart';
import 'package:kino_app/data/remote/client/api_client.dart';
import 'package:kino_app/data/repository/movie_detail_repository.dart';

class MovieDetailBinding implements Bindings {
  @override
  void dependencies() async {
    var movieDetailRepository = MovieDetailRepository(
      remoteSource: RemoteSource(
        apiClient: ApiClient.getInstance(),
      ),
    );
    Get.lazyPut<MovieDetailController>(
      () => MovieDetailController(repository: movieDetailRepository),
    );
  }
}
