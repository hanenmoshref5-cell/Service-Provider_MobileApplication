import 'package:dio/dio.dart';
import 'package:finall/feature/Entities/data_layer/models/entitiesClass.dart';
import 'package:get/get.dart';

class EntitiesController extends GetxController {
  final Dio dio = Dio(BaseOptions(baseUrl: 'http://94.72.98.154:8085/api/'));

  var isLoading = false.obs;
  var government = <Government>[].obs;

  var searchText = ''.obs;

  Future<void> fetchgovernment({String search = ''}) async {
    try { 
      isLoading.value = true;
 
      final response = await dio.get(
        'goverment-entities',
        queryParameters: search.isNotEmpty ? {'search': search} : null,
      );
      print('RAW RESPONSE: ${response.data}');

      government.value = Government.fromJsonList(response.data['data']);
    } catch (e) {
      print('Error fetching entites: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void onSearchChanged(String value) {
    searchText.value = value;
    fetchgovernment(search: value);
  }

  @override
  void onInit() {
    fetchgovernment();
    super.onInit();
  }


  

}
