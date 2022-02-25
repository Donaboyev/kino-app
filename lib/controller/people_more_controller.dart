import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/repository/people_more_repository.dart';
import '../data/response/person_response.dart';
import '../core/constants/constants.dart';
import '../base/base_controller.dart';

class PeopleMoreController extends BaseController {
  PeopleMoreController({required this.repository});

  final RxBool _isPeopleLoading = false.obs;
  final PeopleMoreRepository repository;
  ScrollController? scrollController;
  final List<Person> _people = [];
  bool _hasNextPeople = true;
  int? _totalPeoplePage = 1;
  int _peoplePage = 1;

  @override
  void onInit() async {
    await getTrendingPeople();
    scrollController = ScrollController();
    scrollController?.addListener(
      () {
        if (scrollController!.position.maxScrollExtent ==
            scrollController!.position.pixels) getTrendingPeople();
      },
    );
    super.onInit();
  }

  @override
  void dispose() {
    scrollController?.dispose();
    super.dispose();
  }

  Future<void> getTrendingPeople() async {
    if (!_hasNextPeople) return;
    if (_peoplePage == 1) {
      setLoading(true);
    } else {
      _isPeopleLoading.value = true;
    }
    final result = await repository.getTrendingPeople(
      apiKey: Constants.apiKey,
      page: _peoplePage,
    );
    _isPeopleLoading.value = false;
    setLoading(false);
    if (result is PersonResponse) {
      _totalPeoplePage = result.totalPages;
      _peoplePage++;
      if (_peoplePage > _totalPeoplePage!) _hasNextPeople = false;
      _people.addAll(result.people!);
      update();
    } else {
      debugPrint('===================> error: $result');
    }
  }

  RxBool get isPeopleLoading => _isPeopleLoading;

  List<Person> get people => _people;
}
