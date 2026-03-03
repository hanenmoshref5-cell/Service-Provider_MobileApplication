import 'package:dio/dio.dart';
import 'package:finall/feature/categories/data_layer/models/categoryClass.dart';

class CategoryService {
  Dio dio = Dio();

  Future<List<CategoryClass>> getCategories() async {
    try {
      Response response = await dio.get(
        'http://94.72.98.154:8085/api/categories',
        options: Options(headers: {'Accept': 'application/json'}),
      );
      if (response.statusCode == 200) {
        return CategoryClass.fromJsonList(response.data);
      } else {
        return [];
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw 'connection error . please check your internet';
      }
      throw e.response?.data["message"];
    } catch (e) {
      throw 'unexpected error:$e';
    }
  }

  Future<List<SubCategoryClass>> getSubCategories(int categoryId) async {
    try {
      Response response = await dio.get(
        'http://94.72.98.154:8085/api/sub-categories',
        options: Options(headers: {'Accept': 'application/json'}),
        queryParameters: {
          'category_id': categoryId,
        }, 
      );
      if (response.statusCode == 200) {
        return SubCategoryClass.fromJsonList(response.data);
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
