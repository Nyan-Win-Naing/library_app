import 'package:flutter/material.dart';
import 'package:library_app/resources/colors.dart';
import 'package:library_app/resources/dimens.dart';

class ShelfItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: MARGIN_LARGE),
      child: Column(
        children: [
          Container(
            height: 90,
            // color: Colors.black26,
            padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 70,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(MARGIN_SMALL),
                        image: DecorationImage(
                          image: NetworkImage(
                            "https://images-na.ssl-images-amazon.com/images/I/410RTQezHYL._SX326_BO1,204,203,200_.jpg",
                          ),
                          fit: BoxFit.fill,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(5, 0),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: MARGIN_MEDIUM_2 + 2),
                    Container(
                      width: MediaQuery.of(context).size.width * 1.7 / 3,
                      // color: Colors.blue,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "10 Interaction Design Books to Read",
                            style: TextStyle(
                              fontSize: MARGIN_MEDIUM_2 -1,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: MARGIN_MEDIUM),
                          Text(
                            "3 books",
                            style: TextStyle(
                              color: Color.fromRGBO(113,118,121, 1.0),
                              fontSize: MARGIN_CARD_MEDIUM_2,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: SECONDARY_COLOR,
                  size: MARGIN_MEDIUM_3,
                ),
              ],
            ),
          ),
          Container(
            height: 1,
            color: Color.fromRGBO(219, 220, 222, 1.0),
          ),
        ],
      ),
    );
  }
}
