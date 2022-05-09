import 'package:dio/dio.dart';
import 'package:library_app/network/api_constants.dart';
import 'package:library_app/network/responses/get_google_book_suggestions_response.dart';
import 'package:retrofit/http.dart';

part 'google_api.g.dart';

@RestApi(baseUrl: GOOGLE_API_BASE_URL_DIO)
abstract class GoogleApi {
  factory GoogleApi(Dio dio) = _GoogleApi;

  @GET(ENDPOINT_GET_SEARCHED_BOOK_RESULTS)
  Future<GetGoogleBookSuggestionsResponse> getSearchedBookResults(
    @Query(PARAM_FOR_GOOGLE_API) String q,
  );
}
