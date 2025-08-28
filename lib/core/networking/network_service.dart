import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:flutter_assessment/core/networking/network_mapper.dart';
import 'package:flutter_assessment/core/networking/network_response.dart';



class NetworkHandler {
  final Dio dio;

  NetworkHandler(this.dio) {
    dio.options.headers = {
      'Accept': 'application/json',
      
    };
  }

  Future<NetworkResponse<ResponseType>> get<ResponseType extends Mappable>(
      ResponseType responseType,
      String url, {
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      developer.log("GET $url, query: $queryParameters");
      final response = await dio.get(url, queryParameters: queryParameters);
      return handleResponse<ResponseType>(response, responseType);
    } on DioException catch (e) {
      return handleResponse<ResponseType>(
        e.response ?? Response(requestOptions: RequestOptions(path: url)),
        responseType,
      );
    }
  }

  NetworkResponse<ResponseType> handleResponse<ResponseType extends Mappable>(
      Response response,
      ResponseType responseType,
      ) {
    try {
      final int statusCode = response.statusCode ?? 500;
      developer.log("Status Code: $statusCode");

      if (statusCode >= 200 && statusCode < 300) {
        return NetworkResponse<ResponseType>(
          Mappable(responseType, response.data) as ResponseType,
          true,
          "",
        );
      } else if (statusCode == 401) {
        return NetworkResponse<ResponseType>(
          Mappable(responseType, response) as ResponseType,
          false,
          response.data['message'] ?? response.data['error'] ?? 'Unauthorized',
        );
      } else if (statusCode == 404) {
        return NetworkResponse<ResponseType>(
          Mappable(responseType, response) as ResponseType,
          false,
          response.data['message'] ?? response.data['error'] ?? 'Not found',
        );
      } else {
        developer.log("Request error: $response");
        return NetworkResponse<ResponseType>(
          Mappable(responseType, response) as ResponseType,
          false,
          response.data['message'] ??
              response.data['error'] ??
              response.data['errors']?.first ??
              'Unknown error',
        );
      }
    } catch (e, s) {
      developer.log("Error: $e\nStack: $s");
      return NetworkResponse<ResponseType>(
        Mappable(responseType, {
          'message': 'An error occurred while processing your request',
        })
        as ResponseType,
        false,
        'Unknown error occurred',
      );
    }
  }
}