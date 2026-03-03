import 'dart:developer';
import 'dart:io';
import 'package:finall/common/core/homeMaster.dart';
import 'package:finall/feature/auth/data_layer/model/profile_model.dart';
import 'package:finall/feature/auth/data_layer/source/auth_service.dart';
import 'package:finall/feature/auth/presntation_layer/screen/Resetpassword.dart';
import 'package:finall/feature/auth/presntation_layer/screen/VerifyCode.dart';
import 'package:finall/feature/auth/presntation_layer/screen/splash_screen.dart';
import 'package:finall/feature/setting/presentation_layer/screen/Settingspage.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as img;

class AuthController extends GetxController {
  final OuthService _authService = OuthService();
  final box = GetStorage();

  RxBool isLoading = false.obs;
  RxBool resetSuccess = false.obs;
  RxBool changSuccess = false.obs;

  // Profile data
  Rx<ProfileModel?> profileData = Rx<ProfileModel?>(null);
  RxBool isProfileLoading = false.obs;

  // String phone = "";
  Future<void> login(String phone, String password) async {
    try {
      isLoading.value = true;
      // isError.value = false;

      bool success = await _authService.login(phone: phone, password: password);

      if (success) {
        log("Login Success");
        // Load user profile data after login
        await loadProfile();
        isLoading.value = false;
        Get.snackbar('نجاح', 'تم الدخول بنجاح');
        Get.off(HomeMaster());
      } else {
        isLoading.value = false;
        log("Login Failed");
        Get.snackbar('خطأ', 'فشل تسجيل الدخول');
      }
    } catch (e) {
      isLoading.value = false;
      Future.microtask(() {
        Get.snackbar('خطأ', e.toString());
      });
    }
  }

  Future<void> signup({
    required String firstName,
    required String lastName,
    required String phone,
    required String password,
    required String passwordConfirmation,
    required int cityId,
  }) async {
    try {
      isLoading.value = true;

      bool success = await _authService.register(
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        password: password,
        passwordConfirmation: passwordConfirmation,
        cityId: cityId,
      );

      if (success) {
        log("Sign Up Success");
        isLoading.value = false;

        // After signup, user needs to verify phone number
        // Go directly to verification screen
        Get.snackbar('نجاح', 'تم التسجيل بنجاح، الرجاء تأكيد رقم الهاتف');
        Get.offAll(Verifycode(phone: phone, forVerifyAccount: 1));
      } else {
        isLoading.value = false;
        log("Sign Up Failed");
        Get.snackbar('خطأ', 'فشل التسجيل');
      }
    } catch (e) {
      isLoading.value = false;
      Future.microtask(() {
        Get.snackbar('خطأ', e.toString());
      });
    }
  }

  Future<void> forgetPassword({required String phone}) async {
    try {
      isLoading.value = true;

      bool success = await _authService.forgetPassword(phone: phone);

      isLoading.value = false;
      if (success) {
        log("Forget Password Request Success");
        Get.snackbar('نجاح', 'تم إرسال كود التحقق');
        // Pass forVerifyAccount = 0 to indicate this is for password reset
        Get.to(Verifycode(phone: phone, forVerifyAccount: 0));
      } else {
        log("Forget Password Request Failed");
      }
    } catch (e) {
      isLoading.value = false;
      Future.microtask(() {
        Get.snackbar('خطأ', e.toString());
      });
    }
  }

  Future<void> verifyCode({
    required String phone,
    required int code,
    int forVerifyAccount = 1,
  }) async {
    try {
      isLoading.value = true;

      bool success = await _authService.verifyCode(
        phone: phone,
        code: code,
        forVerifyAccount: forVerifyAccount,
      );

      if (success) {
        log("Verify Code Success");

        // Check if token was saved from verify response
        String? tokenAfterVerify = _authService.box.read("my_auth");
        log(
          "Token after verify: ${tokenAfterVerify != null ? 'EXISTS' : 'NULL'}",
        );

        isLoading.value = false;

        // If this is for account verification (signup flow)
        if (forVerifyAccount == 1) {
          log(
            "Verification for account creation - loading profile and going to home",
          );
          try {
            await loadProfile();
            Get.snackbar('نجاح', 'تم التحقق من الهاتف بنجاح');
            Get.offAll(HomeMaster());
          } catch (e) {
            log("Profile load error after account verification: $e");
            // Even if profile load failed, token is verified, go to home
            Get.snackbar('نجاح', 'تم التحقق من الهاتف');
            Get.offAll(HomeMaster());
          }
        } else {
          // If this is for password reset
          log(
            "Verification for password reset - going to reset password screen",
          );
          Get.snackbar('نجاح', 'تم التحقق بنجاح');
          Get.to(Resetpassword(phone: phone, code: code));
        }
      } else {
        isLoading.value = false;
        log("Verify Code Failed");
        Get.snackbar('خطأ', 'فشل التحقق من الرمز');
      }
    } catch (e) {
      isLoading.value = false;
      Future.microtask(() {
        Get.snackbar('خطأ', e.toString());
      });
    }
  }

