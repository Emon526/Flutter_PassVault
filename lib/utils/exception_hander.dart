// import 'dart:async';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class ExceptionHandlers {
//   //TODO: Add error image
//   static ErrorModel getExceptionString(error) {
//     if (error is SocketException) {
//       return ErrorModel(
//         message: 'No internet connection.',
//         url: 'assets/images/page_not_found.svg',
//       );
//     } else if (error is HttpException) {
//       return ErrorModel(
//         message: 'HTTP error occured.',
//         url: 'assets/images/page_not_found.svg',
//       );
//       // } else if (error is FormatException) {
//       //   return ErrorModel(
//       //     message: 'Invalid data format.',
//       //     url: 'assets/images/page_not_found.svg',
//       //   );
//     } else if (error is TimeoutException) {
//       return ErrorModel(
//         message: 'Request timedout.',
//         url: 'assets/images/page_not_found.svg',
//       );
//     } else if (error is BadRequestException) {
//       return ErrorModel(
//         message: error.message.toString(),
//         url: 'assets/images/page_not_found.svg',
//       );
//     } else if (error is UnAuthorizedException) {
//       return ErrorModel(
//         message: error.message.toString(),
//         url: 'assets/images/page_not_found.svg',
//       );
//     } else if (error is NotFoundException) {
//       return ErrorModel(
//         message: error.message.toString(),
//         url: 'assets/images/page_not_found.svg',
//       );
//     } else if (error is FetchDataException) {
//       return ErrorModel(
//         message: error.message.toString(),
//         url: 'assets/images/page_not_found.svg',
//       );
//     } else if (error is ApiNotRespondingException) {
//       return ErrorModel(
//         message: error.message.toString(),
//         url: 'assets/images/page_not_found.svg',
//       );
//     } else {
//       return ErrorModel(
//         message: 'Unknown error occured.',
//         url: 'assets/images/emptyreminder.svg',
//       );
//     }
//   }

//   static dynamic processResponse(http.Response response) {
//     debugPrint("Api Response Code : ${response.statusCode}");
//     switch (response.statusCode) {
//       case 200:
//         return response;
//       case 400: //Bad request
//         throw BadRequestException(jsonDecode(response.body)['message']);
//       case 401: //Unauthorized
//         throw UnAuthorizedException(jsonDecode(response.body)['message']);
//       case 403: //Forbidden
//         throw UnAuthorizedException(jsonDecode(response.body)['message']);
//       case 404: //Resource Not Found
//         throw NotFoundException(jsonDecode(response.body)['message']);
//       // case 500: //Internal Server Error
//       default:
//         debugPrint('${response.statusCode}');
//         throw FetchDataException(
//             'Something went wrong! ${response.statusCode}');
//     }
//   }
// }

// class ErrorModel {
//   final String message;

//   final String url;
//   ErrorModel({
//     required this.message,
//     required this.url,
//   });
// }

// class AppException implements Exception {
//   final String? message;
//   final String? prefix;
//   final String? url;

//   AppException([this.message, this.prefix, this.url]);
// }

// class BadRequestException extends AppException {
//   BadRequestException([String? message, String? url])
//       : super(message, 'Bad request', url);
// }

// class FetchDataException extends AppException {
//   FetchDataException([String? message, String? url])
//       : super(message, 'Unable to process the request', url);
// }

// class ApiNotRespondingException extends AppException {
//   ApiNotRespondingException([String? message, String? url])
//       : super(message, 'Api not responding', url);
// }

// class UnAuthorizedException extends AppException {
//   UnAuthorizedException([String? message, String? url])
//       : super(message, 'Unauthorized request', url);
// }

// class NotFoundException extends AppException {
//   NotFoundException([String? message, String? url])
//       : super(message, 'Page not found', url);
// }
