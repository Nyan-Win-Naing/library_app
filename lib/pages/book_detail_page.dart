import 'package:flutter/material.dart';
import 'package:library_app/blocs/book_detail_bloc.dart';
import 'package:library_app/data/models/book_model.dart';
import 'package:library_app/data/models/book_model_impl.dart';
import 'package:library_app/data/vos/book_vo.dart';
import 'package:library_app/resources/colors.dart';
import 'package:library_app/resources/dimens.dart';
import 'package:library_app/resources/strings.dart';
import 'package:library_app/widgets/horizontal_book_list_view.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class BookDetailPage extends StatelessWidget {
  final String title;

  BookDetailPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BookDetailBloc(title),
      child: Scaffold(
        backgroundColor: PRIMARY_COLOR,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: PRIMARY_COLOR,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.keyboard_arrow_left_sharp,
              color: SECONDARY_COLOR,
              size: MARGIN_XXLARGE,
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: MARGIN_LARGE),
              child: Icon(
                Icons.search,
                color: SECONDARY_COLOR,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: MARGIN_LARGE),
              child: Icon(
                Icons.bookmark_add_outlined,
                color: SECONDARY_COLOR,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: MARGIN_MEDIUM_3),
              child: Icon(
                Icons.more_vert,
                color: SECONDARY_COLOR,
              ),
            ),
          ],
        ),
        body: Container(
          child: Selector<BookDetailBloc, BookVO?>(
            selector: (context, bloc) => bloc.book,
            builder: (context, book, child) =>
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: MARGIN_MEDIUM_3,
                          vertical: MARGIN_XLARGE,
                        ),
                        child: BookCoverNameAndAuthorSectionView(book: book),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3),
                        child: BookRatingAndTypeSectionView(),
                      ),
                      const SizedBox(height: MARGIN_XLARGE),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BookDetailButtonView(
                                isBuy: false, buttonText: "Free sample"),
                            BookDetailButtonView(
                                isBuy: true, buttonText: "Buy SGD 15.30"),
                          ],
                        ),
                      ),
                      const SizedBox(height: MARGIN_XLARGE),
                      const Text(
                        DETAIL_PAGE_SWITCH_TO_AUDIO_BOOK_TEXT,
                        style: TextStyle(
                          color: DETAIL_PAGE_SWITCH_TO_AUDIO_BOOK_TEXT_COLOR,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: MARGIN_XLARGE),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3),
                        height: 1,
                        color: HORIZONTAL_DIVIDER_LINE_LIGHT_COLOR,
                      ),
                      const SizedBox(height: MARGIN_XLARGE),
                      AboutEbookOrAuthorSectionView(
                        title: "About this eBook",
                        about: book?.description ?? "",
                      ),
                      const SizedBox(height: MARGIN_XLARGE),
                      const RatingAndReviewSectionView(),
                      const SizedBox(height: MARGIN_XLARGE),
                      AboutEbookOrAuthorSectionView(
                        title: "About the author",
                        about:
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation",
                      ),
                      const SizedBox(height: MARGIN_XLARGE),
                      BookDetailHorizontalBookListView(
                        title: "Similar ebooks",
                        onTap: () {
                          _navigateToBookDetailPage(context);
                        },
                      ),
                      const SizedBox(height: MARGIN_MEDIUM_3),
                      BookDetailHorizontalBookListView(
                        title: "More by Stephen Hawking",
                        onTap: () {
                          _navigateToBookDetailPage(context);
                        },
                      ),
                      const SizedBox(height: MARGIN_MEDIUM_3),
                      const RateThisEbookSectionView(),
                      const SizedBox(height: MARGIN_MEDIUM_3),
                    ],
                  ),
                ),
          ),
        ),
      ),
    );
  }

  void _navigateToBookDetailPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookDetailPage(title: ""),
      ),
    );
  }
}

class RateThisEbookSectionView extends StatelessWidget {
  const RateThisEbookSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3),
          child: BookDetailTitleView(
            title: DETAIL_PAGE_RATE_THIS_EBOOK,
            isRateThisEbookSection: true,
          ),
        ),
        const SizedBox(height: MARGIN_MEDIUM),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3),
          child: Text(
            DETAIL_PAGE_TELL_OTHER_WHAT_YOU_THINK,
            style: TextStyle(
              color: SECONDARY_COLOR,
            ),
          ),
        ),
        const SizedBox(height: MARGIN_MEDIUM_2),
        Center(
          child: RatingBar.builder(
            unratedColor: DETAIL_PAEG_RATING_BAR_UNRATED_COLOR,
            itemBuilder: (BuildContext context, int index) => const Icon(
              Icons.star,
              color: Colors.blue,
            ),
            itemSize: MARGIN_XXLARGE,
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
        ),
        const SizedBox(height: MARGIN_MEDIUM_2),
        Center(
          child: BookDetailButtonView(
              isBuy: false, buttonText: DETAIL_PAGE_WRITE_A_REVIEW_BUTTON_TEXT),
        )
      ],
    );
  }
}

class BookDetailHorizontalBookListView extends StatelessWidget {
  final String title;
  final Function onTap;

