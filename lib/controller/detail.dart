import 'package:get/get.dart';
import 'package:rezflux_app/view_models/detailrestaurant.dart';

class DetailController extends GetxController with StateMixin {
  ApiProvider _apiProvider = ApiProvider();

  String parameter;

  DetailController(this.parameter);
  @override
  void onInit() {
    super.onInit();
    _apiProvider.fetchDetailRestaurants(parameter).then((response) {
      change(response, status: RxStatus.success());
    }, onError: (err) {
      change(null, status: RxStatus.error(err.toString()));
    });
  }
}
