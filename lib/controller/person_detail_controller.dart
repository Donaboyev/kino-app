import 'package:kino_app/base/base_controller.dart';
import 'package:kino_app/core/constants/constants.dart';
import 'package:kino_app/data/repository/person_detail_repository.dart';
import 'package:kino_app/data/response/person_detail.dart';

class PersonDetailController extends BaseController {
  final PersonDetailRepository repository;

  PersonDetailController({required this.repository});

  PersonDetail? _personDetail;
  int? _personId;

  void setPersonId(int? value) async {
    _personId = value;
    await getPersonDetail();
  }

  Future<void> getPersonDetail() async {
    setLoading(true);
    final result = await repository.getPersonDetail(
      apiKey: Constants.API_KEY,
      personId: _personId,
    );
    setLoading(false);
    if (result is PersonDetail) {
      _personDetail = result;
      update();
    } else {
      print('===================> error: $result');
    }
  }

  PersonDetail? get person => _personDetail;
}
