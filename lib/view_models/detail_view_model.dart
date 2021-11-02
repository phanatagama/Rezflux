import 'package:get/get.dart';
import 'package:rezflux_app/models/detail_model.dart';
var apiRes = {"error":false,"message":"success","restaurant":{"id":"s1knt6za9kkfw1e867","name":"Kafe Kita","description":"Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,","city":"Gorontalo","address":"Jln. Pustakawan no 9","pictureId":"25","rating":4.5,"categories":[{"name":"Sop"},{"name":"Modern"}],"menus":{"foods":[{"name":"Kari kacang dan telur"},{"name":"Ikan teri dan roti"},{"name":"roket penne"},{"name":"Salad lengkeng"},{"name":"Tumis leek"},{"name":"Salad yuzu"},{"name":"Sosis squash dan mint"}],"drinks":[{"name":"Jus tomat"},{"name":"Minuman soda"},{"name":"Jus apel"},{"name":"Jus mangga"},{"name":"Es krim"},{"name":"Kopi espresso"},{"name":"Jus alpukat"},{"name":"Coklat panas"},{"name":"Es kopi"},{"name":"Teh manis"},{"name":"Sirup"},{"name":"Jus jeruk"}]},"customerReviews":[{"name":"Ahmad","review":"Tidak ada duanya!","date":"13 November 2019"},{"name":"Arif","review":"Tidak rekomendasi untuk pelajar!","date":"13 November 2019"},{"name":"Gilang","review":"Tempatnya bagus namun menurut saya masih sedikit mahal.","date":"14 Agustus 2018"},{"name":"Reza","review":"Menarik","date":"3 November 2021"}]}};

class ApiProvider extends GetConnect {
  Future fetchDetailRestaurants(String parameter) async {
    Welcome data = Welcome.fromJson(apiRes);
    return data.restaurant;
    // final response = await get(
    //     'https://restaurant-api.dicoding.dev/detail/$parameter');
    // if (response.status.hasError) {
    //   print("error status " + response.statusCode.toString());
    //   return Future.error(response.statusText.toString());
    // } else {
    //   Welcome data = Welcome.fromJson(response.body);
    //   return data.restaurant;
    // }
  }
}