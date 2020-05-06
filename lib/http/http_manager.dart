import 'dart:convert';
import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:wanflutter/http/api.dart';

///网络请求封装


class HttpManager {
  factory HttpManager() => getInstance();
  static HttpManager httpManager;
  final String getRequest = "get";
  final String postRequest = "post";
  Dio dio;

  BaseOptions options;

  static HttpManager getInstance() {
    if (httpManager == null) {
      httpManager = HttpManager.init();
    }
    return httpManager;
  }

  HttpManager.init() {
    options = BaseOptions(
        baseUrl: HttpUrls.baseUrl, connectTimeout: 10000, receiveTimeout: 5000);
    dio = new Dio(options);
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
//      client.findProxy = (Uri) {
//        // 设置了代理需要将这段代码打开才能抓到接口
//        return 'PROXY 192.168.15.91:8888';
//      };
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        //        if(cert.pem==PEM){
//          return true; //证书一致，则允许发送数据
//        }
        return true;
      };
    };
  }



//  get(url,
//      {parameters, Function successCallBack, Function errorCallBack}) async {
//    _requestHttp(url, parameters, successCallBack, errorCallBack, getRequest);
//  }

//  post(url,
//      {parameters, Function successCallBack, Function errorCallBack}) async {
//    _requestHttp(url, parameters, successCallBack, errorCallBack, postRequest);
//  }

  Future _requestHttp(url, parameters, Function successCallBack,
      Function errorCallBack, String requestName) async {
    Response response;
    try {
      if (requestName == getRequest) {
        if (parameters != null && parameters.isNotEmpty) {
          response = await dio.get(url, queryParameters: parameters);
        } else {
          response = await dio.get(url);
        }
      } else if (requestName == postRequest) {
        if (parameters != null && parameters.isNotEmpty) {
          response = await dio.post(url, queryParameters: parameters);
        } else {
          response = await dio.post(url);
        }
      }
    } on DioError catch (error) {
      Response errorResponse;
      if (error.response != null) {
        errorResponse = error.response;
      } else {
        errorResponse = new Response(statusCode: 666);
      }
      _error(errorCallBack, error.message);
    }

    String dataStr = json.encode(response.data);
    Map<String, dynamic> dataMap = json.decode(dataStr);
    if (dataMap == null || dataMap['state'] == 0) {
      _error(
          errorCallBack,
          '错误码：' +
              dataMap['errorCode'].toString() +
              '，' +
              response.data.toString());
    } else {
      if (successCallBack != null) {
        successCallBack(dataMap);
      }
    }
  }

  void _error(Function errorCallBack, String error) {
    if (errorCallBack != null) {
      errorCallBack(error);
    }
  }
}
