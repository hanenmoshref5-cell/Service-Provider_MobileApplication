import 'package:dio/dio.dart';
import 'package:finall/feature/Offers/data_layer/models/offersclass.dart';
import 'package:get/get.dart';

class OfferController extends GetxController {
  final Dio dio = Dio(BaseOptions(baseUrl: 'http://94.72.98.154:8085/api/'));

  var isLoading = false.obs;
  var offers = <OfferModel>[].obs;

  var searchText = ''.obs;

  Future<void> fetchOffers({String search = ''}) async {
    try {
      isLoading.value = true;

      final response = await dio.get(
        'offers',
        queryParameters: search.isNotEmpty ? {'search': search} : null,
      );

      offers.value = OfferModel.fromJsonList(response.data);
    } catch (e) {
      print('Error fetching offers: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void onSearchChanged(String value) {
    searchText.value = value;
    fetchOffers(search: value);
  }

  @override
  void onInit() {
    fetchOffers();
    super.onInit();
  }
}
