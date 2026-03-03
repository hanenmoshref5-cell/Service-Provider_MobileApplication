import 'package:dio/dio.dart';
import 'package:finall/feature/Providers/data_layer/models/providersClass.dart';

class ProvidersService {
  Dio dio = Dio();

  Future<List<Provider>> fetchproviders() async {
    try {
      Response response = await dio.get(
        "http://94.72.98.154:8085/api/service-providers",
      );

      if (response.statusCode == 200) {
        // ignore: unused_local_variable
        final data = response.data;

        return Provider.fromJsonList(response.data);
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