  Future<void> resendCode({required String phone}) async {
    try {
      bool success = await _authService.resendCode(phone: phone);

      if (success) {
        log("Resend Code Success");
        Future.microtask(() {
          Get.snackbar('sucssfull', 'Code Resent Successfully');
        });
      } else {
        log("Resend Code Failed");
      }
    } catch (e) {
      Future.microtask(() {
        Get.snackbar('error', e.toString());
      });
    }
  }

  Future<void> resetPassword({
    required String phone,
    required int code,
    required String password,
    required String passwordConfirmation,
  }) async {
    try {
      isLoading.value = true;

      bool success = await _authService.resetPassword(
        phone: phone,
        code: code,
        password: password,
        passwordConfirmation: passwordConfirmation,
      );

      isLoading.value = false;
      if (success) {
        log("Reset Password Success");
        resetSuccess.value = true;
        Future.microtask(() {
          Get.snackbar('نجح', 'تم إعادة تعيين كلمة المرور بنجاح');
        });
      } else {
        log("Reset Password Failed");
        resetSuccess.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      resetSuccess.value = false;
      Future.microtask(() {
        Get.snackbar('خطأ', e.toString());
      });
    }
  }

  Future<void> changpassword({
    required String oldPassword,
    required String newPassword,
    required String newPasswordConfirmation,
  }) async {
    try {
      isLoading.value = true;

      bool success = await _authService.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
        newPasswordConfirmation: newPasswordConfirmation,
      );

      isLoading.value = false;
      if (success) {
        log("chang Password Success");
        changSuccess.value = true;
        Future.microtask(() {
          Get.snackbar('success', 'Password changed successfully');
        });
        Get.to(Settingspage());
      } else {
        changSuccess.value = false;
        log("change Password Failed");
      }
    } catch (e) {
      isLoading.value = false;
      changSuccess.value = false;
      Future.microtask(() {
        Get.snackbar('faild', e.toString());
      });
    }
  }

  Future<void> becomeProvider({
    required String providerName,
    required Map<String, String> shopName,
    required int subCategoryId,
    required Map<String, String> description,
    required int cityId,
    required List<Map<String, dynamic>> socialLinks,
  }) async {
    try {
      isLoading.value = true;

      bool success = await _authService.becomeProvider(
        providerName: providerName,
        shopName: shopName,
        subCategoryId: subCategoryId,
        description: description,
        cityId: cityId,
        socialLinks: socialLinks,
      );

      isLoading.value = false;
      if (success) {
        log("Become Provider Success");
        Future.microtask(() {
          Get.snackbar('sucess', 'provider request sent successfully');
        });
        // يمكنك إضافة Get.to() للذهاب لصفحة أخرى بعد النجاح
      } else {
        log("Become Provider Failed");
        Future.microtask(() {
          Get.snackbar('faild', 'faild to send provider request');
        });
      }
    } catch (e) {
      isLoading.value = false;
      Future.microtask(() {
        Get.snackbar('faild', e.toString());
      });
    }
  }

  // Future<void> otpcheck(String phone, String codeotp) async {
  //   try{
  //   isLoading.value = true;
  //   // isError.value = false;

  //   bool success = await _authService.otpcheck(phone: phone, codeotp: codeotp);

  //   isLoading.value = false;
  //   if (success) {
  //     log("Success");
  //     Get.to(First());

  //   } else {
  //     log("error");
  //     // isError.value = true;
  //   }}
  //   catch(e){
  //       isLoading.value = false;
  //     Get.snackbar('failed', e.toString());
  //   }
  // }

  Future<void> logout() async {
    try {
      isLoading.value = true;

      bool success = await _authService.logout();

      isLoading.value = false;
      if (success) {
        log("Logout Success");
        Future.microtask(() {
          Get.snackbar('success', 'done to log out');
        });
        Get.offAll(SplashScreen());
      } else {
        log("Logout Failed");
        Future.microtask(() {
          Get.snackbar('faild', 'faild to log out');
        });
      }
    } catch (e) {
      isLoading.value = false;
      Future.microtask(() {
        Get.snackbar('faild', e.toString());
      });
    }
  }

  Future<void> loadProfile() async {
    try {
      isProfileLoading.value = true;

      ProfileModel profile = await _authService.getProfile();
      profileData.value = profile;

      log("Profile loaded successfully: ${profile.getFullName()}");
      isProfileLoading.value = false;
    } catch (e) {
      isProfileLoading.value = false;
      log("Failed to load profile: $e");
      // لا نعرض snack bar هنا، نترك المكون يتعامل مع القيم الافتراضية
    }
  }

