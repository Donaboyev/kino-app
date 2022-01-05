import '../data/repository/person_detail_repository.dart';
import '../data/response/person_detail.dart';
import '../core/constants/constants.dart';
import '../base/base_controller.dart';

class PersonDetailController extends BaseController {

  PersonDetailController({required this.repository});

  final PersonDetailRepository repository;
  PersonDetail? _personDetail;
  int? _personId;

  Future<void> setPersonId(int? value) async {
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
