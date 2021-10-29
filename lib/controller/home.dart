import 'package:get/get.dart';
import 'package:rezflux_app/view_models/listrestaurant.dart';

class HomeController extends GetxController with StateMixin {
  ApiProvider _apiProvider = ApiProvider();
  @override
  void onInit() {
    super.onInit();
    _apiProvider.fetchRestaurants().then((response) {
      change(response, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }
}