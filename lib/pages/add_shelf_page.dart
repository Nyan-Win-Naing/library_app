import 'package:flutter/material.dart';
import 'package:library_app/blocs/add_shelf_bloc.dart';
import 'package:library_app/data/models/book_model.dart';
import 'package:library_app/data/models/book_model_impl.dart';
import 'package:library_app/data/vos/shelf_vo.dart';
import 'package:library_app/resources/colors.dart';
import 'package:library_app/resources/dimens.dart';
import 'package:library_app/resources/strings.dart';
import 'package:provider/provider.dart';

class AddShelfPage extends StatefulWidget {
  @override
  State<AddShelfPage> createState() => _AddShelfPageState();
}

class _AddShelfPageState extends State<AddShelfPage> {
  TextEditingController addShelfFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AddShelfBloc(),
      child: Scaffold(
        backgroundColor: PRIMARY_COLOR,
        appBar: AppBar(
          backgroundColor: PRIMARY_COLOR,
          elevation: 0,
          leading: Builder(
            builder: (context) {
              AddShelfBloc bloc = Provider.of<AddShelfBloc>(context, listen: false);
              return Padding(
                padding: const EdgeInsets.only(left: MARGIN_MEDIUM_3),
                child: GestureDetector(
                  onTap: () {
                    bool validate;
                    validate = bloc.onTapDone(addShelfFieldController.text);
                    if(!validate) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Icon(
                    Icons.done,
                    color: ADD_SHELF_PAGE_BACK_ICON_COLOR,
                    size: MARGIN_XLARGE,
                    key: Key("addShelfDone"),
                  ),
                ),
              );
            }
          ),
        ),
        body: Container(
          height: 80,
          decoration: const BoxDecoration(
            color: PRIMARY_COLOR,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.2),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(0, 1),
              )
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_3),
          child: Selector<AddShelfBloc, bool>(
            selector: (context, bloc) => bloc.validate,
            builder: (context, validate, child) =>
                TextField(
                  controller: addShelfFieldController,
                  key: Key("addShelfField"),
                  style: const TextStyle(
                    fontSize: MARGIN_LARGE,
                  ),
                  decoration: InputDecoration(
                    errorText: validate ? 'Value Can\'t Be Empty' : null,
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2,
                      ),
                    ),
                    hintText: ADD_SHELF_TEXT_FIELD_HINT_TEXT,
                    hintStyle: const TextStyle(
                      color: ADD_SHELF_PAGE_TEXT_FIELD_HINT_TEXT_COLOR,
                      fontSize: MARGIN_LARGE,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
          ),
        ),
      ),
    );
  }
}