  Future<void> updateProfile({
    required String firstName,
    required String lastName,
    required String phone,
    required String cityId,
    String? imagePath,
  }) async {
    try {
      isLoading.value = true;

      log("==================== UPDATE PROFILE START ====================");
      log("UPDATE PROFILE CONTROLLER - Image path: $imagePath");
      log("UPDATE PROFILE CONTROLLER - Image is empty: ${imagePath?.isEmpty}");
      log("UPDATE PROFILE CONTROLLER - Image is null: ${imagePath == null}");

      if (imagePath != null) {
        final file = File(imagePath);
        final exists = await file.exists();
        log("UPDATE PROFILE CONTROLLER - File exists: $exists");
        if (exists) {
          final size = file.lengthSync();
          log(
            "UPDATE PROFILE CONTROLLER - File size: ${(size / 1024).toStringAsFixed(2)} KB",
          );
        }
      }

      // Only send image if it's a new selection (local file path)
      String? imageToSend;
      if (imagePath != null &&
          imagePath.isNotEmpty &&
          !imagePath.startsWith('http')) {
        log("UPDATE PROFILE CONTROLLER - Compressing image...");
        // ضغط الصورة قبل الإرسال
        final compressedImagePath = await _compressImage(imagePath);
        imageToSend = compressedImagePath;

        final compressedFile = File(compressedImagePath);
        final compressedExists = await compressedFile.exists();
        log(
          "UPDATE PROFILE CONTROLLER - Compressed file exists: $compressedExists",
        );
        if (compressedExists) {
          final compressedSize = compressedFile.lengthSync();
          log(
            "UPDATE PROFILE CONTROLLER - Compressed file size: ${(compressedSize / 1024).toStringAsFixed(2)} KB",
          );
        }

        log(
          "UPDATE PROFILE CONTROLLER - Sending compressed image: $imageToSend",
        );
      } else {
        log(
          "UPDATE PROFILE CONTROLLER - No new image selected or image is URL",
        );
      }

      final updatedProfile = await _authService.updateProfile(
        firstName: firstName,
        lastName: lastName,
        phone: phone,
        cityId: cityId,
        imagePath: imageToSend,
      );

      profileData.value = updatedProfile;
      log(" Profile data updated locally with new image");

      // If image was updated, save the image path to local storage
      if (imageToSend != null && imageToSend.isNotEmpty) {
        log(" Saving image path to local storage...");
        await box.write('img', imageToSend);
        log(" Image path saved: $imageToSend");
      }

      isLoading.value = false;

      Future.microtask(() {
        Get.snackbar('نجاح', 'تم تحديث الملف الشخصي بنجاح');
      });

      Get.back();
    } catch (e) {
      isLoading.value = false;
      log("Failed to update profile: $e");

      Future.microtask(() {
        Get.snackbar('خطأ', e.toString());
      });
    }
  }

  /// ضغط الصورة قبل الإرسال للـ API
  Future<String> _compressImage(String imagePath) async {
    try {
      log("==================== COMPRESSION START ====================");
      final originalFile = File(imagePath);

      // التحقق من وجود الملف
      if (!await originalFile.exists()) {
        log("⚠️ COMPRESSION ERROR - Original image file not found: $imagePath");
        return imagePath;
      }

      // الحصول على حجم الملف الأصلي (بـ KB)
      final originalSize = originalFile.lengthSync() / 1024;
      log("📦 Original image size: ${originalSize.toStringAsFixed(2)} KB");

      // إذا كانت الصورة صغيرة جداً، لا نضغطها
      if (originalSize < 100) {
        log(
          "✅ Image is already small (${originalSize.toStringAsFixed(2)} KB), returning original",
        );
        return imagePath;
      }

      // مسار الملف المضغوط
      final directory = await getApplicationDocumentsDirectory();
      final compressedImagePath =
          '${directory.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg';
      log("🎯 Compressed image path: $compressedImagePath");

      // قراءة الصورة الأصلية
      final imageBytes = await originalFile.readAsBytes();
      log("📥 Image bytes read: ${imageBytes.length} bytes");

      // فك تشفير الصورة
      final decodedImage = img.decodeImage(imageBytes);
      if (decodedImage == null) {
        log("❌ COMPRESSION ERROR - Failed to decode image");
        return imagePath;
      }
      log("✓ Image decoded successfully");

      // ضغط الصورة بتقليل الجودة والحجم
      final compressedImage = img.encodeJpg(decodedImage, quality: 70);
      log("✓ Image encoded with quality 70");

      // كتابة الصورة المضغوطة
      final compressedFile = File(compressedImagePath);
      await compressedFile.writeAsBytes(compressedImage);
      log("✓ Compressed image written to file");

      // التحقق من أن الملف تم كتابته
      final compressedFileExists = await compressedFile.exists();
      log("🔍 Compressed file exists: $compressedFileExists");

      // الحصول على حجم الملف المضغوط
      final compressedSize = compressedFile.lengthSync() / 1024;
      final reduction = ((originalSize - compressedSize) / originalSize * 100);

      log("📦 Compressed image size: ${compressedSize.toStringAsFixed(2)} KB");
      log("📊 Size reduction: ${reduction.toStringAsFixed(1)}%");
      log("==================== COMPRESSION COMPLETE ====================");

      return compressedImagePath;
    } catch (e) {
      log("❌ COMPRESSION ERROR - Error during image compression: $e");
      // إذا فشل الضغط، نرجع الملف الأصلي
      return imagePath;
    }
  }
}
