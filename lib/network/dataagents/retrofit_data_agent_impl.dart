import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/data/vos/horizontal_book_list_item_vo.dart';
import 'package:library_app/network/api_constants.dart';
import 'package:library_app/network/dataagents/book_data_agent.dart';
import 'package:library_app/network/the_nyt_api.dart';

class RetrofitDataAgentImpl extends BookDataAgent {
  late TheNytApi nApi;

  static final RetrofitDataAgentImpl _singleton =
      RetrofitDataAgentImpl._internal();

  factory RetrofitDataAgentImpl() {
    return _singleton;
  }

  RetrofitDataAgentImpl._internal() {
    final dio = Dio();
    nApi = TheNytApi(dio);
  }

  @override
  Future<List<HorizontalBookListItemVO>?> getHorizontalBookListItems(
      String publishedDate) {
    return nApi
        .getOverview(API_KEY, PUBLISHED_DATE)
        .asStream()
        .map((response) => response.results?.lists)
        .first;
  }

  @override
  Future<List<BookVO>?> getMoreBooks(String listName, String offset) {
    return nApi.getLists(API_KEY, listName, "0").asStream().map((response) {
      var bookList = response.results?.map((moreBookListItem) {
        return moreBookListItem.bookDetails?.first ?? BookVO();
      }).toList() ?? [];
      return bookList;
    }).first;
  }
}
