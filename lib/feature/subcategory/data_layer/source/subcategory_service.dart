import 'package:dio/dio.dart';
import 'package:finall/feature/Providers/data_layer/models/providersClass.dart';
import 'package:finall/feature/categories/data_layer/models/categoryClass.dart';

class SubCategoryService {
  Dio dio = Dio();

  Future<List<SubCategoryClass>> getSubCategories(int categoryId) async {
    try {
      Response response = await dio.get(
        'http://94.72.98.154:8085/api/sub-categories',
        options: Options(headers: {'Accept': 'application/json'}),
        queryParameters: {'category_ids[0]': categoryId},
      );
      if (response.statusCode == 200) {
        return SubCategoryClass.fromJsonList(response.data['data']);
      } else {
        return [];
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw 'Connection error. Please check your internet.';
      }
      throw e.response?.data["message"];
    } catch (e) {
      throw 'Unexpected error: $e';
    }
  }

  Future<List<Provider>> getSubprovider(int categoryId) async {
    try {
      Response response = await dio.get(
        'http://94.72.98.154:8085/api/service-providers',
        options: Options(headers: {'Accept': 'application/json'}),
        queryParameters: {'category_id': categoryId},
      );
      if (response.statusCode == 200) {
        return Provider.fromJsonList(response.data['data']);
      } else {
        return [];
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw 'Connection error. Please check your internet.';
      }
      throw e.response?.data["message"];
    } catch (e) {
      throw 'Unexpected error: $e';
    }
  }
}
