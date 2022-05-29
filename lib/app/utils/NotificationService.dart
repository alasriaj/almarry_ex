import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

class NotificationService {
  Future<void> sendPushNotifications(String title, String content,
      {String? userId = ''}) async {
    Map req = {
      'headings': {
        'en': title,
        'ar': title,
      },
      'contents': {
        'en': content,
        'ar': content,
      },
      'app_id': '5e341cd9-589e-48cb-9d25-604afd3b6027',
    };
    if (userId!.isNotEmpty) {
      req.addAll({
        'include_player_ids': [userId]
      });
    } else
      req.addAll({
        'included_segments': ['All']
      });
    req.addAll({'app_id': '5e341cd9-589e-48cb-9d25-604afd3b6027'});
    var header = {
      HttpHeaders.authorizationHeader:
          'Basic NmJjYTMzNmYtZDYxOS00ZDQyLWE5ZTMtYTNjNjdkMmI1MmMx',
      HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
    };

    print(jsonEncode(req));
    Response res = await post(
      Uri.parse('https://onesignal.com/api/v1/notifications'),
      body: jsonEncode(req),
      headers: header,
    );

    print(res.statusCode);
    print(res.body);

    if (res.statusCode == 200) {
    } else {}
  }
}
