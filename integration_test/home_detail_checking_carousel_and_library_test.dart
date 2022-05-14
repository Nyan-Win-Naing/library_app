import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:library_app/pages/home_page.dart';

import 'test_data/test_data.dart';

Future<void> homeDetailCarouselAndLibraryTest(WidgetTester tester) async {
  await tester.pumpAndSettle(Duration(seconds: 5));
  expect(find.byType(HomePage), findsOneWidget);
  expect(find.text(TEST_DATA_HOME_PAGE_BOOK_LIST_NAME_ONE), findsOneWidget);
  expect(
      find.text(TEST_DATA_HOME_PAGE_BOOK_ONE_FROM_LIST_ONE), findsWidgets);

  await tester.tap(find.byKey(Key(TEST_DATA_HOME_PAGE_BOOK_ONE_KEY_NAME)));
  /// Test Book Detail Page
  await bookDetailPageTest(
    tester,
    TEST_DATA_HOME_PAGE_BOOK_ONE_FROM_LIST_ONE,
    TEST_DATA_HOME_PAGE_BOOK_ONE_AUTHOR_FROM_LIST_ONE,
    TEST_DATA_HOME_PAGE_BOOK_ONE_PUBLISHER_FROM_LIST_ONE,
    BOOK_DETAIL_SIMILAR_EBOOK_ONE,
  );

  await tester.dragUntilVisible(
    find.text(TEST_DATA_HOME_PAGE_BOOK_LIST_NAME_TWO),
    find.byType(SingleChildScrollView),
    const Offset(-250, 0),
  );
  expect(find.text(TEST_DATA_HOME_PAGE_BOOK_LIST_NAME_TWO), findsOneWidget);
  expect(
      find.text(TEST_DATA_HOME_PAGE_BOOK_ONE_FROM_LIST_TWO), findsWidgets);
  await tester.tap(find.byKey(Key(TEST_DATA_HOME_PAGE_BOOK_TWO_KEY_NAME)));
  /// Test Book Detail Page
  await bookDetailPageTest(
    tester,
    TEST_DATA_HOME_PAGE_BOOK_ONE_FROM_LIST_TWO,
    TEST_DATA_HOME_PAGE_BOOK_ONE_AUTHOR_FROM_LIST_TWO,
    TEST_DATA_HOME_PAGE_BOOK_ONE_PUBLISHER_FROM_LIST_TWO,
    BOOK_DETAIL_SIMILAR_EBOOK_TWO,
  );

  /// Finds Carousel and Test
  await homePageCarouselTest(tester);

  /// Go To Library Page and Test Your Books
  await tester.tap(find.byKey(Key(BOTTOM_NAV_ITEM_TWO)));
  await tester.pumpAndSettle(Duration(seconds: 5));
  expect(find.text(TEST_DATA_HOME_PAGE_BOOK_ONE_FROM_LIST_ONE), findsOneWidget);
  expect(find.text(TEST_DATA_HOME_PAGE_BOOK_ONE_FROM_LIST_TWO), findsOneWidget);
  expect(find.text(CHIP_ONE), findsOneWidget);
  expect(find.text(CHIP_TWO), findsOneWidget);
}

Future<void> homePageCarouselTest(WidgetTester tester) async {
  await tester.dragUntilVisible(
    find.byType(HomeCarouselSectionView),
    find.byType(SingleChildScrollView),
    const Offset(0, 0),
  );
  expect(find.byKey(Key(CAROUSEL_ITEM_ONE_KEY)), findsOneWidget);
  await tester.dragUntilVisible(
    find.byKey(Key(CAROUSEL_ITEM_TWO_KEY)),
    find.byType(HomeCarouselSectionView),
    const Offset(0, -200),
  );
  await tester.pumpAndSettle(Duration(seconds: 2));
  expect(find.byKey(Key(CAROUSEL_ITEM_TWO_KEY)), findsOneWidget);
}

Future<void> bookDetailPageTest(
    WidgetTester tester,
    String bookName,
    String author,
    String publisher,
    String similarBook,
    ) async {
  await tester.pumpAndSettle(Duration(seconds: 5));
  expect(find.text(bookName), findsWidgets);
  expect(find.text(author), findsWidgets);
  expect(find.text(publisher), findsOneWidget);
  await tester.dragUntilVisible(
    find.text(similarBook),
    find.byType(SingleChildScrollView),
    const Offset(-300, 0),
  );
  expect(find.text(similarBook), findsOneWidget);
  await tester.tap(find.byKey(Key(BOOK_DETAIL_BACK_BUTTON_KEY_NAME)));
  await tester.pumpAndSettle(Duration(seconds: 5));
}