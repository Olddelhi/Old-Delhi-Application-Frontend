import 'package:get/get.dart';
import 'package:old_delhi_food/app/services/api_response.dart';

class YourFavouriteController extends GetxController {
  final ApiResponse _apiResponse = ApiResponse();
  var isLoading = true.obs;
  var favoriteItems = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchFavoriteItems();
  }
 @override
  void onReady() {
    super.onReady();
    fetchFavoriteItems();
    update();
  }

  Future<void> fetchFavoriteItems() async {
    try {
      isLoading.value = true;
      final response = await _apiResponse.fetchFavoriteItems();
      favoriteItems.value = response['data']['favoriteItems'];
      update();
    } catch (e) {
      print('Error fetching favorite items: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
