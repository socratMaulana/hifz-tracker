import '../../core_imports.dart';
import 'interceptor.dart';

class Network {
  Network._internal();

  static final _singleton = Network._internal();

  factory Network() => _singleton;

  final _dio = Dio(
    BaseOptions(
        baseUrl: Constants.baseUrl,
        receiveTimeout: 15000,
        connectTimeout: 15000,
        sendTimeout: 15000,
        headers: {
          'Connection': 'Keep-Alive',
        },
        receiveDataWhenStatusError: true),
  )..interceptors.add(CustomInterceptor());

  Future<dynamic> get(String endpoint) async {
    try {
      final token = await Utils.readFromSecureStorage(key: Constants.token);
      _dio.options.headers.addAll({'Authorization': 'Bearer $token'});

      final response = await _dio.get(endpoint);
      final data = response.data;

      if (data['response']['status'] != 200) {
        throw data['error_desc'];
      }

      return data['data'];
    } on DioError catch (e) {
      throw e.message;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> post(
      {required String endpoint, required dynamic requestBody}) async {
    try {
      final token = await Utils.readFromSecureStorage(key: Constants.token);
      _dio.options.headers.addAll({'Authorization': 'Bearer $token'});

      final response = await _dio.post(endpoint, data: requestBody);
      final data = response.data;

      if (data['response']['status'] != 200 &&
          data['response']['status'] != 201) {
        throw data['error_desc'];
      }

      return data['data'];
    } on DioError catch (e) {
      throw e.message;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> postNoToken(
      {required String endpoint, required dynamic requestBody}) async {
    try {
      final response = await _dio.post(endpoint, data: requestBody);
      final data = response.data;

      if (data['response']['status'] != 200 &&
          data['response']['status'] != 201) {
        throw data['error_desc'];
      }

      return data['data'];
    } on DioError catch (e) {
      throw e.error;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> put(
      {required String endpoint, required dynamic requestBody}) async {
    try {
      final token = await Utils.readFromSecureStorage(key: Constants.token);
      _dio.options.headers.addAll({'Authorization': 'Bearer $token'});

      final response = await _dio.put(endpoint, data: requestBody);
      final data = response.data;

      if (data['response']['status'] != 200 &&
          data['response']['status'] != 201) {
        throw data['error_desc'];
      }

      return data['data'];
    } on DioError catch (e) {
      throw e.message;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> delete(String endpoint) async {
    try {
      final token = await Utils.readFromSecureStorage(key: Constants.token);
      _dio.options.headers.addAll({'Authorization': 'Bearer $token'});

      await _dio.delete(endpoint);
    } on DioError catch (e) {
      throw e.message;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> uploadPut(
      {required String endpoint, required dynamic requestBody}) async {
    try {
      final token = await Utils.readFromSecureStorage(key: Constants.token);
      _dio.options.headers.addAll({'Authorization': 'Bearer $token'});
      _dio.options.headers['content-type'] = 'multipart/form-data';

      final response = await _dio.put(endpoint, data: requestBody);
      final data = response.data;

      if (data['response']['status'] != 200 &&
          data['response']['status'] != 201) {
        throw data['error_desc'];
      }

      return data['data'];
    } on DioError catch (e) {
      throw e.message;
    } catch (e) {
      rethrow;
    }
  }
}
