import 'package:akash_word_searcher/custom_widgets/custom_textfield.dart';
import 'package:akash_word_searcher/viewmodel/app_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class GridCreatorScreen extends StatefulWidget {
  GridCreatorScreen(
      {super.key, required this.numberOfRows, required this.numberOfColumn});
  int numberOfRows;
  int numberOfColumn;

  @override
  State<GridCreatorScreen> createState() => _GridCreatorScreenState();
}

class _GridCreatorScreenState extends State<GridCreatorScreen> {
  AppViewModel model = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    model.enableTextField.value = true;
    model.searchedTextController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Search Word"
        ),
      ),
      body: model.createListOfRowsOfTextFields(
          widget.numberOfRows, widget.numberOfColumn),

      //  Column(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: model.addRowsToColumn(
      //         numberOfTextFields: widget.numberOfColumn,
      //         numberOfRows: widget.numberOfRows)),
      bottomSheet: GetBuilder<AppViewModel>(builder: (controller) {
        return controller.enableTextField.value
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        model.disableTextField();
                        model
                            .createListOfListOfStringsFromTextEditingController();
                      },
                      child: Text("Form Grid")),
                ],
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: model.searchedTextController,
                    // onChanged: (value) {

                    // },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            // controller.searchedTextController.text
                            //     .split("")
                            //     .forEach((value) {
                            //   model.selectTheNextText(value);
                            // });
                            model.indexOfSearchText =
                                model.getIndicesOfSearchedText(
                                    model.searchedTextController.text,
                                    model.listOfListOfStrings);
                            model.updateUIOnChange();
                          },
                          child: Text("Search")),
                      SizedBox(
                        width: 60.0,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            model.indexOfSearchText.clear();
                            model.searchedTextController.clear();
                            model.updateUIOnChange();
                          },
                          child: Text("Reset"))
                    ],
                  )
                ],
              );
      }),
    );
  }
}
