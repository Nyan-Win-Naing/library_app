import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_data/test_data.dart';

Future<void> yourBooksFromLibraryPageTest(WidgetTester tester) async {
  /// Tap Chip One
  await tester.tap(find.text(CHIP_ONE));
  await tester.pumpAndSettle();
  expect(find.text(TEST_DATA_HOME_PAGE_BOOK_ONE_FROM_LIST_TWO), findsOneWidget);
  expect(find.text(TEST_DATA_HOME_PAGE_BOOK_ONE_FROM_LIST_ONE), findsNothing);
  /// Tap Chip Two
  await tester.tap(find.text(CHIP_TWO));
  await tester.pumpAndSettle();
  expect(find.text(TEST_DATA_HOME_PAGE_BOOK_ONE_FROM_LIST_TWO), findsOneWidget);
  expect(find.text(TEST_DATA_HOME_PAGE_BOOK_ONE_FROM_LIST_ONE), findsOneWidget);
  /// Tap Clear Chip
  await tester.tap(find.byKey(Key(CHIP_CLOSE_BUTTON_KEY)));
  await tester.pumpAndSettle();
  expect(find.text(TEST_DATA_HOME_PAGE_BOOK_ONE_FROM_LIST_TWO), findsOneWidget);
  expect(find.text(TEST_DATA_HOME_PAGE_BOOK_ONE_FROM_LIST_ONE), findsOneWidget);

  /// Test View
  expect(find.byKey(Key(VERTICAL_LIST_VIEW_KEY)), findsOneWidget);
  await tester.tap(find.byKey(Key(CHANGE_VIEW_KEY)));
  await tester.pumpAndSettle();
  expect(find.byKey(Key(TWO_COLUMN_GRID_VIEW_KEY)), findsOneWidget);
  await tester.tap(find.byKey(Key(CHANGE_VIEW_KEY)));
  await tester.pumpAndSettle();
  expect(find.byKey(Key(THREE_COLUMN_GRID_VIEW_KEY)), findsOneWidget);
  await tester.tap(find.byKey(Key(CHANGE_VIEW_KEY)));
  await tester.pumpAndSettle();

  /// Test Sort By
  await sortByTesting(tester, RADIO_ONE_KEY, SORT_BY_AUTHOR);
  await sortByTesting(tester, RADIO_TWO_KEY, SORT_BY_RECENT);
  await sortByTesting(tester, RADIO_THREE_KEY, SORT_BY_TITLE);
  await tester.pumpAndSettle(Duration(seconds: 3));
}

Future<void> sortByTesting(WidgetTester tester, String radioKey, String sortBy) async {
  await tester.tap(find.byKey(Key(SORT_BY_KEY)));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(Key(radioKey)));
  await tester.pumpAndSettle();
  expect(find.text(sortBy), findsOneWidget);
}