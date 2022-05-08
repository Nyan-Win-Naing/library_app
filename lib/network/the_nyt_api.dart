import 'package:dio/dio.dart';
import 'package:library_app/network/api_constants.dart';
import 'package:library_app/network/responses/get_lists_response.dart';
import 'package:library_app/network/responses/get_overview_response.dart';
import 'package:retrofit/http.dart';

part 'the_nyt_api.g.dart';

@RestApi(baseUrl: BASE_URL_DIO)
abstract class TheNytApi {
  factory TheNytApi(Dio dio) = _TheNytApi;

  @GET(ENDPOINT_GET_OVERVIEW)
  Future<GetOverviewResponse> getOverview(
    @Query(PARAM_API_KEY) String apiKey,
    @Query(PARAM_PUBLISHED_DATE) String publishedDate,
  );

  @GET(ENDPOINT_GET_LISTS)
  Future<GetListsResponse> getLists(
    @Query(PARAM_API_KEY) String apiKey,
    @Query(PARAM_LIST) String listName,
    @Query(PARAM_OFFSET) String offset,
  );
}
