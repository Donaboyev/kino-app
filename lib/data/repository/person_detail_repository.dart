import 'package:flutter/foundation.dart';
import 'package:kino_app/data/data_sources/remote/remote_source.dart';

class PersonDetailRepository {
  final RemoteSource remoteSource;

  const PersonDetailRepository({this.remoteSource})
      : assert(remoteSource != null);

  Future<dynamic> getPersonDetail({
    @required int personId,
    @required String apiKey,
  }) async {
    final response = await remoteSource.getPersonDetail(
      personId: personId,
      apiKey: apiKey,
    );
    if (response.data != null) {
      return response.data;
    }
    return 'Error occurred';
  }
}
