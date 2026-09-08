import 'dart:convert';
import 'dart:io';
import 'package:askfemi/utils/network/network_response_dio.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class NetworkCallerDio {
  final Dio _dio = Dio();

  // Generic function to handle any HTTP request (GET, POST, PUT, DELETE)
  Future<NetworkResponseDio> _request(
      String method,
      String url, {
        Map<String, dynamic>? body,
        Map<String, String>? headers,
        bool isLogin = false,
      }) async {
    final Map<String, String> requestHeaders = <String, String>{
      'Content-Type': 'application/json',
      ...?headers,
    };

    try {
      debugPrint('🌐 $method Request to: $url');
      debugPrint('📋 Headers: $requestHeaders');
      if (body != null) {
        debugPrint('📦 Body: $body');
      }

      Response response;

      switch (method.toUpperCase()) {
        case 'POST':
          response = await _dio.post(
            url,
            data: jsonEncode(body ?? {}),
            options: Options(headers: requestHeaders),
          );
          break;

        case 'GET':
          response = await _dio.get(
            url,
            options: Options(headers: requestHeaders),
          );
          break;

        case 'PUT':
          response = await _dio.put(
            url,
            data: jsonEncode(body ?? {}),
            options: Options(headers: requestHeaders),
          );
          break;

        case 'DELETE':
          response = await _dio.delete(
            url,
            data: body != null ? jsonEncode(body) : null,
            options: Options(headers: requestHeaders),
          );
          break;

        case 'PATCH':
          response = await _dio.patch(
            url,
            data: jsonEncode(body ?? {}),
            options: Options(headers: requestHeaders),
          );
          break;

        default:
          throw Exception('Unsupported HTTP method: $method');
      }

      debugPrint('✅ Response Status: ${response.statusCode}');
      debugPrint('📄 Response Body: ${response.data}');

      final fakeHttpResponse = Response(
        requestOptions: response.requestOptions,
        data: response.data,
        statusCode: response.statusCode,
      );

      return _handleResponse(fakeHttpResponse, isLogin);
    } on SocketException catch (e) {
      debugPrint('❌ SocketException: $e');
      return NetworkResponseDio(
        isSuccess: false,
        statusCode: null,
        errorMessage: 'No internet connection. Please check your network settings.',
      );
    } on DioException catch (e) {
      debugPrint('❌ DioException: ${e.type} - ${e.message}');

      // Try to extract error message from response body
      String errorMessage = 'Network error. Please check your connection.';
      Map<String, dynamic>? errorResponse;

      if (e.response?.data != null) {
        try {
          final responseData = e.response?.data;
          if (responseData is String) {
            errorResponse = Map<String, dynamic>.from(jsonDecode(responseData));
          } else if (responseData is Map) {
            errorResponse = Map<String, dynamic>.from(responseData);
          }

          if (errorResponse != null) {
            errorMessage = _extractErrorMessage(errorResponse);
          }
        } catch (_) {}
      }

      // Handle different types of Dio exceptions
      if (e.type == DioExceptionType.connectionTimeout) {
        return NetworkResponseDio(
          isSuccess: false,
          statusCode: null,
          errorMessage: 'Connection timeout. Please try again.',
        );
      } else if (e.type == DioExceptionType.receiveTimeout) {
        return NetworkResponseDio(
          isSuccess: false,
          statusCode: null,
          errorMessage: 'Receive timeout. Please try again.',
        );
      } else if (e.type == DioExceptionType.sendTimeout) {
        return NetworkResponseDio(
          isSuccess: false,
          statusCode: null,
          errorMessage: 'Send timeout. Please try again.',
        );
      } else if (e.type == DioExceptionType.connectionError) {
        return NetworkResponseDio(
          isSuccess: false,
          statusCode: null,
          errorMessage: 'No internet connection. Please check your network.',
        );
      } else if (e.type == DioExceptionType.cancel) {
        return NetworkResponseDio(
          isSuccess: false,
          statusCode: e.response?.statusCode,
          errorMessage: 'Request cancelled.',
        );
      } else {
        return NetworkResponseDio(
          isSuccess: false,
          statusCode: e.response?.statusCode,
          jsonResponse: errorResponse,
          errorMessage: errorMessage,
        );
      }
    } catch (e) {
      debugPrint('❌ Error: $e');
      return NetworkResponseDio(
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }

  // Helper method to extract error message from response
  String _extractErrorMessage(Map<String, dynamic> response) {
    // Priority 1: Check 'message' field
    if (response.containsKey('message') && response['message'] != null) {
      return response['message'].toString();
    }

    // Priority 2: Check 'error' array or object
    if (response.containsKey('error')) {
      final errorData = response['error'];
      if (errorData is List && errorData.isNotEmpty) {
        if (errorData[0] is Map && errorData[0].containsKey('message')) {
          return errorData[0]['message'].toString();
        }
      } else if (errorData is Map && errorData.containsKey('message')) {
        return errorData['message'].toString();
      }
    }

    // Priority 3: Check 'data.attributes.message'
    if (response.containsKey('data') && response['data'] is Map) {
      final data = Map<String, dynamic>.from(response['data']);
      if (data.containsKey('attributes') && data['attributes'] is Map) {
        final attributes = Map<String, dynamic>.from(data['attributes']);
        if (attributes.containsKey('message')) {
          return attributes['message'].toString();
        }
      }
    }

    // Priority 4: Check 'errors' array
    if (response.containsKey('errors') && response['errors'] is List) {
      final errors = response['errors'] as List;
      if (errors.isNotEmpty && errors[0] is Map) {
        final firstError = Map<String, dynamic>.from(errors[0]);
        if (firstError.containsKey('message')) {
          return firstError['message'].toString();
        }
      }
    }

    return response['message'] ?? 'Request failed';
  }

  // Handles response from the HTTP request and returns a NetworkResponse
  NetworkResponseDio _handleResponse(Response response, bool isLogin) {
    try {
      final Map<String, dynamic> jsonResponse =
      response.data is String ? jsonDecode(response.data) : Map<String, dynamic>.from(response.data);

      // Handle successful responses
      if (response.statusCode == 200 || response.statusCode == 201) {
        return NetworkResponseDio(
          isSuccess: true,
          jsonResponse: jsonResponse,
          statusCode: response.statusCode,
        );
      }

      // For all error responses, extract the message from the response body
      String errorMessage = _extractErrorMessage(jsonResponse);

      // Handle specific status codes with fallback messages
      if (response.statusCode == 400) {
        errorMessage = errorMessage != 'Request failed' ? errorMessage : 'Bad request. Please check your input.';
      } else if (response.statusCode == 401) {
        errorMessage = errorMessage != 'Request failed' ? errorMessage : 'Session expired. Please login again.';
      } else if (response.statusCode == 403) {
        errorMessage = errorMessage != 'Request failed' ? errorMessage : 'Access denied. You do not have permission.';
      } else if (response.statusCode == 404) {
        errorMessage = errorMessage != 'Request failed' ? errorMessage : 'Resource not found.';
      } else if (response.statusCode == 409) {
        errorMessage = errorMessage != 'Request failed' ? errorMessage : 'Conflict with current state.';
      } else if (response.statusCode == 422) {
        errorMessage = errorMessage != 'Request failed' ? errorMessage : 'Validation failed. Please check your input.';
      } else if (response.statusCode == 500) {
        errorMessage = errorMessage != 'Request failed' ? errorMessage : 'Server error. Please try again later.';
      } else if (response.statusCode == 502) {
        errorMessage = 'Server is temporarily unavailable. Please try again later.';
      } else if (response.statusCode == 503) {
        errorMessage = 'Service unavailable. Please try again later.';
      } else if (response.statusCode == 504) {
        errorMessage = 'Gateway timeout. Please try again later.';
      }

      return NetworkResponseDio(
        isSuccess: false,
        statusCode: response.statusCode,
        jsonResponse: jsonResponse,
        errorMessage: errorMessage,
      );
    } catch (e) {
      return NetworkResponseDio(
        isSuccess: false,
        errorMessage: 'Error parsing response: ${e.toString()}',
      );
    }
  }

  // GET Request
  Future<NetworkResponseDio> getRequest(
      String url, {
        Map<String, String>? headers,
        bool isLogin = false,
      }) async {
    return _request('GET', url, headers: headers, isLogin: isLogin);
  }

  // POST Request
  Future<NetworkResponseDio> postRequest(
      String url, {
        Map<String, dynamic>? body,
        bool isLogin = false,
        Map<String, String>? headers,
      }) async {
    return _request(
      'POST',
      url,
      body: body,
      isLogin: isLogin,
      headers: headers,
    );
  }

  // PUT Request
  Future<NetworkResponseDio> putRequest(
      String url, {
        Map<String, dynamic>? body,
        bool isLogin = false,
        Map<String, String>? headers,
      }) async {
    return _request(
      'PUT',
      url,
      body: body,
      isLogin: isLogin,
      headers: headers,
    );
  }

  // DELETE Request
  Future<NetworkResponseDio> deleteRequest(
      String url, {
        Map<String, dynamic>? body,
        bool isLogin = false,
        Map<String, String>? headers,
      }) async {
    return _request(
      'DELETE',
      url,
      body: body,
      isLogin: isLogin,
      headers: headers,
    );
  }

  // PATCH Request
  Future<NetworkResponseDio> patchRequest(
      String url, {
        Map<String, dynamic>? body,
        bool isLogin = false,
        Map<String, String>? headers,
      }) async {
    return _request(
      'PATCH',
      url,
      body: body,
      isLogin: isLogin,
      headers: headers,
    );
  }

  // PUT Request with Multipart Form Data (for file uploads)
  Future<NetworkResponseDio> putMultipartRequest(
      String url, {
        Map<String, dynamic>? body,
        Map<String, File>? files,
        bool isLogin = false,
        Map<String, String>? headers,
      }) async {
    final Map<String, String> requestHeaders = <String, String>{
      ...?headers,
    };

    try {
      debugPrint('🌐 PUT Multipart Request to: $url');
      debugPrint('📋 Headers: $requestHeaders');
      debugPrint('📦 Body: $body');
      if (files != null) {
        debugPrint('📎 Files: ${files.keys}');
      }

      FormData formData = FormData();

      body?.forEach((key, value) {
        formData.fields.add(MapEntry(key, value.toString()));
      });

      files?.forEach((key, file) {
        formData.files.add(
          MapEntry(
            key,
            MultipartFile.fromFileSync(
              file.path,
              filename: file.path.split('/').last,
            ),
          ),
        );
      });

      final response = await _dio.put(
        url,
        data: formData,
        options: Options(
          headers: requestHeaders,
          contentType: 'multipart/form-data',
        ),
      );

      debugPrint('✅ Response Status: ${response.statusCode}');
      debugPrint('📄 Response Body: ${response.data}');

      final fakeHttpResponse = Response(
        requestOptions: response.requestOptions,
        data: response.data,
        statusCode: response.statusCode,
      );

      return _handleResponse(fakeHttpResponse, isLogin);
    } on SocketException catch (e) {
      debugPrint('❌ SocketException: $e');
      return NetworkResponseDio(
        isSuccess: false,
        statusCode: null,
        errorMessage: 'No internet connection. Please check your network settings.',
      );
    } on DioException catch (e) {
      debugPrint('❌ DioException: ${e.type}');

      // Try to extract error message
      String errorMessage = 'Network error. Please check your connection.';
      Map<String, dynamic>? errorResponse;

      if (e.response?.data != null) {
        try {
          final responseData = e.response?.data;
          if (responseData is String) {
            errorResponse = Map<String, dynamic>.from(jsonDecode(responseData));
          } else if (responseData is Map) {
            errorResponse = Map<String, dynamic>.from(responseData);
          }

          if (errorResponse != null) {
            errorMessage = _extractErrorMessage(errorResponse);
          }
        } catch (_) {}
      }

      if (e.response?.statusCode == 502) {
        errorMessage = 'Server is temporarily unavailable. Please try again later.';
      } else if (e.response?.statusCode == 503) {
        errorMessage = 'Service unavailable. Please try again later.';
      } else if (e.response?.statusCode == 504) {
        errorMessage = 'Gateway timeout. Please try again later.';
      }

      return NetworkResponseDio(
        isSuccess: false,
        statusCode: e.response?.statusCode,
        jsonResponse: errorResponse,
        errorMessage: errorMessage,
      );
    } catch (e) {
      debugPrint('❌ Error: $e');
      return NetworkResponseDio(
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }
}