import '../remote/remote_source.dart';

class TopRatedMoreRepository {
  final RemoteSource remoteSource;

  const TopRatedMoreRepository({required this.remoteSource});

  Future<dynamic> getTopRatedMovies({
    required String apiKey,
    required int page,
  }) async {
    final response =
        await remoteSource.getTopRatedMovies(apiKey: apiKey, page: page);
    if (response.data != null) {
      return response.data;
    }
    return 'Error occurred';
  }
}
