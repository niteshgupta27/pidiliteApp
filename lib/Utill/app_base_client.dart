import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import '../routes/app_pages.dart';

import 'AppConstants.dart';
import 'Apputills.dart';
import 'app_exception.dart';
import 'app_required.dart';
import 'app_storage.dart';



//TODO: Pulling from the AppUrl instead of the AppConfig
class BaseClient extends GetConnect {


  String TAG = "BaseClient";
  static BaseClient sharedClient = BaseClient();
  static const int timeOutDuration = 50;

  static final appStorage = Get.find<AppStorage>();
  final GetConnect pidilite = Get.find<GetConnect>();

  static Map<String, String> requestHeaders() {
    return <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'token': appStorage.loggedInUserToken
    };
  }

  static Map<String, String> requestPDFHeaders() {
    return <String, String>{
      'Content-Type': 'application/pdf',
      'Authorization': 'Bearer ${appStorage.loggedInUserToken}'
    };
  }

  static Map<String, String> requestPreLoginHeaders() {
    return <String, String>{
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }
  // TODO GET
  Future<dynamic> getRequest({
    required String endPoint,
  }) async {
    final uri = AppConstants.baseUrl + endPoint;
    debugPrint("$TAG GET: $uri");
    try {
      final response = await http.get(Uri.parse(uri), headers: requestHeaders(),)
          .timeout(const Duration(seconds: timeOutDuration),);
      print("Token: ${requestHeaders()}");
      print(response.body);

      return _processResponse(response);
    } on SocketException {
      throw FetchDataException(
        'Socket Exception',
        uri.toString(),
      );
    } on TimeoutException {
      throw ApiNotRespondingException(
        'API Timed out',
        uri.toString(),
      );
    } catch (exception) {
      rethrow;
    }
  }

  // TODO POST
  Future<dynamic> postRequest({
    required String endPoint,
    required dynamic body,
  }) async {
    final uri = AppConstants.baseUrl + endPoint;
    final payload = json.encode(body);
    debugPrint("$TAG POST: $uri");
    try {

      final response = await http.post(
        Uri.parse(uri),
        body: payload,
        headers: requestHeaders(),
      ).timeout(const Duration(seconds: timeOutDuration));
      print(response.request?.url);
      print("Token: ${requestHeaders()}");
      print(body);
      print(response.body);
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException(
        'Socket Exception',
        uri.toString(),
      );
    } on TimeoutException {
      throw ApiNotRespondingException(
        'API Timed out',
        uri.toString(),
      );
    } catch (exception) {
      rethrow;
    }
  }

  // TODO POST
  Future<dynamic> postPreLogin({
    required String endPoint,
    required dynamic body,
  }) async {
    final uri = AppConstants.baseUrl + endPoint;
    final payload = json.encode(body);
    try {
      final response = await http
          .post(Uri.parse(uri), body:payload, headers: requestPreLoginHeaders())
          .timeout(const Duration(seconds: timeOutDuration));
      print(response.statusCode);
      print(body);
      print("body===${response.body}");
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException(
        'Socket Exception',
        uri.toString(),
      );
    } on TimeoutException {
      throw ApiNotRespondingException(
        'API Timed out',
        uri.toString(),
      );
    } catch (exception) {
      rethrow;
    }
  }

  // TODO PUT
  Future<dynamic> putRequest({
    required String endPoint,
    required dynamic payloadObj,
  }) async {

    final uri = AppConstants.baseUrl + endPoint;
    final payload = json.encode(payloadObj);
    try {
      final response = await http
          .put(
        Uri.parse(uri),
        body: payload,
        headers: requestHeaders(),
      )
          .timeout(const Duration(seconds: timeOutDuration));
      print(response.request?.url);
      print(payload);
      print(response.body);
      return _processResponse(response);
    } on SocketException {
      throw FetchDataException(
        'Socket Exception',
        uri.toString(),
      );
    } on TimeoutException {
      throw ApiNotRespondingException(
        'API Timed out',
        uri.toString(),
      );
    } catch (exception) {
      rethrow;
    }
  }



  Future<dynamic> getPDFRequest({
    required String endPoint,
  }) async {
    final uri = AppConstants.baseUrl + endPoint;
    try {
      final response = await http.get(
        Uri.parse(uri),
        headers: requestPDFHeaders(),
      );
      if (response.statusCode == 200) {
        return response.bodyBytes;
      }
    } on SocketException {
      throw FetchDataException(
        'Socket Exception',
        uri.toString(),
      );
    } on TimeoutException {
      throw ApiNotRespondingException(
        'API Timed out',
        uri.toString(),
      );
    } catch (exception) {
      rethrow;
    }
  }



  static final _emptyResponse = <String, dynamic>{};

  static dynamic _processResponse(http.Response response) {

    var body = json.decode(response.body);
    final url = response.request!.url.toString();
print(response.statusCode);
    switch (response.statusCode) {
      case 200:
      case 201:
      case 202:
        if (body["statusCode"] != null && body["statusCode"] == 200) {
          return body;
        } else if (body["statusCode"] != null && (int.parse(body["statusCode"].toString() ) >= 300 || int.parse(body["statusCode"] ?? "0") <= 500)) {
          throw ServerErrorException('Something went wrong, Please try again later', url);
        } else {
          return body;
        }
      case 204:
        return _emptyResponse;
      case 401:
        if (Get.currentRoute != Routes.LOGINSCREEN) {
          appStorage.resetStorage();
          Get.offAllNamed(Routes.LOGINSCREEN);
          AppUtils.showSnackbar("Session Timed out, Please login to proceed","");
        }
        throw BadRequestException('Something went wrong', url);

      case 400:
        throw BadRequestException('Something went wrong', url);
      case 403:
        throw UnAuthorizedException('Something went wrong', url);
      case 404:
        throw ResourceNotFoundException('Something went wrong', url);
      case 422:
        throw BadRequestException('Something went wrong', url);
      case 429:
        throw RateLimitException('Something went wrong', url);
      case 500:
        throw ServerErrorException('Something went wrong', url);
      default:
        throw FetchDataException('Something went wrong', url);
    }
  }
}
