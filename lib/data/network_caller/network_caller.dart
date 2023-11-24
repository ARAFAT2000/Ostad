import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:task_manager/data/network_caller/network_response.dart';
import 'package:task_manager/ui/controllers/auth_controller.dart';

class NetworkCaller {
  Future<NetworkResponse> postRequest(String url,
      {Map<String, dynamic>? body}) async {
    try {
      log(url);
      log(body.toString());
      final Response response =
          await post(Uri.parse(url), body: jsonEncode(body), headers: {
        'Content-type': 'Application/json',
            'token': AuthController.token.toString(),
      });
      if (response.statusCode == 200) {
        log(response.headers.toString());
        log(response.statusCode.toString());
        log(response.body.toString());
        return NetworkResponse(
            isSuccess: true,
            jsonResponse: jsonDecode(response.body),
            statusCode: 200);
      } else {

        return NetworkResponse(
            isSuccess: false,
            statusCode: response.statusCode,
        jsonResponse: jsonDecode(response.body));
      }
    } catch (e) {
      return NetworkResponse(isSuccess: false, errorMessage: e.toString());
    }
  }
}

