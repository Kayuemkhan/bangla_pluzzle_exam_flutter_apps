// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings

import 'dart:async';

import 'dart:convert';

import 'dart:io';

import 'package:flutter_sceleton/data/api/toast_message.dart';

import 'err_response.dart';
import '../local/local_storage.dart';
import 'package:http/http.dart' as http;


Map<String, String> basicHeaderInfo() {
  return {
    HttpHeaders.acceptHeader: "application/json",
    HttpHeaders.contentTypeHeader: "application/json",
  };
}

Future<Map<String, String>> bearerHeaderInfo() async {
  String accessToken = LocalStorage.getToken()!;

  return {
    HttpHeaders.acceptHeader: "application/json",
    HttpHeaders.contentTypeHeader: "application/json",
    HttpHeaders.authorizationHeader: "Bearer $accessToken",
  };
}

class ApiMethod {
  ApiMethod(this.isBasic);

  bool isBasic;

  Future<List<Map<String, dynamic>>?> get(String url, {int code = 200}) async {
    print(
        '|📍📍📍|----------------- [[ GET ]] method details start -----------------|📍📍📍|');

    print(url);

    print(
        '|📍📍📍|----------------- [[ GET ]] method details ended -----------------|📍📍📍|');

    try {
      final response = await http
          .get(
            Uri.parse(url),

            headers: isBasic ? basicHeaderInfo() : await bearerHeaderInfo(),
          )
          .timeout(const Duration(seconds: 15));

      print(
          '|📒📒📒|-----------------[[ GET ]] method response start -----------------|📒📒📒|');

      print(response.body.toString());


      print(
          '|📒📒📒|-----------------[[ GET ]] method response end -----------------|📒📒📒|');

      if (response.statusCode == code) {

        List<Map<String, dynamic>> map = [];
        map = List<Map<String, dynamic>>.from(jsonDecode(response.body));
        print(map.length);
        return map;
      } else {
        print('🐞🐞🐞 Error Alert 🐞🐞🐞');

         print(
            'unknown error hitted in status code' + jsonDecode(response.statusCode.toString()).toString());

        ErrorResponse res = ErrorResponse.fromJson(jsonDecode(response.body));

               ToastMessage.error(res.message!.error![0].toString());


        return null;
      }
    } on SocketException {
      print('🐞🐞🐞 Error Alert on Socket Exception 🐞🐞🐞');

      ToastMessage.error('Check your Internet Connection and try again!');

      return null;
    } on TimeoutException {
      print('🐞🐞🐞 Error Alert on Time Out 🐞 🐞🐞');

      print('Time out exception$url');

      ToastMessage.error('Something Went Wrong! Try again');

      return null;
    } on http.ClientException catch (err, stackrace) {
      print('🐞🐞🐞 Error Alert 🐞🐞🐞');

      print('client exception hitted');

      print(err.toString());

      print(stackrace.toString());

      return null;
    } catch (e) {
      print('🐞🐞🐞 Error Alert 🐞🐞🐞');

      print('❌❌❌ unlisted error received');

      print("❌❌❌ $e");

      return null;
    }
  }

  Future<Map<String, dynamic>?> paramGet(String url, Map<String, String> body,
      {int code = 200}) async {
    print(
        '|Get param📍📍📍|----------------- [[ GET ]] param method Details Start -----------------|📍📍📍|');

    print("##body given --> ");

    print(body);

    print("##url list --> $url");

    print(
        '|Get param📍📍📍|----------------- [[ GET ]] param method details ended ** ---------------|📍📍📍|');


    Uri uri = Uri.parse(url);
    final finalUri = uri.replace(queryParameters: body);
    print("##Final URI list --> $url");

    print(finalUri);


    try {
      final response = await http
          .get(
            Uri.parse(url).replace(queryParameters: body),
            headers: isBasic ? basicHeaderInfo() : await bearerHeaderInfo(),
          )
          .timeout(const Duration(seconds: 15));

      print(
          '|📒📒📒| ----------------[[ Get ]] Peram Response Start---------------|📒📒📒|');

      print(response.body.toString());

      print(
          '|📒📒📒| ----------------[[ Get ]] Peram Response End **-----------------|📒📒📒|');

      if (response.statusCode == code) {
        return jsonDecode(response.body);
      } else {
        print('🐞🐞🐞 Error Alert 🐞🐞🐞');

         print(
            'unknown error hitted in status code' + jsonDecode(response.statusCode.toString()).toString());

        ErrorResponse res = ErrorResponse.fromJson(jsonDecode(response.body));

               ToastMessage.error(res.message!.error![0].toString());


        return null;
      }
    } on SocketException {
      print('🐞🐞🐞 Error Alert on Socket Exception 🐞🐞🐞');

      ToastMessage.error('Check your Internet Connection and try again!');

      return null;
    } on TimeoutException {
      print('🐞🐞🐞 Error Alert on Time Out 🐞 🐞🐞');

      print('Time out exception$url');

      ToastMessage.error('Something Went Wrong! Try again');

      return null;
    } on http.ClientException catch (err, stackrace) {
      print('🐞🐞🐞 Error Alert 🐞🐞🐞');

      print('client exception hitted');

      print(err.toString());

      print(stackrace.toString());

      return null;
    } catch (e) {
      print('🐞🐞🐞 Error Alert 🐞🐞🐞');

      print('#url->$url||#body -> $body');

      print('❌❌❌ unlisted error received');

      print("❌❌❌ $e");

      return null;
    }
  }

