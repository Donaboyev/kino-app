import 'package:kino_app/data/remote/remote_source.dart';

class PeopleMoreRepository {
  final RemoteSource remoteSource;

  const PeopleMoreRepository({required this.remoteSource});

  Future<dynamic> getTrendingPeople(
      {required String apiKey, required int page}) async {
    final response =
        await remoteSource.getTrendingPersons(apiKey: apiKey, page: page);
    if (response.data != null) {
      return response.data;
    }
    return 'Error occurred';
  }
}
