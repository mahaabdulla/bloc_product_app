import 'package:dio/dio.dart';

class DioExceptionHandler {
  // Singleton instance
  static final DioExceptionHandler _instance = DioExceptionHandler._internal();

  // Private constructor
  DioExceptionHandler._internal();

  // Getter to access the singleton instance
  static DioExceptionHandler get instance => _instance;

  // Enable or disable logging
  bool enableLogging = false;

  // Method to handle Dio errors with Arabic messages
  String handle(DioException error) {
    if (enableLogging) {
      print('DioException: ${error.type}, Message: ${error.message}');
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'انتهت مهلة الاتصال. حاول مرة أخرى.';
      case DioExceptionType.sendTimeout:
        return 'انتهت مهلة الإرسال. حاول مرة أخرى.';
      case DioExceptionType.receiveTimeout:
        return 'انتهت مهلة الاستلام. حاول مرة أخرى.';
      case DioExceptionType.badResponse:
        return _handleBadResponse(error.response);
      case DioExceptionType.cancel:
        return 'تم إلغاء الطلب.';
      case DioExceptionType.unknown:
      default:
        return 'حدث خطأ غير متوقع: ${error.message}';
    }
  }

  String _handleBadResponse(Response? response) {
    final statusCode = response?.statusCode ?? 0;
    final message = response?.statusMessage ?? 'لا توجد رسالة من الخادم';

    if (enableLogging) {
      print('📡 HTTP $statusCode: $message');
    }

    if (statusCode >= 400 && statusCode < 500) {
      return 'خطأ من العميل [$statusCode]: $message';
    } else if (statusCode >= 500) {
      return 'خطأ من الخادم [$statusCode]: $message';
    } else {
      return 'استجابة غير متوقعة [$statusCode]: $message';
    }
  }
}
