// import 'dart:developer';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:finall/feature/auth/data_layer/model/profile_model.dart';

class OuthService {
  late Dio dio;
  GetStorage box = GetStorage();

  OuthService() {
    dio = Dio();
    // إضافة logging interceptor
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
          log("=== REQUEST ===");
          log("URL: ${options.uri}");
          log("Method: ${options.method}");
          log("Headers: ${options.headers}");
          log("Data: ${options.data}");
          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          log("=== RESPONSE ===");
          log("Status Code: ${response.statusCode}");
          log("Data: ${response.data}");
          return handler.next(response);
        },
        onError: (DioException e, ErrorInterceptorHandler handler) {
          log("=== ERROR ===");
          log("Status Code: ${e.response?.statusCode}");
          log("Data: ${e.response?.data}");
          return handler.next(e);
        },
      ),
    );
  }

  Future<bool> login({required String phone, required String password}) async {
    try {
      Response response = await dio.post(
        'http://94.72.98.154:8085/api/auth/login',
        data: {"phone": phone, "password": password},
        options: Options(headers: {'Accept': 'application/json'}),
      );
      if (response.statusCode == 200) {
        try {
          final token =
              response.data?["data"]?["token"] ?? response.data?["token"];
          if (token != null && token.toString().isNotEmpty) {
            log('Token from response: $token');
            box.write("my_auth", token.toString());
            log('Token saved. Reading back: ${box.read("my_auth")}');
            return true;
          } else {
            log('No valid token in login response');
            return false;
          }
        } catch (e) {
          log('Error parsing token: $e');
          return false;
        }
      } else {
        return false;
      } 
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw "no enternet in your mobile";
      }
      final message =
          e.response?.data?["message"] ??
          e.response?.data?["errors"]?["phone"]?[0] ??
          "Unexpected server error";
      log("ERROR MESSAGE: $message");
      throw message;
    } catch (e) {
      throw 'unexpected error: $e';
    }
  }

  Future<bool> register({
    required String firstName,
    required String lastName,
    required String phone,
    required String password,
    required String passwordConfirmation,
    required int cityId,
  }) async {
    try {
      Response response = await dio.post(
        'http://94.72.98.154:8085/api/auth/register',
        data: {
          "first_name": firstName,
          "last_name": lastName,
          "phone": phone,
          "password": password,
          "password_confirmation": passwordConfirmation,
          "city_id": cityId,
        },
        options: Options(headers: {'Accept': 'application/json'}),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        log("Register Success");
        // Try to get token if it exists in response
        try {
          final token =
              response.data?["data"]?["token"] ?? response.data?["token"];
          if (token != null && token.toString().isNotEmpty) {
            log('Token from register: $token');
            box.write("my_auth", token.toString());
            log('Register token saved. Reading back: ${box.read("my_auth")}');
          } else {
            log('No token in register response - will need to login manually');
          }
        } catch (e) {
          log('Error parsing token in register: $e');
        }
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw "no internet in your mobile";
      }
      final message =
          e.response?.data?["message"] ??
          e.response?.data?["errors"]?["phone"]?[0] ??
          e.response?.data?["errors"]?["password"]?[0] ??
          "Unexpected server error";
      log("ERROR MESSAGE: $message");
      throw message;
    } catch (e) {
      throw 'unexpected error: $e';
    }
  }

  Future<bool> forgetPassword({required String phone}) async {
    try {
      Response response = await dio.post(
        'http://94.72.98.154:8085/api/auth/forget-password',
        data: {"phone": phone},
        options: Options(headers: {'Accept': 'application/json'}),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        log("Forget Password Request Success");
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw "no internet in your mobile";
      }
      final message =
          e.response?.data?["message"] ??
          e.response?.data?["errors"]?["phone"]?[0] ??
          "Unexpected server error";
      log("ERROR MESSAGE: $message");
      throw message;
    } catch (e) {
      throw 'unexpected error: $e';
    }
  }

  Future<bool> verifyCode({
    required String phone,
    required int code,
    int forVerifyAccount = 1,
  }) async {
    try {
      Response response = await dio.post(
        'http://94.72.98.154:8085/api/auth/verify-code',
        data: {
          "phone": phone,
          "code": code,
          "for_verifiy_account": forVerifyAccount,
        },
        options: Options(headers: {'Accept': 'application/json'}),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        log("Verify Code Success");
        log("Verify Code Response: ${response.data}");

        // Try to extract and save token from verify response
        try {
          // Check different possible paths for token in response
          final token =
              response.data?["token"] ??
              response.data?["data"]?["token"] ??
              response.data?["data"]?["access_token"] ??
              response.data?["access_token"];

          if (token != null && token.toString().isNotEmpty) {
            log('Token from verify code: $token');
            box.write("my_auth", token.toString());
            log(
              'Token saved from verify code. Reading back: ${box.read("my_auth")}',
            );
          } else {
            log('No token in verify code response');
          }
        } catch (e) {
          log('Error parsing token in verify code: $e');
        }

        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw "no internet in your mobile";
      }
      final message =
          e.response?.data?["message"] ??
          e.response?.data?["errors"]?["code"]?[0] ??
          "Unexpected server error";
      log("ERROR MESSAGE: $message");
      throw message;
    } catch (e) {
      throw 'unexpected error: $e';
    }
  }

  Future<bool> resendCode({required String phone}) async {
    try {
      Response response = await dio.post(
        'http://94.72.98.154:8085/api/auth/resend-code',
        data: {"phone": phone},
        options: Options(headers: {'Accept': 'application/json'}),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        log("Resend Code Success");
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw "no internet in your mobile";
      }
      final message =
          e.response?.data?["message"] ??
          e.response?.data?["errors"]?["phone"]?[0] ??
          "Unexpected server error";
      log("ERROR MESSAGE: $message");
      throw message;
    } catch (e) {
      throw 'unexpected error: $e';
    }
  }

  Future<bool> resetPassword({
    required String phone,
    required int code,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      Response response = await dio.post(
        'http://94.72.98.154:8085/api/auth/reset-password',
        data: {
          "phone": phone,
          "code": code,
          "password": password,
          "password_confirmation": passwordConfirmation,
        },
        options: Options(headers: {'Accept': 'application/json'}),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        log("Reset Password Success");
        return true;
      } else {
        return false;
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw "no internet in your mobile";
      }
      final message =
          e.response?.data?["message"] ??
          e.response?.data?["errors"]?["password"]?[0] ??
          e.response?.data?["errors"]?["code"]?[0] ??
          "Unexpected server error";
      log("ERROR MESSAGE: $message");
      throw message;
    } catch (e) {
      throw 'unexpected error: $e';
    }
  }

  Future<bool> changePassword({
    required String oldPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    try {
      final String? token = box.read("my_auth")?.trim();

      log("TOKEN VALUE: $token");

      if (token == null || token.isEmpty) {
        throw "User not logged in";
      }

      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      log("AUTHORIZATION: ${headers['Authorization']}");

      Response response = await dio.post(
        'http://94.72.98.154:8085/api/auth/change-password',
        data: {
          "old_password": oldPassword,
          "new_password": newPassword,
          "new_password_confirmation": newPasswordConfirmation,
        },
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        final success = response.data["success"] == true;
        log("CHANGE PASSWORD RESPONSE: ${response.data}");
        return success;
      } else {
        return false;
      }
    } on DioException catch (e) {
      log("STATUS CODE: ${e.response?.statusCode}");
      log("RESPONSE: ${e.response?.data}");

      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw "لا يوجد اتصال بالإنترنت";
      }

      final message =
          e.response?.data?["message"] ??
          e.response?.data?["errors"]?["old_password"]?[0] ??
          "Unexpected server error";
      log("CHANGE PASSWORD ERROR: $message");
      throw message;
    } catch (e) {
      throw 'unexpected error: $e';
    }
  }

  Future<bool> becomeProvider({
    required String providerName,
    required Map<String, String> shopName,
    required int subCategoryId,
    required Map<String, String> description,
    required int cityId,
    required List<Map<String, dynamic>> socialLinks,
  }) async {
    try {
      final String? token = box.read("my_auth")?.trim();

      log("TOKEN VALUE: '$token'");
      log("TOKEN IS NULL: ${token == null}");
      log("TOKEN IS EMPTY: ${token?.isEmpty ?? true}");

      if (token == null || token.isEmpty) {
        throw "User not logged in - Please login first";
      }

      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      log("AUTHORIZATION HEADER: '${headers['Authorization']}'");
      log("ALL HEADERS: $headers");

      final data = {
        "provider_name": providerName,
        "shop_name": shopName,
        "sub_category_id": subCategoryId,
        "description": description,
        "city_id": cityId,
        "social_links": socialLinks,
      };

      log("BECOME PROVIDER DATA: $data");

      Response response = await dio.post(
        'http://94.72.98.154:8085/api/service-providers',
        data: data,
        options: Options(headers: headers),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        log("BECOME PROVIDER SUCCESS: ${response.data}");
        return true;
      } else {
        log("BECOME PROVIDER FAILED: ${response.data}");
        return false;
      }
    } on DioException catch (e) {
      log("STATUS CODE: ${e.response?.statusCode}");
      log("RESPONSE: ${e.response?.data}");

      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw "no network";
      }

      final message =
          e.response?.data?["message"] ??
          e.response?.data?["errors"]?["provider_name"]?[0] ??
          e.response?.data?["errors"]?["shop_name"]?[0] ??
          "Unexpected server error";
      log("BECOME PROVIDER ERROR: $message");
      throw message;
    } catch (e) {
      throw 'unexpected error: $e';
    }
  }

  Future<bool> logout() async {
    try {
      final String? token = box.read("my_auth")?.trim();

      log("LOGOUT - TOKEN VALUE: '$token'");

      if (token == null || token.isEmpty) {
        throw "User not logged in";
      }

      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      log("LOGOUT - AUTHORIZATION: ${headers['Authorization']}");

      try {
        Response response = await dio.delete(
          'http://94.72.98.154:8085/api/auth/logout',
          options: Options(headers: headers),
        );

        if (response.statusCode == 200 || response.statusCode == 204) {
          log("LOGOUT API SUCCESS");
        } else {
          log("LOGOUT API FAILED: ${response.data}");
        }
      } on DioException catch (e) {
        log("LOGOUT API ERROR - STATUS CODE: ${e.response?.statusCode}");
        log("LOGOUT API ERROR - RESPONSE: ${e.response?.data}");
        // لا نرمي exception هنا، بل نحذف التوكن بأي حال
      }

      // حذف التوكن من Box بغض النظر عن نتيجة الـ API
      await box.remove("my_auth");
      log("TOKEN DELETED FROM BOX - LOGOUT SUCCESSFUL");
      return true;
    } catch (e) {
      log("LOGOUT ERROR: $e");
      throw 'unexpected error: $e';
    }
  }

  Future<ProfileModel> getProfile() async {
    try {
      final String? token = box.read("my_auth")?.trim();

      log("GET PROFILE - TOKEN VALUE: '$token'");

      if (token == null || token.isEmpty) {
        throw "User not logged in";
      }

      final headers = {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      log("GET PROFILE - AUTHORIZATION: ${headers['Authorization']}");

      Response response = await dio.get(
        'http://94.72.98.154:8085/api/auth/profile',
        options: Options(headers: headers),
      );

      if (response.statusCode == 200) {
        log("GET PROFILE SUCCESS: ${response.data}");
        final profileData = response.data['data'];
        return ProfileModel.fromJson(profileData);
      } else {
        log("GET PROFILE FAILED: ${response.data}");
        throw "Failed to fetch profile";
      }
    } on DioException catch (e) {
      log("GET PROFILE - STATUS CODE: ${e.response?.statusCode}");
      log("GET PROFILE - RESPONSE: ${e.response?.data}");

      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw "لا يوجد اتصال بالإنترنت";
      }

      final message = e.response?.data?["message"] ?? "Failed to load profile";
      log("GET PROFILE ERROR: $message");
      throw message;
    } catch (e) {
      log("GET PROFILE UNEXPECTED ERROR: $e");
      throw 'unexpected error: $e';
    }
  }

  Future<ProfileModel> updateProfile({
    required String firstName,
    required String lastName,
    required String phone,
    required String cityId,
    String? imagePath,
  }) async {
    try {
      log("==================== API UPDATE PROFILE START ====================");
      final String? token = box.read("my_auth")?.trim();

      log(
        "UPDATE PROFILE - TOKEN VALUE: '${token != null ? 'EXISTS' : 'NULL'}'",
      );

      if (token == null || token.isEmpty) {
        throw "User not logged in";
      }

      FormData formData = FormData.fromMap({
        "first_name": firstName,
        "last_name": lastName,
        "phone": phone,
        "city_id": int.tryParse(cityId) ?? int.parse(cityId),
      });

      log(" Form data fields added: first_name, last_name, phone, city_id");

      // Only add image if path is provided and file exists
      if (imagePath != null && imagePath.isNotEmpty) {
        log(" Image path provided: $imagePath");
        final file = File(imagePath);
        final fileExists = await file.exists();
        log(" Image file exists: $fileExists");

        if (fileExists) {
          final fileSize = await file.length();
          final fileSizeMB = fileSize / 1024 / 1024;
          log(
            " Image file size: ${fileSizeMB.toStringAsFixed(2)} MB (${(fileSize / 1024).toStringAsFixed(2)} KB)",
          );

          // Check file size (e.g., max 5MB)
          if (fileSize > 5 * 1024 * 1024) {
            throw "Image size is too large (max 5MB)";
          }

          // Create multipart file with proper filename
          // Add timestamp to ensure unique filename and avoid server caching
          final originalFileName = imagePath.split('/').last;
          final timestamp = DateTime.now().millisecondsSinceEpoch;
          final uniqueFileName = '${timestamp}_$originalFileName';

          log(" Creating multipart file: $uniqueFileName");
          log(" Original file name: $originalFileName");

          final multipartFile = await MultipartFile.fromFile(
            imagePath,
            filename: uniqueFileName,
          );
          formData.files.add(MapEntry("image", multipartFile));
          log(" Image file added to form data with unique name");
        } else {
          log(" Image file not found at: $imagePath");
        }
      } else {
        log(" No image path provided (imagePath: '$imagePath')");
      }

      final headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      log(" Headers set with Bearer token");
      log(" Final form data has ${formData.files.length} file(s)");

      Response response = await dio.post(
        'http://94.72.98.154:8085/api/auth/update-profile',
        data: formData,
        options: Options(headers: headers),
      );

      log(" Response status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        log(" UPDATE PROFILE SUCCESS");
        log("Response data: ${response.data}");
        final profileData = response.data['data'];
        log(
          "==================== API UPDATE PROFILE COMPLETE ====================",
        );
        return ProfileModel.fromJson(profileData);
      } else {
        log(" UPDATE PROFILE FAILED with status: ${response.statusCode}");
        log("Response: ${response.data}");
        throw "Failed to update profile";
      }
    } on DioException catch (e) {
      log(" EXCEPTION - STATUS CODE: ${e.response?.statusCode}");
      log("EXCEPTION - RESPONSE: ${e.response?.data}");
      log("EXCEPTION - MESSAGE: ${e.message}");

      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw "لا يوجد اتصال بالإنترنت";
      }

      final message =
          e.response?.data?["message"] ?? "Failed to update profile";
      log("UPDATE PROFILE ERROR: $message");
      throw message;
    } catch (e) {
      log("UPDATE PROFILE UNEXPECTED ERROR: $e");
      throw 'unexpected error: $e';
    }
  }
}
