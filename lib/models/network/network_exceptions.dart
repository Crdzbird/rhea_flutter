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
        NetworkExceptions networkExceptions;
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              networkExceptions = const NetworkExceptions.requestCancelled();
              break;
            case DioErrorType.connectTimeout:
              networkExceptions = const NetworkExceptions.requestTimeout();
              break;
            case DioErrorType.other:
              networkExceptions =
                  const NetworkExceptions.noInternetConnection();
              break;
            case DioErrorType.receiveTimeout:
              networkExceptions = const NetworkExceptions.sendTimeout();
              break;
            case DioErrorType.response:
              switch (error.response!.statusCode) {
                case badRequest:
                  networkExceptions = const NetworkExceptions.badRequest();
                  break;
                case unauthorized:
                  networkExceptions =
                      const NetworkExceptions.unauthorizedRequest();
                  break;
                case methodNotAllowed:
                  networkExceptions =
                      const NetworkExceptions.methodNotAllowed();
                  break;
                case forbidden:
                  networkExceptions = const NetworkExceptions.forbidden();
                  break;
                case notFound:
                  networkExceptions = const NetworkExceptions.notFound();
                  break;
                case requestTimeout:
                  networkExceptions = const NetworkExceptions.requestTimeout();
                  break;
                case conflict:
                  networkExceptions = const NetworkExceptions.conflict();
                  break;
                case internalServerError:
                  networkExceptions =
                      const NetworkExceptions.internalServerError();
                  break;
                case badGateway:
                  networkExceptions = const NetworkExceptions.badGateway();
                  break;
                case serviceUnavailable:
                  networkExceptions =
                      const NetworkExceptions.serviceUnavailable();
                  break;
                default:
                  final responseCode = error.response!.statusCode;
                  networkExceptions = NetworkExceptions.defaultError(
                    'Received invalid status code: $responseCode',
                  );
              }
              break;
            case DioErrorType.sendTimeout:
              networkExceptions = const NetworkExceptions.sendTimeout();
              break;
          }
        } else if (error is SocketException) {
          networkExceptions = const NetworkExceptions.noInternetConnection();
        } else {
          networkExceptions = const NetworkExceptions.unexpectedError();
        }
        return networkExceptions;
      } on FormatException catch (_) {
        return const NetworkExceptions.formatException();
      } catch (_) {
        return const NetworkExceptions.unexpectedError();
      }
    } else {
      if (error.toString().contains('is not a subtype of')) {
        return const NetworkExceptions.unableToProcess();
      } else {
        return const NetworkExceptions.unexpectedError();
      }
    }
  }

  static String? getError(dynamic err) {
    if (err is DioError) {
      if (err.response?.data is Map<String, dynamic>) {
        // ignore: avoid_dynamic_calls
        return '${err.response?.data['message']}'.trim();
      } else {
        return err.response?.data?.toString().trim();
      }
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
