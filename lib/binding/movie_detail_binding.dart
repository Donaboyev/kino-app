import 'package:get/get.dart';

import '../data/repository/movie_detail_repository.dart';
import '../controller/movie_detail_controller.dart';
import '../data/remote/remote_source.dart';
import '../data/network/api_client.dart';

class MovieDetailBinding implements Bindings {
  @override
  void dependencies() async {
    var movieDetailRepository = MovieDetailRepository(
      remoteSource: RemoteSource(
        apiClient: ApiClient.getInstance()!,
      ),
    );
    Get.lazyPut<MovieDetailController>(
      () => MovieDetailController(repository: movieDetailRepository),
    );
  }
}