  Future<Map<String, dynamic>?> post(String url, Map<String, String> body,
      {int code = 201}) async {
    try {
      print(
          '|📍📍📍|-----------------[[ POST ]] method details start -----------------|📍📍📍|');

      print(url);

      print(body);

      print(
          '|📍📍📍|-----------------[[ POST ]] method details end ------------|📍📍📍|');

      final response = await http
          .post(
            Uri.parse(url),
            body: jsonEncode(body),
            headers: isBasic ? basicHeaderInfo() : await bearerHeaderInfo(),
          )
          .timeout(const Duration(seconds: 30));

      print(
          '|📒📒📒|-----------------[[ POST ]] method response start ------------------|📒📒📒|');

      print(response.body.toString());


      // ToastMessage.error(response.body['message'].toString());
      print(response.statusCode);

      print(
          '|📒📒📒|-----------------[[ POST ]] method response end --------------------|📒📒📒|');

      if (response.statusCode == code) {
        return jsonDecode(response.body);
      } else {
        print('🐞🐞🐞 Error Alert 🐞🐞🐞');

         print(
            'unknown error hitted in status code ' + jsonDecode(response.statusCode.toString()).toString());

        ErrorResponse res = ErrorResponse.fromJson(jsonDecode(response.body));

        ToastMessage.error(res.message!.error![0].toString());
        // ToastMessage.error("login error");

        return null;
      }
    } on SocketException {
      print('🐞🐞🐞 Error Alert on Socket Exception 🐞🐞🐞');

      ToastMessage.error('Check your Internet Connection and try again!');

      return null;
    } on TimeoutException {
      print('🐞🐞🐞 Error Alert on Time Out 🐞 🐞🐞');

      print('Time out exception$url');

      ToastMessage.error('Something Went Wrong! Try again');

      return null;
    } on http.ClientException catch (err, stackrace) {
      print('🐞🐞🐞 Error Alert on socket Exception 🐞🐞🐞');

      print('client exception hitted');

      print(err.toString());

      print(stackrace.toString());

      return null;
    } catch (e) {
      print('🐞🐞🐞 Error Alert 🐞🐞🐞');

      print('❌❌❌ unlisted error received');

      print("❌❌❌ $e");

      return null;
    }
  }

  Future<Map<String, dynamic>?> postEmpty(String url,
      {int code = 200}) async {
    try {
      print(
          '|📍📍📍|-----------------[[ POST ]] method details start -----------------|📍📍📍|');

      print(url);

      print(
          '|📍📍📍|-----------------[[ POST ]] method details end ------------|📍📍📍|');

      final response = await http
          .post(
            Uri.parse(url),
            headers: isBasic ? basicHeaderInfo() : await bearerHeaderInfo(),
          )
          .timeout(const Duration(seconds: 30));

      print(
          '|📒📒📒|-----------------[[ POST ]] method response start ------------------|📒📒📒|');

      print(response.body.toString());

      print(response.statusCode);

      print(
          '|📒📒📒|-----------------[[ POST ]] method response end --------------------|📒📒📒|');

      if (response.statusCode == code) {
        return jsonDecode(response.body);
      } else {
        print('🐞🐞🐞 Error Alert 🐞🐞🐞');

         print(
            'unknown error hitted in status code' + jsonDecode(response.statusCode.toString()).toString());

        ErrorResponse res = ErrorResponse.fromJson(jsonDecode(response.body));

        ToastMessage.error(res.message!.error![0].toString());
        // ToastMessage.error("login error");


        return null;
      }
    } on SocketException {
      print('🐞🐞🐞 Error Alert on Socket Exception 🐞🐞🐞');

      ToastMessage.error('Check your Internet Connection and try again!');

      return null;
    } on TimeoutException {
      print('🐞🐞🐞 Error Alert on Time Out 🐞 🐞🐞');

      print('Time out exception$url');

      ToastMessage.error('Something Went Wrong! Try again');

      return null;
    } on http.ClientException catch (err, stackrace) {
      print('🐞🐞🐞 Error Alert on socket Exception 🐞🐞🐞');

      print('client exception hitted');

      print(err.toString());

      print(stackrace.toString());

      return null;
    } catch (e) {
      print('🐞🐞🐞 Error Alert 🐞🐞🐞');

      print('❌❌❌ unlisted error received');

      print("❌❌❌ $e");

      return null;
    }
  }

//delete

