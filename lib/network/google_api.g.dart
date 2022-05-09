// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _GoogleApi implements GoogleApi {
  _GoogleApi(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://www.googleapis.com/books';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<GetGoogleBookSuggestionsResponse> getSearchedBookResults(q) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'q': q};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetGoogleBookSuggestionsResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(_dio.options, '/v1/volumes',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetGoogleBookSuggestionsResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
