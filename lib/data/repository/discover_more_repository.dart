import 'package:kino_app/data/remote/remote_source.dart';

class DiscoverMoreRepository {
  final RemoteSource remoteSource;

  const DiscoverMoreRepository({required this.remoteSource});

  Future<dynamic> getMoviesByGenre({
    required int? genreId,
    required String apiKey,
    required int page,
  }) async {
    final response = await remoteSource.getMoviesByGenre(
        genreId: genreId, page: page, apiKey: apiKey);
    if (response.data != null) {
      return response.data;
    }
    return 'Error occurred';
  }

  Future<dynamic> getGenres({required String apiKey}) async {
    final response = await remoteSource.getGenres(apiKey: apiKey);
    if (response.data != null) {
      return response.data;
    }
    return 'Error occurred';
  }
}
