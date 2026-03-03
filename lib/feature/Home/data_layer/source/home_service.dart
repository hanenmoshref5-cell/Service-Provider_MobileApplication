import 'package:dio/dio.dart';
import 'package:finall/feature/Home/data_layer/models/classes.dart';

class SliderService {
  Dio dio = Dio();
  Future<List<SliderItem>> fetchslider() async {
    try {
      Response response = await dio.get("http://94.72.98.154:8085/api/sliders");

      if (response.statusCode == 200) {
        // ignore: unused_local_variable
        final data = response.data;

        return SliderItem.fromJsonList(response.data);
      } else {
        return [];
      }
    } on DioException catch (e) {
      if (e.type == DioException.connectionTimeout ||
          e.type == DioException.connectionError) {
        throw "connection error.pleas check your internet";
      }
      throw e.response?.data['message'];
    }
  }
}
