import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:crafty/Helper/Test.dart';
import 'package:crafty/Utility/retry_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dio_connectivity_request_retrier.dart';

class RetryOnAccessTokenInterceptor extends Interceptor {
  static const url = "https://officialcraftybackend.herokuapp.com/users/";
 // static const url = "http://10.0.2.2:3000/users/";
  final DioConnectivityRequestRetrier requestRetrier;
  Dio dio;
  Response response;
  RetryOnAccessTokenInterceptor({
    @required this.requestRetrier,
  });

  @override
  Future onError(DioError err) async{
    if (_shouldRetry(err)) {
      try {
        return requestRetrier.scheduleRequestRetry(err.request);
      } catch (e) {
        return e;
      }
    }
    // Let the error pass through if it's not the error we're looking for
    if(err.type==DioErrorType.RESPONSE&&err.response.statusCode==403){
      BaseOptions option =
      new BaseOptions(connectTimeout: 7000, receiveTimeout: 3000, headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });
      dio = Dio(option);
      dio.interceptors.add(
        RetryOnConnectionChangeInterceptor(
          requestRetrier: DioConnectivityRequestRetrier(
            dio: dio,
            connectivity: Connectivity(),
          ),
        ),
      );
      Map data = {
        'refreshtoken': Test.refreshToken,
      };
      var body = json.encode(data);
      try{
        response = await dio.post(url+ "token",data: body);
      }on DioError catch (e){
        print(e);
        if(e.type == DioErrorType.CONNECT_TIMEOUT||e.type == DioErrorType.RESPONSE){
          response = Response(statusCode: 500);
        }
      }
     if(response.statusCode==200){
       var token = response.data["accessToken"];
       setToken(token);
       Test.accessToken = token;
       err.request.headers['Authorization'] =  'Bearer ${token}';
       try {
         return requestRetrier.scheduleRequestRetry(err.request);
       } catch (e) {
         return e;
       }
     }else{

       return err;
     }
    }else{
      return err;
    }

  }

  bool _shouldRetry(DioError err) {
    return err.type == DioErrorType.DEFAULT &&
        err.error != null &&
        err.error is SocketException;
  }

  void setToken(token) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("access",token);
  }


}
