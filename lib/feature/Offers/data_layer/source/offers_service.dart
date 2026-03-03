import 'package:dio/dio.dart';
import 'package:finall/feature/Offers/data_layer/models/offersclass.dart';

class OffersService {
  Dio dio = Dio();
  Future<List<OfferModel>> fetchoffer() async {
    try {
      Response response = await dio.get("http://94.72.98.154:8085/api/offers");

      if (response.statusCode == 200) {
        // ignore: unused_local_variable
        final data = response.data;

        return OfferModel.fromJsonList(response.data);
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
