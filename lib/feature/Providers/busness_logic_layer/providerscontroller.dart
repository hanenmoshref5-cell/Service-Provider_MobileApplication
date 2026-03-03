import 'package:dio/dio.dart';
import 'package:finall/feature/Providers/data_layer/models/providersClass.dart';
import 'package:get/get.dart';

class Providerscontroller extends GetxController {
  final Dio dio = Dio(BaseOptions(baseUrl: 'http://94.72.98.154:8085/api/'));

  var isLoading = false.obs;
  var providers = <Provider>[].obs;

  var searchText = ''.obs;

  Future<void> fetchprovider({String search = ''}) async {
    try {
      isLoading.value = true;

      final response = await dio.get(
        'service-providers',
        queryParameters: search.isNotEmpty ? {'search': search} : null,
      );
      print('RAW RESPONSE: ${response.data}');

      providers.value = Provider.fromJsonList(response.data['data']);
    } catch (e) {
      print('Error fetching providers: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void onSearchChanged(String value) {
    searchText.value = value;
    fetchprovider(search: value);
  }

  @override
  void onInit() {
    fetchprovider();
    super.onInit();
  }


  var galleryImages = ['assets/images/tire1.png', 'assets/images/tire2.png'];

  var selectedTab = 0.obs;

  void changeTab(int index) {
    selectedTab.value = index;
  }
}

// class ServiceProviderModel {
//   final String name;
//   final String image;
//   final String views;

//   ServiceProviderModel({
//     required this.name,
//     required this.image,
//     required this.views,
//   });
// }
