import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'test_data/test_data.dart';

Future<void> shelvesOperationTest(WidgetTester tester) async {
  Finder addShelfFieldKey = find.byKey(Key(ADD_SHELF_FIELD_KEY));
  await tester.tap(find.byKey(Key(BOTTOM_NAV_ITEM_TWO)));
  await tester.pumpAndSettle(Duration(seconds: 5));
  await tester.tap(find.byKey(Key(YOUR_SHELVES_TAB_FROM_LIBRARY_PAGE_KEY)));
  await tester.pumpAndSettle(Duration(seconds: 3));

  /// Add Shelf One
  await addNewShelfTest(tester, addShelfFieldKey, SHELF_ONE);

  /// Add Shelf Two
  await addNewShelfTest(tester, addShelfFieldKey, SHELF_TWO);

  /// Back To Home Page
  await tester.tap(find.byKey(Key(BOTTOM_NAV_ITEM_ONE)));
  await tester.pumpAndSettle(Duration(seconds: 5));

  /// Add Book One to Two Shelves
  await addBookOneToTwoShelves(tester);

  /// Add Book One to One Shelf
  await addBookTwoToOneShelf(tester);

  /// Back To Detail Page
  await tester.tap(find.byKey(Key(BOTTOM_NAV_ITEM_TWO)));
  await tester.pumpAndSettle(Duration(seconds: 5));

  /// Change Shelves Tab
  await tester.tap(find.byKey(Key(YOUR_SHELVES_TAB_FROM_LIBRARY_PAGE_KEY)));
  await tester.pumpAndSettle(Duration(seconds: 5));

  /// Test Shelf And Books
  expect(find.text(SHELF_ONE), findsOneWidget);
  expect(find.text(SHELF_ONE_BOOKS_COUNT), findsOneWidget);
  expect(find.text(SHELF_TWO), findsOneWidget);
  expect(find.text(SHELF_TWO_BOOKS_COUNT), findsOneWidget);

  /// Tap One Shelf
  await tester.tap(find.text(SHELF_ONE));
  await tester.pumpAndSettle(Duration(seconds: 5));
  expect(find.text(SHELF_ONE), findsOneWidget);
  // expect(find.text(SHELF_ONE_BOOKS_COUNT), findsOneWidget);
  expect(find.text(TEST_DATA_HOME_PAGE_BOOK_ONE_FROM_LIST_ONE), findsOneWidget);
  // expect(find.text(TEST_DATA_HOME_PAGE_BOOK_ONE_FROM_LIST_TWO), findsOneWidget);

  /// Tap PopUp menu Icon
  await tester.tap(find.byKey(Key(SHELF_POP_UP_MENU_KEY)));
  await tester.pumpAndSettle(Duration(seconds: 2));

  /// Tap Rename PopUp Item and Rename
  Finder renameField = find.byKey(Key(SHELF_RENAME_FIELD_KEY));
  await tester.tap(find.byKey(Key(SHELF_POP_UP_RENAME_KEY)));
  await tester.pumpAndSettle(Duration(seconds: 2));
  await tester.enterText(renameField, "");
  await tester.enterText(renameField, NEW_SHELF_NAME);
  await Future.delayed(Duration(seconds: 5));
  await tester.testTextInput.receiveAction(TextInputAction.done);
  await tester.pumpAndSettle();
  expect(find.text(NEW_SHELF_NAME), findsOneWidget);

  /// Back To Shelves page and test rename shelf
  await tester.tap(find.byKey(Key(EACH_SHELF_BACK_ICON_KEY)));
  await tester.pumpAndSettle(Duration(seconds: 5));
  await tester.tap(find.text(NEW_SHELF_NAME));
  await tester.pumpAndSettle(Duration(seconds: 5));
  await tester.tap(find.byKey(Key(SHELF_POP_UP_MENU_KEY)));
  await tester.pumpAndSettle(Duration(seconds: 2));
  await tester.tap(find.byKey(Key(SHELF_POP_UP_DELETE_KEY)));
  await tester.pumpAndSettle(Duration(seconds: 2));
  await tester.tap(find.text("DELETE"));
  await tester.pumpAndSettle(Duration(seconds: 5));
  expect(find.text(NEW_SHELF_NAME), findsNothing);
}

Future<void> addBookTwoToOneShelf(WidgetTester tester) async {
  /// Find Book Two
  await tester.dragUntilVisible(
    find.byKey(Key(TEST_DATA_HOME_PAGE_BOOK_TWO_KEY_NAME)),
    find.byType(SingleChildScrollView),
    const Offset(-200, 0),
  );
  /// Tap Add To Shelf
  await tester.tap(find.byKey(Key(TEST_DATA_HOME_PAGE_BOOK_TWO_MORE_KEY_NAME)));
  await tester.pumpAndSettle();
  await tester.tap(find.text(ADD_SHELF_TEXT));
  await tester.pumpAndSettle(Duration(seconds: 5));
  /// Check One Shelf
  await tester.tap(find.byKey(Key(SHELF_ONE_CHECK_BOX)));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(Key(ADD_TO_SHELVES_DONE_BUTTON_KEY)));
  await tester.pumpAndSettle(Duration(seconds: 3));
}

Future<void> addBookOneToTwoShelves(WidgetTester tester) async {

  /// Find Book One
  await tester.dragUntilVisible(
    find.byKey(Key(TEST_DATA_HOME_PAGE_BOOK_ONE_KEY_NAME)),
    find.byType(SingleChildScrollView),
    const Offset(-200, 0),
  );
  /// Tap Add To Shelf
  await tester.tap(find.byKey(Key(TEST_DATA_HOME_PAGE_BOOK_ONE_MORE_KEY_NAME)));
  await tester.pumpAndSettle();
  await tester.tap(find.text(ADD_SHELF_TEXT));
  await tester.pumpAndSettle(Duration(seconds: 5));

  /// Check Two Shelves
  await tester.tap(find.byKey(Key(SHELF_ONE_CHECK_BOX)));
  await tester.tap(find.byKey(Key(SHELF_TWO_CHECK_BOX)));
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(Key(ADD_TO_SHELVES_DONE_BUTTON_KEY)));
  await tester.pumpAndSettle(Duration(seconds: 3));
}

Future<void> addNewShelfTest(
    WidgetTester tester, Finder addShelfFieldKey, String shelf) async {
  await tester.tap(find.byKey(Key(CREAET_NEW_SHELF_BUTTON_KEY)));
  await tester.pumpAndSettle(Duration(seconds: 3));
  await tester.tap(addShelfFieldKey);
  await tester.enterText(addShelfFieldKey, shelf);
  await tester.tap(find.byKey(Key(ADD_SHELF_DONE_BUTTON_KEY)));
  await tester.pumpAndSettle(Duration(seconds: 3));
  expect(find.text(shelf), findsOneWidget);
}
