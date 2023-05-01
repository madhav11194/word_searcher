import 'package:akash_word_searcher/screens/grid_creator_screen.dart';
import 'package:akash_word_searcher/screens/varsha.dart';
import 'package:akash_word_searcher/viewmodel/app_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class RowsAndColumnSelector extends StatelessWidget {
  RowsAndColumnSelector({super.key});
  TextEditingController rowsController = TextEditingController();
  TextEditingController columnsController = TextEditingController();
  AppViewModel model = Get.put(AppViewModel());
  FocusNode rowFocusNode = FocusNode();
  FocusNode columnFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    model.generateAcceptableIndicesForNextLetters("madhav", "01", "02");
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Word Search"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                "Enter no. of Rows",
                style: TextStyle(fontSize: 20.0),
              ),
              const SizedBox(
                height: 60,
              ),
              TextField(
                focusNode: rowFocusNode,
                controller: rowsController,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  value.length == 1 ? rowFocusNode.nextFocus() : null;
                },
              ),
              const SizedBox(
                height: 60,
              ),
              const Text(
                "Enter no. of Columns",
                style: TextStyle(fontSize: 20.0),
              ),
              const SizedBox(
                height: 60,
              ),
              TextField(
                focusNode: columnFocusNode,
                controller: columnsController,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  value.length == 1 ? columnFocusNode.nextFocus() : null;
                },
              ),
              const SizedBox(
                height: 60,
              ),
              SizedBox(
                  width: 300.0,
                  height: 60.0,
                  child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => GridCreatorScreen(
                              numberOfRows: int.parse(rowsController.text),
                              numberOfColumn: int.parse(columnsController.text),
                            ));

                        // Get.to(() {
                        //   return const VarshaMadhav();
                        // });
                      },
                      child: const Text(
                        "Go to Varsha page",
                        style: TextStyle(fontSize: 20),
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
