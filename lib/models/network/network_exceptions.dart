import 'dart:io';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rhea_app/l10n/l10n.dart';
import 'package:rhea_app/models/network/status_code.dart';
import 'package:rhea_app/navigation/routes.dart';

part 'network_exceptions.freezed.dart';

@freezed
class NetworkExceptions with _$NetworkExceptions {
  const factory NetworkExceptions.requestCancelled() = RequestCancelled;
  const factory NetworkExceptions.unauthorizedRequest() = UnauthorizedRequest;
  const factory NetworkExceptions.badRequest() = BadRequest;
  const factory NetworkExceptions.forbidden() = Forbidden;
  const factory NetworkExceptions.notFound() = NotFound;
  const factory NetworkExceptions.methodNotAllowed() = MethodNotAllowed;
  const factory NetworkExceptions.notAcceptable() = NotAcceptable;
  const factory NetworkExceptions.requestTimeout() = RequestTimeout;
  const factory NetworkExceptions.sendTimeout() = SendTimeout;
  const factory NetworkExceptions.conflict() = Conflict;
  const factory NetworkExceptions.internalServerError() = InternalServerError;
  const factory NetworkExceptions.notImplemented() = NotImplemented;
  const factory NetworkExceptions.badGateway() = BadGateway;
  const factory NetworkExceptions.serviceUnavailable() = ServiceUnavailable;
  const factory NetworkExceptions.noInternetConnection() = NoInternetConnection;
  const factory NetworkExceptions.formatException() = FormatException;
  const factory NetworkExceptions.unableToProcess() = UnableToProcess;
  const factory NetworkExceptions.defaultError(String error) = DefaultError;
  const factory NetworkExceptions.unexpectedError() = UnexpectedError;

  factory NetworkExceptions.getDioException(dynamic error) {
    if (error is Exception) {
      try {
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              return const NetworkExceptions.requestCancelled();
            case DioErrorType.connectTimeout:
              return const NetworkExceptions.requestTimeout();
            case DioErrorType.other:
              return const NetworkExceptions.noInternetConnection();
            case DioErrorType.receiveTimeout:
              return const NetworkExceptions.sendTimeout();
            case DioErrorType.response:
              switch (error.response!.statusCode) {
                case badRequest:
                  return const NetworkExceptions.badRequest();
                case unauthorized:
                  return const NetworkExceptions.unauthorizedRequest();
                case methodNotAllowed:
                  return const NetworkExceptions.methodNotAllowed();
                case forbidden:
                  return const NetworkExceptions.forbidden();
                case notFound:
                  return const NetworkExceptions.notFound();
                case requestTimeout:
                  return const NetworkExceptions.requestTimeout();
                case conflict:
                  return const NetworkExceptions.conflict();
                case internalServerError:
                  return const NetworkExceptions.internalServerError();
                case badGateway:
                  return const NetworkExceptions.badGateway();
                case serviceUnavailable:
                  return const NetworkExceptions.serviceUnavailable();
                default:
                  final responseCode = error.response!.statusCode;
                  return NetworkExceptions.defaultError(
                    'Received invalid status code: $responseCode',
                  );
              }
            case DioErrorType.sendTimeout:
              return const NetworkExceptions.sendTimeout();
          }
        }
        if (error is SocketException) {
          return const NetworkExceptions.noInternetConnection();
        }
        return const NetworkExceptions.unexpectedError();
      } on FormatException catch (_) {
        return const NetworkExceptions.formatException();
      } catch (_) {
        return const NetworkExceptions.unexpectedError();
      }
    }
    if (error.toString().contains('is not a subtype of')) {
      return const NetworkExceptions.unableToProcess();
    }
    return const NetworkExceptions.unexpectedError();
  }

  static String? getError(dynamic err) {
    if (err is DioError) {
      if (err.response?.data is Map<String, dynamic>) {
        // ignore: avoid_dynamic_calls
        return '${err.response?.data['message']}'.trim();
      }
      return err.response?.data?.toString().trim();
    }
    return null;
  }

  static bool isUnauthorized(dynamic err) {
    if (err is DioError &&
        (err.response?.statusCode == forbidden ||
            err.response?.statusCode == unauthorized)) {
      return true;
    }
    return err is UnauthorizedRequest || err is Forbidden;
  }

  static String getErrorMessage(NetworkExceptions networkException) {
    final l10n = navigatorKey.currentContext!.l10n;
    var errorMessage = '';
    networkException.when(
      requestCancelled: () => errorMessage = l10n.requestCancelled,
      unauthorizedRequest: () => errorMessage = l10n.unauthorizedRequest,
      badRequest: () => errorMessage = l10n.badRequest,
      forbidden: () => errorMessage = l10n.forbidden,
      notFound: () => errorMessage = l10n.notFound,
      methodNotAllowed: () => errorMessage = l10n.methodNotAllowed,
      notAcceptable: () => errorMessage = l10n.notAcceptable,
      requestTimeout: () => errorMessage = l10n.requestTimeout,
      sendTimeout: () => errorMessage = l10n.sendTimeout,
      conflict: () => errorMessage = l10n.conflict,
      internalServerError: () => errorMessage = l10n.internalServerError,
      notImplemented: () => errorMessage = l10n.notImplemented,
      badGateway: () => errorMessage = l10n.badGateway,
      serviceUnavailable: () => errorMessage = l10n.serviceUnavailable,
      noInternetConnection: () => errorMessage = l10n.noInternetConnection,
      formatException: () => errorMessage = l10n.formatException,
      unableToProcess: () => errorMessage = l10n.unableToProcess,
      defaultError: (String error) => errorMessage = error,
      unexpectedError: () => errorMessage = l10n.unexpectedError,
    );
    return errorMessage;
  }
}
