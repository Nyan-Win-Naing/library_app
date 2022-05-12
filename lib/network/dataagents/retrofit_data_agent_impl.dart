import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/data/vos/google_vos/google_book_vo.dart';
import 'package:library_app/data/vos/horizontal_book_list_item_vo.dart';
import 'package:library_app/network/api_constants.dart';
import 'package:library_app/network/dataagents/book_data_agent.dart';
import 'package:library_app/network/google_api.dart';
import 'package:library_app/network/the_nyt_api.dart';

class RetrofitDataAgentImpl extends BookDataAgent {
  late TheNytApi nApi;
  late GoogleApi gApi;

  static final RetrofitDataAgentImpl _singleton =
      RetrofitDataAgentImpl._internal();

  factory RetrofitDataAgentImpl() {
    return _singleton;
  }

  RetrofitDataAgentImpl._internal() {
    final dio = Dio();
    nApi = TheNytApi(dio);
    gApi = GoogleApi(dio);
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
    print("List name in retrofit data agent impl is: $listName");
    return nApi.getLists(API_KEY, listName, "0").asStream().map((response) {
      var bookList = response.results?.map((moreBookListItem) {
            return moreBookListItem.bookDetails?.first ?? BookVO();
          }).toList() ??
          [];
      return bookList;
    }).first;
  }

  @override
  Future<List<BookVO>?> getSearchedBookResults(String searchedWord) {
    return gApi.getSearchedBookResults(searchedWord).asStream().map((response) {
      List<GoogleBookVO> gBookResults = response.items ?? [];
      List<BookVO> searchedBookResults = mapToBookVO(gBookResults);
      return searchedBookResults;
    }).first;
  }

  List<BookVO> mapToBookVO(List<GoogleBookVO> gBookResults) {
    return gBookResults.map((gBook) {
      BookVO book = BookVO(
        author: gBook.volumeInfo?.authors?.join(","),
        bookImage: gBook.volumeInfo?.imageLinks?.thumbnail,
        description: gBook.volumeInfo?.description,
        price: gBook.saleInfo?.listPrice?.amount.toString(),
        primaryIsbn10: gBook.volumeInfo?.industryIdentifiers?.last.identifier,
        primaryIsbn13:
            gBook.volumeInfo?.industryIdentifiers?.first.identifier,
        publisher: gBook.volumeInfo?.publisher,
        title: gBook.volumeInfo?.title,
        category: gBook.volumeInfo?.categories?.first ?? "No Category",
      );
      return book;
    }).toList();
  }
}