  Future<Map<String, dynamic>?> delete(String url,
      {int code = 202, bool isLogout = false}) async {
    print(
        '|📍📍📍|-----------------[[ DELETE ]] method details start-----------------|📍📍📍|');

    print(url);

    print(
        '|📍📍📍|-----------------[[ DELETE ]] method details end ------------------|📍📍📍|');

    try {
      var headers = isBasic ? basicHeaderInfo() : await bearerHeaderInfo();

      if (isLogout) {
// headers

// ..addAll({"fcm_token": await FirebaseMessaging.instance.getToken()});

      }

      print(headers);

      final response = await http
          .delete(
            Uri.parse(url),
            headers: headers,
          )
          .timeout(const Duration(seconds: 30));

      print(
          '|📒📒📒|----------------- [[ DELETE ]] method response start-----------------|📒📒📒|');

      print(response.body.toString());

      print(response.statusCode);

      print(
          '|📒📒📒|----------------- [[ DELETE ]] method response start-----------------|📒📒📒|');

      if (response.statusCode == code) {
// LocalStorage.clear();

        return jsonDecode(response.body);
      } else {
        print('🐞🐞🐞 Error Alert 🐞🐞🐞');

         print(
            'unknown error hitted in status code' + jsonDecode(response.statusCode.toString()).toString());

        ErrorResponse res = ErrorResponse.fromJson(jsonDecode(response.body));

               ToastMessage.error(res.message!.error![0].toString());


        return null;
      }
    } on SocketException {
      print('🐞🐞🐞 Error Alert on Socket Exception 🐞🐞🐞');

      ToastMessage.error('Check your Internet Connection and try again!');

      return null;
    } on TimeoutException {
      print('🐞🐞🐞 Error Alert on Time Out 🐞 🐞🐞');

      print('Time out exception$url');

      ToastMessage.error('Something Went Wrong! Try again');

      return null;
    } on http.ClientException catch (err, stackrace) {
      print('🐞🐞🐞 Error Alert 🐞🐞🐞');

      print('client exception hitted');

      print(err.toString());

      print(stackrace.toString());

      return null;
    } catch (e) {
      print('🐞🐞🐞 Error Alert 🐞🐞🐞');

      print('❌❌❌ unlisted error received');

      print("❌❌❌ $e");

      return null;
    }
  }

  Future<Map<String, dynamic>?> put(String url, Map<String, String> body,
      {int code = 202}) async {
    try {
      print(
          '|📍📍📍|-------------[[ PUT ]] method details start-----------------|📍📍📍|');

      print(url);

      print(body);

      print(
          '|📍📍📍|-------------[[ PUT ]] method details end ------------|📍📍📍|');

      final response = await http
          .put(
            Uri.parse(url),
            body: jsonEncode(body),
            headers: isBasic ? basicHeaderInfo() : await bearerHeaderInfo(),
          )
          .timeout(const Duration(seconds: 30));

      print(
          '|📒📒📒|-----------------[[ PUT ]] AKA Update method response start-----------------|📒📒📒|');

      print(response.body);

      print(response.statusCode);

      print(
          '|📒📒📒|-----------------[[ PUT ]] AKA Update method response End -----------------|📒📒📒|');

      if (response.statusCode == code) {
        return jsonDecode(response.body);
      } else {
        print('🐞🐞🐞 Error Alert 🐞🐞🐞');

         print(
            'unknown error hitted in status code' + jsonDecode(response.statusCode.toString()).toString());

        ErrorResponse res = ErrorResponse.fromJson(jsonDecode(response.body));

               ToastMessage.error(res.message!.error![0].toString());


        return null;
      }
    } on SocketException {
      print('🐞🐞🐞 Error Alert on Socket Exception 🐞🐞🐞');

      ToastMessage.error('Check your Internet Connection and try again!');

      return null;
    } on TimeoutException {
      print('🐞🐞🐞 Error Alert on Time Out 🐞 🐞🐞');

      print('Time out exception$url');

      ToastMessage.error('Request Timed out! Try again');

      return null;
    } on http.ClientException catch (err, stackrace) {
      print('🐞🐞🐞 Error Alert 🐞🐞🐞');

      print('client exception hitted');

      print(err.toString());

      print(stackrace.toString());

      return null;
    } catch (e) {
      print('🐞🐞🐞 Error Alert 🐞🐞🐞');

      print('unlisted catch error received');

      print(e.toString());

      return null;
    }
  }
}
