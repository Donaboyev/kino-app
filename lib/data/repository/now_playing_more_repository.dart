import 'package:flutter/foundation.dart';
import 'package:kino_app/data/data_sources/remote/remote_source.dart';

class NowPlayingMoreRepository {
  final RemoteSource remoteSource;

  const NowPlayingMoreRepository({@required this.remoteSource})
      : assert(remoteSource != null);

  Future<dynamic> getNowPlayingMovies({
    @required String apiKey,
    @required int page,
  }) async {
    final response =
        await remoteSource.getNowPlayingMovies(apiKey: apiKey, page: page);
    if (response.data != null) {
      return response.data;
    }
    return 'Error occurred';
  }
}
