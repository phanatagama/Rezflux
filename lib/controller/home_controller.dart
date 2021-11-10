import 'package:get/get.dart';
import 'package:rezflux_app/models/detail_model.dart';
// import 'package:rezflux_app/view_models/list_restaurant_view_model.dart';
import 'package:rezflux_app/view_models/restaurant_view_model.dart';
class HomeController extends GetxController with StateMixin {
  // RxList item = [].obs;
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

  // search(String id) async {
  //   final List response = await _apiProvider.search(id);
  //   item.value = response;
  //   print(response[0].name);
  //   return response[0];
  // }
}