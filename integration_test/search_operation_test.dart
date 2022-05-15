import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:library_app/pages/home_page.dart';
import 'package:library_app/pages/search_books_result_page.dart';

import 'test_data/test_data.dart';

Future<void> searchOperationTest(WidgetTester tester) async {
  await tester.tap(find.byKey(Key(BOTTOM_NAV_ITEM_ONE)));
  await tester.pumpAndSettle(Duration(seconds: 5));
  await tester.tap(find.text(SEARCH_PLAY_BOOKS));
  await tester.pumpAndSettle(Duration(seconds: 5));

  /// Type Search words in Text Field
  await tester.enterText(find.byKey(Key(SEARCH_FIELD_KEY)), "flutter");
  await tester.pumpAndSettle(Duration(seconds: 3));

  /// Test Searched Books From Suggestions
  expect(find.text(SEARCHED_BOOK_ONE), findsOneWidget);
  expect(find.text(SEARCHED_BOOK_TWO), findsOneWidget);
  expect(find.text(SEARCHED_BOOK_THREE), findsOneWidget);

  /// Click Done from Keyboard
  await tester.testTextInput.receiveAction(TextInputAction.done);

  /// Searched Results Page
  await tester.pumpAndSettle(Duration(seconds: 5));
  expect(find.byType(SearchBooksResultPage), findsOneWidget);
  expect(find.text(SEARCHED_RESULTS_CATEGORY_ONE), findsOneWidget);
  expect(find.text(SEARCHED_BOOK_ONE), findsOneWidget);
  // expect(find.text(SEARCHED_BOOK_TWO), findsOneWidget);

  /// Tap First Book From Horizontal List
  await tester.tap(find.text(SEARCHED_BOOK_ONE));
  await tester.pumpAndSettle(Duration(seconds: 5));
  await tester.tap(find.byKey(Key(BOOK_DETAIL_BACK_BUTTON_KEY_NAME)));

  /// Back From Search Results Page
  await tester.pumpAndSettle(Duration(seconds: 2));
  await tester.tap(find.byKey(Key(SEARCHED_RESULTS_PAGE_BACK_KEY)));

  /// Back From Search Suggestion Page
  await tester.pumpAndSettle(Duration(seconds: 2));
  await tester.tap(find.byKey(Key(SEARCHED_BOOKS_PAGE_BACK_KEY)));
  await tester.pumpAndSettle(Duration(seconds: 5));


  // expect(find.byKey(Key(CAROUSEL_ITEM_ONE_KEY)), findsOneWidget);
  // await tester.dragUntilVisible(
  //   find.byKey(Key(CAROUSEL_ITEM_TWO_KEY)),
  //   find.byType(HomeCarouselSectionView),
  //   const Offset(0, -50),
  // );
  // await tester.pumpAndSettle(Duration(seconds: 5));
  // expect(find.byKey(Key(CAROUSEL_ITEM_TWO_KEY)), findsOneWidget);
  //
  // await tester.dragUntilVisible(
  //   find.byKey(Key(CAROUSEL_ITEM_THREE_KEY)),
  //   find.byType(HomeCarouselSectionView),
  //   const Offset(0, -50),
  // );
  // await tester.pumpAndSettle(Duration(seconds: 5));
  // expect(find.byKey(Key(CAROUSEL_ITEM_THREE_KEY)), findsOneWidget);
}