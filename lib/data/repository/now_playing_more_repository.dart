import '../remote/remote_source.dart';

class NowPlayingMoreRepository {
  final RemoteSource remoteSource;

  const NowPlayingMoreRepository({required this.remoteSource});

  Future<dynamic> getNowPlayingMovies({
    required String apiKey,
    required int page,
  }) async {
    final response =
        await remoteSource.getNowPlayingMovies(apiKey: apiKey, page: page);
    if (response.data != null) {
      return response.data;
    }
    return 'Error occurred';
  }
}
