import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:likeplay/utils/sharedpref/shared_prefrence.dart';
import '../module/model/success_response.dart';
import 'sharedpref/preferences.dart';
import 'package:http_parser/src/media_type.dart';
class NetworkUtil {
  //Next three lines makes this class a Singleton
  static NetworkUtil _instance = new NetworkUtil.internal();
  NetworkUtil.internal();
  factory NetworkUtil() => _instance;
  final JsonDecoder _decoder = new JsonDecoder();


  Future<dynamic> get(String url, Map<String, String> headers) {
    return http.get(Uri.parse(url), headers: headers).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode == 203 ||
          statusCode == 201 ||
          statusCode == 400 ||
          statusCode == 401 ||
          json == null) {
        //  throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> postApi(String url, {Map? headers, body, encoding}) async {
    return http
        .post(Uri.parse(url),
        body: body,
        headers: {
          //"lang": SessionManager.getString(Preferences.IS_LANGUAGE),
        },
        encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode == 203 || statusCode == 201 ||
          statusCode == 400 ||
          statusCode == 401 ||
          json == null) {
        //throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> putApiWithHeader(String url, {Map? headers, body, encoding}) async {
    return http
        .put(Uri.parse(url),
        body: body,
        headers: {
          "Authorization": "Bearer "+SessionManager.getString(Preferences.ACCESS_TOKEN),
          //"Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MTY0NSwiaWF0IjoxNjc5NTkwNjMxfQ.jOeIcBFIoR7oGw8zcEDtRgJm6Fkq3zs60XJzMPelllk",
        },
        encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      if (statusCode == 203 ||
          statusCode == 201 ||
          statusCode == 400 ||
          statusCode == 401 ||
          json == null) {
        //throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> delete(String url, {Map? headers, body, encoding}) {
    return http.delete(Uri.parse(url),
        headers: {
          "Authorization": SessionManager.getString(Preferences.ACCESS_TOKEN),
        },
        encoding: encoding).then((
        http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      if (statusCode == 203 ||
          statusCode == 201 ||
          statusCode == 400 ||
          statusCode == 401 ||
          json == null) {
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> multipartUploadWeb(String url,
      Map<String, String> headers,String fileName,List<int>? file) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);
    if (fileName.isNotEmpty) {
      MediaType? contentTypes;
      if(fileName.contains(".png") || fileName.contains(".jpg") || fileName.contains(".jpeg")){
        contentTypes=MediaType.parse("image/png");
      }
      request.files.add(await http.MultipartFile.fromBytes('image_url', file!,
          contentType: contentTypes,
          filename: fileName));
      request.fields["user_id"]=SessionManager.getString(Preferences.USER_ID);
      request.fields["profile_status"]="4";

    }
    var res = await request.send();
    var result = await http.Response.fromStream(res);
    return _decoder.convert(result.body);
  }

  Future<dynamic> multipartMobileImage(String url,
      Map<String, String> headers,File fileName) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);
    if (fileName.path.isNotEmpty) {
      MediaType? contentTypes;
      if(fileName.path.contains(".png") ||fileName.path.contains(".PNG") || fileName.path.contains(".jpg") ||fileName.path.contains(".JPG") || fileName.path.contains(".jpeg")|| fileName.path.contains(".JPEG")){
        contentTypes=MediaType.parse("image/png");
      }
      var multipartFile = await http.MultipartFile.fromPath(
        "image_url", fileName.path, contentType: contentTypes,
      );
      request.fields["user_id"]=SessionManager.getString(Preferences.USER_ID);
      request.fields["profile_status"]="4";
      request.files.add(multipartFile);
    }
    var res = await request.send();
    var result = await http.Response.fromStream(res);
    return _decoder.convert(result.body);
  }
  Future<dynamic> multipartMobileImageIds(String url,
      Map<String, String> headers,File fileFront,File fileBack,String verificationStatus) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);
    if (fileFront.path.isNotEmpty) {
      var multipartFile = await http.MultipartFile.fromPath(
        "government_id_front_side", fileFront.path, contentType: MediaType.parse("image/png"),
      );
      var multipartFiles = await http.MultipartFile.fromPath(
        "government_id_back_side", fileBack.path, contentType: MediaType.parse("image/png"),
      );
      request.files.add(multipartFile);
      request.files.add(multipartFiles);
      request.fields["isUserVerified"]="true";

    }
    var res = await request.send();
    var result = await http.Response.fromStream(res);
    return _decoder.convert(result.body);
  }
  Future<dynamic> multipartUploadPost(String url,
      Map<String, String> headers,String fileName,List<int>? file,String caption, List tagIds) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);
    if (fileName.isNotEmpty) {
      MediaType? contentTypes;
      if(fileName.contains(".png") || fileName.contains(".jpg") || fileName.contains(".jpeg")){
        contentTypes=MediaType.parse("image/png");
      }
      request.files.add(await http.MultipartFile.fromBytes('media_url', file!,
          contentType: contentTypes,
          filename: fileName));
      request.fields["media_type"]="0";
      request.fields["caption"]=caption;
      request.fields["tag_to"]=tagIds.toString();

    }
    var res = await request.send();
    var result = await http.Response.fromStream(res);
    return _decoder.convert(result.body);
  }
  Future<dynamic> multipartUploadPostMobile(String url,
      Map<String, String> headers,File fileName,String caption, List tagIds) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);
    if (fileName.path.isNotEmpty) {
      MediaType? contentTypes;
      if(fileName.path.contains(".png") || fileName.path.contains(".jpg") || fileName.path.contains(".jpeg")){
        contentTypes=MediaType.parse("image/png");
      }
      request.files.add(await http.MultipartFile.fromPath('media_url', fileName!.path,
          contentType: contentTypes,));
      request.fields["media_type"]="0";
      request.fields["caption"]=caption;
      request.fields["tag_to"]=tagIds.toString();

    }
    var res = await request.send();
    var result = await http.Response.fromStream(res);
    return _decoder.convert(result.body);
  }

  Future<dynamic> postWithHeader(String url, {Map? headers, body, encoding}) async {
    return http
        .post(Uri.parse(url),
        body: body,
        headers: {
          "Authorization": "Bearer "+ SessionManager.getString(Preferences.ACCESS_TOKEN),
        },
        encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode == 203 ||
          statusCode == 201 ||
          statusCode == 400 ||
          statusCode == 401 ||
          json == null) {
        //throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> deleteApiWithHeader(String url, {Map? headers, body, encoding}) async {
    return http
        .delete(Uri.parse(url),
        body: body,
        headers: {
          "Authorization":"Bearer ${SessionManager.getString(Preferences.ACCESS_TOKEN)}",
        },
        encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode == 203 ||
          statusCode == 201 ||
          statusCode == 400 ||
          statusCode == 401 ||
          json == null) {
        //throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }


  Future<dynamic> post(String url, String auth_token,
      {Map? headers, body, encoding}) {
    return http
        .post(Uri.parse(url),
        body: body,
        headers: {
          "Authorization": "Bearer "+auth_token
        },
        encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode == 203 ||
          statusCode == 201 ||
          statusCode == 400 ||
          statusCode == 401 ||
          json == null) {
        // throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }
  Future<dynamic> multipartVerifyPost(String url,
      Map<String, String> headers,String fileNameFront,List<int>? filePathFront,
      String fileNameBack, List<int>? filePathBack,String verificationStatus) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);
    if (fileNameFront.isNotEmpty) {
      MediaType? contentTypes;
      if(fileNameFront.contains(".png") || fileNameFront.contains(".jpg") || fileNameFront.contains(".jpeg")){
        contentTypes=MediaType.parse("image/png");
      }
      request.files.add(await http.MultipartFile.fromBytes('government_id_front_side', filePathFront!,
          contentType: contentTypes,
          filename: fileNameFront));
    }
    if (fileNameBack.isNotEmpty) {
      MediaType? contentTypes;
      if(fileNameBack.contains(".png") || fileNameFront.contains(".jpg") || fileNameFront.contains(".jpeg")){
        contentTypes=MediaType.parse("image/png");
      }
      request.files.add(await http.MultipartFile.fromBytes('government_id_back_side', filePathBack!,
          contentType: contentTypes,
          filename: fileNameBack));
    }
    request.fields["isUserVerified"]="true";
    var res = await request.send();
    var result = await http.Response.fromStream(res);
    return _decoder.convert(result.body);
  }
  Future<dynamic> multipartVerifyFaceVerification(String url,
      Map<String, String> headers,String fileNameFace,List<int>? filePathFace,
     ) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);
    if (fileNameFace.isNotEmpty) {
      MediaType? contentTypes;
      if(fileNameFace.contains(".png") || fileNameFace.contains(".jpg") || fileNameFace.contains(".jpeg")){
        contentTypes=MediaType.parse("image/png");
      }
      request.files.add(await http.MultipartFile.fromBytes('photos_for_verification', filePathFace!,
          contentType: contentTypes,
          filename: fileNameFace));
    }
    request.fields["isUserVerified"]="true";
    var res = await request.send();
    var result = await http.Response.fromStream(res);
    return _decoder.convert(result.body);
  }
  Future<dynamic> multipartVerifyFaceVerificationMobile(String url,
      Map<String, String> headers,File imageData,
     ) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);
    if (imageData.path.isNotEmpty) {
      MediaType? contentTypes;
      if(imageData.path.contains(".png") || imageData.path.contains(".jpg") || imageData.path.contains(".jpeg")){
        contentTypes=MediaType.parse("image/png");
      }
      var multipartFiles = await http.MultipartFile.fromPath(
        "photos_for_verification", imageData.path, contentType: MediaType.parse("image/png"),
      );
      request.files.add(multipartFiles);
    }
    request.fields["isUserVerified"]="true";
    var res = await request.send();
    var result = await http.Response.fromStream(res);
    return _decoder.convert(result.body);
  }

}
