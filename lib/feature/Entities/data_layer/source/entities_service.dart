import 'package:dio/dio.dart';
import 'package:finall/feature/Entities/data_layer/models/entitiesClass.dart';

class EntitiesService {
  Dio dio = Dio();

  Future<List<Government>> fetchgovernment() async {
    try {
      Response response = await dio.get(
        "http://94.72.98.154:8085/api/goverment-entities",
      );

      if (response.statusCode == 200) {
        // ignore: unused_local_variable
        final data = response.data;

        return Government.fromJsonList(response.data);
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
