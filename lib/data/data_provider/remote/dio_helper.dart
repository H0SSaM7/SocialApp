import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 3000,
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'key=AAAAIYXwBtI:APA91bGSKwLb1Gtoxrs7lcH2dkMyYXX2_6yrSJ0bDFGDlH_dojhk-zuD86MW7LDOIoiE_08WGTfBSu8A7q6krAENFNFyhzXTkKfm5dFWHLkRsLhoodo9aW6nYAG-TP9MSSb-NuNWtB7H',
      },
    ));
    //     BaseOptions(baseUrl: 'https://fcm.googleapis.com/fcm/send', headers: {
    //   'Content-Type': 'application/json',
    //   'Authorization':
    //       'key=AAAAIYXwBtI:APA91bGSKwLb1Gtoxrs7lcH2dkMyYXX2_6yrSJ0bDFGDlH_dojhk-zuD86MW7LDOIoiE_08WGTfBSu8A7q6krAENFNFyhzXTkKfm5dFWHLkRsLhoodo9aW6nYAG-TP9MSSb-NuNWtB7H',
    // }));
  }

  static Future<Response> post({
    required String token,
    required String userName,
    required String message,
  }) async {
    return await dio!.post(
      'https://fcm.googleapis.com/fcm/send',
      data: {
        "to": token,
        "notification": {
          "title": userName,
          "body": message,
          "sound": "default"
        },
        "data": {
          "msgId": "msg_12342",
          "type": "order",
          "click_action": "FLUTTER_NOTIFICATION_CLICK"
        }
      },
    );
  }
}
