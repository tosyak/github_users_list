// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:github_test_app/data/network/api_exceptions.dart';
import 'package:github_test_app/utils/logger.dart';

const _token = '';

// This line prevents the class from being extended further (like a final class)
sealed class BaseApiServices {

  Future<dynamic> getApiResponse(String url);
}

class ApiService extends BaseApiServices {
  final dio = Dio(
    // Configure Dio with BaseOptions for timeouts and expected response format.
    BaseOptions(
      connectTimeout:
          const Duration(milliseconds: 15000), // 15-second connection timeout
      receiveTimeout:
          const Duration(milliseconds: 15000), // 15-second response timeout
      responseType: ResponseType.json,
    ),
  );

  // Override the abstract method from the base class.
  @override
  Future getApiResponse(String url) async {
    dynamic responseJson;
    // Log the requested URL for debugging purposes.
    logger.i('url  $url');

    try {
      final Response response = await dio.get(
        url,
        options: Options(
          headers: {
            'Authorization': 'Bearer $_token',
            'Accept': 'application/json',
          },
        ),
      );
      // Process the response using the returnResponse function
      responseJson = returnResponse(response);
      // Log the status code for debugging
      logger.i('ApiService getApiResponse status code ${response.statusCode}');
      // Optionally log the full response for detailed analysis
      logger.i('ApiService getApiResponse response $response');
    } on SocketException {
      // Catch SocketException for network errors and throw a custom exception
      throw FetchDataException(message: "No Internet Connection");
    }
    // Return the processed response data
    return responseJson;
  }

  // Function to handle different response status codes and return data accordingly
  dynamic returnResponse(Response<dynamic> response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = response;
        return responseJson;
      case 400:
        throw BadRequestException(message: response.data.toString());
      case 401:
        throw UnAuthorizedException(message: response.data.toString());
      default:
        // For unhandled status codes, log an error and throw a generic FetchDataException.
        logger.e(
            "Error occurred while communicating with server with status code ${response.statusCode}");
        throw FetchDataException(
            message:
                "Error occurred while communicating with server with status code ${response.statusCode}");
    }
  }
}
