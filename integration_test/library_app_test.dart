import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:integration_test/integration_test.dart';
import 'package:library_app/data/vos/book_list_for_hive_vo.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/data/vos/buy_link_vo.dart';
import 'package:library_app/data/vos/get_overview_result_vo.dart';
import 'package:library_app/data/vos/horizontal_book_list_item_vo.dart';
import 'package:library_app/data/vos/shelf_vo.dart';
import 'package:library_app/main.dart';
import 'package:library_app/pages/home_page.dart';
import 'package:library_app/pages/search_books_result_page.dart';
import 'package:library_app/persistence/hive_constants.dart';

import 'home_detail_checking_carousel_and_library_test.dart';
import 'test_data/test_data.dart';
import 'your_books_section_test.dart';

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(BookVOAdapter());
  Hive.registerAdapter(BuyLinkVOAdapter());
  Hive.registerAdapter(GetOverviewResultVOAdapter());
  Hive.registerAdapter(HorizontalBookListItemVOAdapter());
  Hive.registerAdapter(BookListForHiveVOAdapter());
  Hive.registerAdapter(ShelfVOAdapter());

  await Hive.openBox<BookVO>(BOX_NAME_BOOK_VO);
  await Hive.openBox<BookVO>(BOX_NAME_BOOK_VO_FOR_CAROUSEL);
  await Hive.openBox<BookListForHiveVO>(BOX_NAME_BOOK_VO_FOR_SEARCH_RESULT);
  await Hive.openBox<ShelfVO>(BOX_NAME_SHELF_VO);

  testWidgets(
    "Library App Test",
    (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      await Future.delayed(Duration(seconds: 2));

      /// Flow 1. Home Page, Detail Page, Checking Carousel and Library Test
      await homeDetailCarouselAndLibraryTest(tester);

      /// Flow 2. Your books Tab From Library Page Test
      await yourBooksFromLibraryPageTest(tester);

      /// Flow 3
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
      expect(find.text(SEARCHED_BOOK_TWO), findsOneWidget);
      await tester.tap(find.text(SEARCHED_BOOK_ONE));
      await tester.pumpAndSettle(Duration(seconds: 5));
      await tester.tap(find.byKey(Key(BOOK_DETAIL_BACK_BUTTON_KEY_NAME)));
      await tester.pumpAndSettle(Duration(seconds: 2));
      await tester.tap(find.byKey(Key(SEARCHED_RESULTS_PAGE_BACK_KEY)));
      await tester.pumpAndSettle(Duration(seconds: 2));
      await tester.tap(find.byKey(Key(SEARCHED_BOOKS_PAGE_BACK_KEY)));
      await tester.pumpAndSettle(Duration(seconds: 5));


      expect(find.byKey(Key(CAROUSEL_ITEM_ONE_KEY)), findsOneWidget);
      await tester.dragUntilVisible(
        find.byKey(Key(CAROUSEL_ITEM_TWO_KEY)),
        find.byType(HomeCarouselSectionView),
        const Offset(0, -50),
      );
      await tester.pumpAndSettle(Duration(seconds: 5));
      expect(find.byKey(Key(CAROUSEL_ITEM_TWO_KEY)), findsOneWidget);

      await tester.dragUntilVisible(
        find.byKey(Key(CAROUSEL_ITEM_THREE_KEY)),
        find.byType(HomeCarouselSectionView),
        const Offset(0, -50),
      );
      await tester.pumpAndSettle(Duration(seconds: 5));
      expect(find.byKey(Key(CAROUSEL_ITEM_THREE_KEY)), findsOneWidget);
    },
  );
}