  BookDetailHorizontalBookListView({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3),
          child: BookDetailTitleView(title: title),
        ),
        const SizedBox(height: MARGIN_MEDIUM_2),
        HorizontalBookListView(
          hBooks: [],
          onTap: (title) {
            onTap();
          },
        ),
      ],
    );
  }
}

class RatingAndReviewSectionView extends StatelessWidget {
  const RatingAndReviewSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final avatarRadius = screenHeight / 35;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BookDetailTitleView(title: "Ratings and reviews"),
          const SizedBox(height: MARGIN_MEDIUM_3),
          const RatingNumberAndProgressBarSectionView(),
          const SizedBox(height: MARGIN_MEDIUM_3),
          CommentSectionView(avatarRadius: avatarRadius),
        ],
      ),
    );
  }
}

class CommentSectionView extends StatelessWidget {
  const CommentSectionView({
    Key? key,
    required this.avatarRadius,
  }) : super(key: key);

  final double avatarRadius;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: avatarRadius,
          backgroundImage: const NetworkImage(
            "https://tasteminty.com/page/wp-content/uploads/2020/02/Girl-in-chair-.png",
          ),
        ),
        const SizedBox(width: MARGIN_MEDIUM_2),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Emma Stone",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: MARGIN_SMALL),
              Row(
                children: [
                  RatingBar.builder(
                    initialRating: 5.0,
                    itemBuilder: (context, index) => const Icon(
                      Icons.star,
                      color: Colors.blue,
                    ),
                    itemSize: MARGIN_MEDIUM_2,
                    onRatingUpdate: (rating) {},
                  ),
                  const SizedBox(width: MARGIN_MEDIUM),
                  const Text(
                    "19 May 2022",
                    style: TextStyle(
                      color: BOOK_DETAILS_TEXT_LIGHT_COLOR,
                      fontSize: MARGIN_CARD_MEDIUM_2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: MARGIN_MEDIUM),
              const Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                style: TextStyle(
                  color: BOOK_DETAILS_TEXT_LIGHT_COLOR,
                ),
              ),
              SizedBox(height: MARGIN_LARGE),
              Row(
                children: const [
                  Text(
                    "Was this review helpful?",
                    style: TextStyle(
                      fontSize: MARGIN_CARD_MEDIUM_2,
                      color: BOOK_DETAILS_TEXT_LIGHT_COLOR,
                    ),
                  ),
                  SizedBox(width: MARGIN_MEDIUM_2),
                  Chip(
                    side: BorderSide(
                      color: Color.fromRGBO(219, 221, 224, 1.0),
                      width: 1,
                    ),
                    backgroundColor: PRIMARY_COLOR,
                    label: Text(
                      "Yes",
                    ),
                  ),
                  SizedBox(width: MARGIN_MEDIUM),
                  Chip(
                    side: BorderSide(
                      color: Color.fromRGBO(219, 221, 224, 1.0),
                      width: 1,
                    ),
                    backgroundColor: PRIMARY_COLOR,
                    label: Text(
                      "No",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class RatingNumberAndProgressBarSectionView extends StatelessWidget {
  const RatingNumberAndProgressBarSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            const Text(
              "4.6",
              style: TextStyle(
                fontSize: MARGIN_XXLARGE,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: MARGIN_SMALL),
            RatingBar.builder(
              initialRating: 5.0,
              itemBuilder: (context, index) => const Icon(
                Icons.star,
                color: Colors.blue,
              ),
              itemSize: MARGIN_MEDIUM_2,
              onRatingUpdate: (rating) {},
            ),
            const SizedBox(height: MARGIN_MEDIUM + 2),
            const Text(
              "1868 total",
              style: TextStyle(
                color: Color.fromRGBO(124, 128, 130, 1.0),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LinearProgressBarView(rateNumber: "5", ratePercent: 0.8),
            LinearProgressBarView(rateNumber: "4", ratePercent: 0.2),
            LinearProgressBarView(rateNumber: "3", ratePercent: 0.05),
            LinearProgressBarView(rateNumber: "2", ratePercent: 0.05),
            LinearProgressBarView(rateNumber: "1", ratePercent: 0.05),
          ],
        )
      ],
    );
  }
}

class LinearProgressBarView extends StatelessWidget {
  final String rateNumber;
  final double ratePercent;

  LinearProgressBarView({required this.rateNumber, required this.ratePercent});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: MARGIN_SMALL),
      child: Row(
        children: [
          Text(
            rateNumber,
            style: const TextStyle(
              color: Color.fromRGBO(124, 128, 130, 1.0),
            ),
          ),
          SizedBox(width: MARGIN_SMALL),
          LinearPercentIndicator(
            backgroundColor: const Color.fromRGBO(231, 233, 232, 1.0),
            width: 200,
            animation: true,
            lineHeight: 10.0,
            animationDuration: 2500,
            percent: ratePercent,
            linearStrokeCap: LinearStrokeCap.roundAll,
            progressColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}

class AboutEbookOrAuthorSectionView extends StatelessWidget {
  final String title;
  final String about;

  AboutEbookOrAuthorSectionView({required this.title, required this.about});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3),
      child: Column(
        children: [
          BookDetailTitleView(title: title),
          SizedBox(height: MARGIN_MEDIUM_2),
          Text(
            about,
            style: TextStyle(
              color: Color.fromRGBO(124, 128, 130, 1.0),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class BookDetailTitleView extends StatelessWidget {
  final String title;
  final bool isRateThisEbookSection;

  BookDetailTitleView(
      {required this.title, this.isRateThisEbookSection = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: DETAIT_PAGE_TITLE_VIEW_COLOR,
            fontSize: MARGIN_MEDIUM_3,
            fontWeight: FontWeight.w500,
          ),
        ),
        Visibility(
          visible: (!isRateThisEbookSection) ? true : false,
          child: const Icon(
            Icons.arrow_forward,
            color: Colors.blue,
            size: MARGIN_LARGE,
          ),
        ),
      ],
    );
  }
}

class BookDetailButtonView extends StatelessWidget {
  final bool isBuy;
  final String buttonText;

  BookDetailButtonView({required this.isBuy, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 40,
      decoration: BoxDecoration(
        color: (!isBuy) ? PRIMARY_COLOR : DETAIL_PAGE_SOLID_BUTTON_COLOR,
        borderRadius: BorderRadius.circular(MARGIN_SMALL),
        border: (!isBuy)
            ? Border.all(
                color: DETAIL_PAGE_OUTLINE_BUTTON_COLOR,
              )
            : null,
      ),
      child: Center(
        child: Text(
          buttonText,
          style: TextStyle(
              color: (!isBuy) ? DETAIL_PAGE_SOLID_BUTTON_COLOR : PRIMARY_COLOR,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class BookRatingAndTypeSectionView extends StatelessWidget {
  const BookRatingAndTypeSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Row(
              children: const [
                Text(
                  "4.6",
                  style: TextStyle(
                    fontSize: MARGIN_MEDIUM_2,
                    color: DETAIL_PAGE_RATE_INFO_ICON_COLOR,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: MARGIN_SMALL - 2),
                Icon(
                  Icons.star,
                  color: DETAIL_PAGE_RATE_INFO_ICON_COLOR,
                )
              ],
            ),
            SizedBox(height: MARGIN_MEDIUM),
            const Text(
              "1K reviews",
              style: TextStyle(
                color: DETAIL_PAGE_RATE_INFO_TEXT_COLOR,
              ),
            ),
          ],
        ),
        SmallLineDivider(),
        Column(
          children: const [
            Icon(
              Icons.book_outlined,
              color: DETAIL_PAGE_RATE_INFO_ICON_COLOR,
            ),
            SizedBox(height: MARGIN_MEDIUM),
            Text(
              "eBook",
              style: TextStyle(
                color: DETAIL_PAGE_RATE_INFO_TEXT_COLOR,
              ),
            ),
          ],
        ),
        SmallLineDivider(),
        Column(
          children: const [
            Text(
              "272",
              style: TextStyle(
                fontSize: MARGIN_MEDIUM_2,
                color: DETAIL_PAGE_RATE_INFO_ICON_COLOR,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: MARGIN_MEDIUM),
            Text(
              "Pages",
              style: TextStyle(
                color: DETAIL_PAGE_RATE_INFO_TEXT_COLOR,
              ),
            ),
          ],
        ),
        SmallLineDivider(),
        Column(
          children: const [
            Icon(
              Icons.gpp_good_outlined,
              color: DETAIL_PAGE_RATE_INFO_ICON_COLOR,
            ),
            SizedBox(height: MARGIN_MEDIUM),
            Text(
              "Eligible",
              style: TextStyle(
                color: DETAIL_PAGE_RATE_INFO_TEXT_COLOR,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SmallLineDivider extends StatelessWidget {
  const SmallLineDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: MARGIN_LARGE,
      color: HORIZONTAL_DIVIDER_LINE_COLOR,
    );
  }
}

class BookCoverNameAndAuthorSectionView extends StatelessWidget {
  final BookVO? book;

  BookCoverNameAndAuthorSectionView({required this.book});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 100,
          height: 170,
          decoration: BoxDecoration(
            color: Colors.black26,
            image: DecorationImage(
              image: NetworkImage(
                book?.bookImage ??
                    "https://www.richardsalter.com/wp-content/uploads/2011/07/Cover-not-available.jpg",
              ),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(MARGIN_MEDIUM),
          ),
        ),
        SizedBox(width: MARGIN_MEDIUM_2),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                book?.title ?? "",
                style: const TextStyle(
                  fontSize: MARGIN_LARGE,
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                ),
              ),
              SizedBox(height: MARGIN_XLARGE),
              Text(
                book?.author ?? "",
                style: const TextStyle(
                  color: Color.fromRGBO(10, 118, 189, 1.0),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: MARGIN_MEDIUM),
              Text(
                book?.publisher ?? "",
                style: const TextStyle(
                  color: Color.fromRGBO(94, 98, 101, 1.0),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
