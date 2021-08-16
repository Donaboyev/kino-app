import 'package:get/get.dart';

abstract class BaseController extends GetxController {
  final RxBool isLoading = false.obs;

  void setLoading(bool value) {
    isLoading.value = value;
  }
}
