import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kino_app/base/base_controller.dart';
import 'package:kino_app/core/constants/constants.dart';
import 'package:kino_app/data/response/person_response.dart';
import 'package:kino_app/data/repository/people_more_repository.dart';

class PeopleMoreController extends BaseController {
  final PeopleMoreRepository repository;

  PeopleMoreController({@required this.repository})
      : assert(repository != null);

  ScrollController scrollController;

  final List<Person> _people = [];
  int _totalPeoplePage = 1;
  int _peoplePage = 1;
  bool _hasNextPeople = true;
  final RxBool _isPeopleLoading = false.obs;

  @override
  void onInit() async {
    await getTrendingPeople();
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) getTrendingPeople();
    });
    super.onInit();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Future<void> getTrendingPeople() async {
    if (!_hasNextPeople) return;
    if (_peoplePage == 1)
      setLoading(true);
    else
      _isPeopleLoading.value = true;
    final result = await repository.getTrendingPeople(
      apiKey: Constants.API_KEY,
      page: _peoplePage,
    );
    _isPeopleLoading.value = false;
    setLoading(false);
    if (result is PersonResponse) {
      _totalPeoplePage = result.totalPages;
      _peoplePage++;
      if (_peoplePage > _totalPeoplePage) _hasNextPeople = false;
      _people.addAll(result.people);
      update();
    } else {
      print('===================> error: $result');
    }
  }

  List<Person> get people => _people;

  RxBool get isPeopleLoading => _isPeopleLoading;
}
