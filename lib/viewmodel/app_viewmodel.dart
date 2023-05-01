import 'dart:developer';

import 'package:akash_word_searcher/custom_widgets/custom_textfield.dart';
import 'package:akash_word_searcher/screens/rows_and_columns_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AppViewModel extends GetxController {
  List<Widget> textFieldinRow = <Widget>[];
  List<Widget> listOfRows = <Widget>[];
  RxBool enableTextField = true.obs;
  TextEditingController searchedTextController = TextEditingController();
  List<List<TextEditingController>> listOfListOfTextEditingControllers = [];
  List<List<String>> listOfListOfStrings = [];
  List<String> indexOfSearchText = [];
  // createListOfString(int rowNumber) {
  //   int numberOfColumns = 4;
  //   List<String> listOfStrings = [];
  //   for (int i = 0; i < numberOfColumns; i++) {
  //     listOfStrings.add("$rowNumber-$i");
  //   }
  //   log(listOfStrings.toString());
  //   return listOfStrings;
  // }

  // createListOfListOfStrings() {
  //   int numberOfRows = 5;
  //   List<List<String>> listOfListOfStrings = [];
  //   for (int i = 0; i < numberOfRows; i++) {
  //     listOfListOfStrings.add(createListOfString(i));
  //   }
  //   log(listOfListOfStrings.toString());
  //   return listOfListOfStrings;
  // }

  // String searchText = "gh";

  // List<List<String>> listOfListOfString = [
  //   ["a", "b", "c"],
  //   ["d", "e", "f"],
  //   ["g", "h", "i"],
  // ];

  checkIfTextEditingCOntrollerHasSameIndex(
      TextEditingController textEditingController,
      List<List<TextEditingController>> listOfListOfTextEditingController) {
    bool shouldHighlightOrNot = false;

    for (var element in indexOfSearchText) {
      findIndexOfTextEditingController(
                  textEditingController, listOfListOfTextEditingController) ==
              element
          ? shouldHighlightOrNot = true
          : null;

      element == "" ? shouldHighlightOrNot = false : null;
    }

    return shouldHighlightOrNot;
  }

  findIndexOfTextEditingController(TextEditingController textEditingController,
      List<List<TextEditingController>> listOfListOfTextEditingController) {
    int onesPlace = -1;
    int tensPlace = -1;

    for (var element in listOfListOfTextEditingController) {
      element.indexOf(textEditingController) != (-1)
          ? tensPlace = listOfListOfTextEditingController.indexOf(element)
          : null;
      element.indexOf(textEditingController) != (-1)
          ? onesPlace = element.indexOf(textEditingController)
          : null;
    }
    // log("onesPlace: $onesPlace, tensPlace: $tensPlace");
    return "$tensPlace$onesPlace";
  }

  getIndicesOfSearchedText(
      String searchText, List<List<String>> listOfListOfString) {
    List<String> indicesOfSearchedText = [];
    List<String> seacrhTextList = searchText.split("");
    String firstText = seacrhTextList.first;
    String secondText = seacrhTextList[1];
    // log("firstText: $firstText");
    // log("secondText: $secondText");
    // log("listOfListOfStrings: $listOfListOfString");
    List<String> indexOfFirstText =
        findTheIndexOfFirstLetter(firstText, listOfListOfString);

    log("indexOfFirstText: $indexOfFirstText");
    log("indicesOfSearchedText Start: $indicesOfSearchedText");

    for (var index in indexOfFirstText) {
      log("indicesOfSearchedText Start2: $indicesOfSearchedText");
      if (indicesOfSearchedText.contains("") || indicesOfSearchedText.isEmpty) {
        indicesOfSearchedText.clear();
        indicesOfSearchedText.add(index);

        List<String> acceptableIndicesForSecondText =
            generateAcceptableIndicesFor2ndLetter(index);

        // log("acceptableIndicesForSecondText: $acceptableIndicesForSecondText");
        String indexOfSecondText = checkWhichIndexContainsTheSecondText(
            acceptableIndicesForSecondText, secondText, listOfListOfString);

        log("indexOfSecondText: $indexOfSecondText");

        indicesOfSearchedText.add(indexOfSecondText);

        List<String> listOfIndicesForNextLetters = indexOfSecondText != ""
            ? generateAcceptableIndicesForNextLetters(
                searchText, index, indexOfSecondText)
            : [];

        // String thirdLetterIndex = listOfIndicesForNextLetters.isNotEmpty &&
        //         listOfIndicesForNextLetters[0] != ""
        //     ? checkIfThirdIndexContainsTheThirdLetter(
        //         listOfIndicesForNextLetters[0], listOfListOfString, searchText)
        //     : "";

        // indicesOfSearchedText.add(thirdLetterIndex);

        if (listOfIndicesForNextLetters.isNotEmpty) {
          for (var value in listOfIndicesForNextLetters) {
            indicesOfSearchedText.add(value);
          }
        }
      }
    }

    log("indicesOfSearchedText End: $indicesOfSearchedText");

    return indicesOfSearchedText;
  }

  String checkIfThirdIndexContainsTheThirdLetter(String thirdLetterIndex,
      List<List<String>> listOfListOfString, String searchedText) {
    return searchedText.split("")[2] ==
            findTheLetterPresentAtAnIndex(thirdLetterIndex, listOfListOfStrings)
        ? thirdLetterIndex
        : "";
  }

  createListOfTextEditingControllers(
      int rowNumber,
      // List<TextEditingController> listOfTextEditingControllers
      int numberOfColumns) {
    // int numberOfColumns = 4;
    List<TextEditingController> listOfTextEditingControllers = [];
    for (int i = 0; i < numberOfColumns; i++) {
      listOfTextEditingControllers.add(TextEditingController());
    }
    // log(listOfStrings.toString());
    return listOfTextEditingControllers;
  }

  createListOfListOfTextEditingControllers(
      int numberOfRows, int numberOfColumns) {
    // int numberOfRows = 5;
    List<List<TextEditingController>> listOfListOfTextEditingControllers = [];
    for (int i = 0; i < numberOfRows; i++) {
      listOfListOfTextEditingControllers
          .add(createListOfTextEditingControllers(i, numberOfColumns));
    }
    // log(listOfListOfStrings.toString());
    return listOfListOfTextEditingControllers;
  }

  createListOfTextFields(int rowNumber, int numberOfColumns,
      List<TextEditingController> listOfTextEditingControllers) {
    // int numberOfColumns = 4;
    List<Widget> listOfTexts = [];
    for (int i = 0; i < numberOfColumns; i++) {
      listOfTexts.add(SizedBox(
          width: 50.0,
          height: 50.0,
          child: CustomTextField(
            textEditingController: listOfTextEditingControllers[i],
          )));
    }
    // log(listOfTexts.toString());
    return Row(
        mainAxisAlignment: MainAxisAlignment.center, children: listOfTexts);
  }

  createListOfRowsOfTextFields(int numberOfRows, int numberOfColumns) {
    // int numberOfRows = 5;
    listOfListOfTextEditingControllers.clear();
    listOfListOfTextEditingControllers =
        createListOfListOfTextEditingControllers(numberOfRows, numberOfColumns);
    List<Widget> listOfRows = [];
    for (int i = 0; i < numberOfRows; i++) {
      listOfRows.add(createListOfTextFields(
          i, numberOfColumns, listOfListOfTextEditingControllers[i]));
    }
    // log(listOfListOlistOfRowsfStrings.toString());
    return Column(
        mainAxisAlignment: MainAxisAlignment.start, children: listOfRows);
  }

  selectTheNextText(String firstText, String secondText) {
    // List<String> indexOfFirstText =
    //     findTheIndexOfFirstLetter(firstText, listOfListOfStrings);
    // List<String> acceptableIndicesForSecondText =
    //     generateAcceptableIndicesFor2ndLetter(indexOfFirstText);
    // checkWhichIndexContainsTheSecondText(
    //     acceptableIndicesForSecondText, secondText, listOfListOfStrings);
  }

  shouldHighLightOrNot() {
    String searchedText = "ab";
    selectTheNextText("a", "b");
  }

  checkWhichIndexContainsTheSecondText(
      List<String> acceptableIndicesForSecondText,
      String secondLetter,
      List<List<String>> listOfListOfStrings) {
    // log("Madhav: $acceptableIndicesForSecondText");
    String indexOfSecondLetter = "";
    for (var element in acceptableIndicesForSecondText) {
      // log("findTheLetterPresentAtAnIndex($element, $listOfListOfStrings) ${findTheLetterPresentAtAnIndex(element, listOfListOfStrings)}");
      findTheLetterPresentAtAnIndex(element, listOfListOfStrings) ==
              secondLetter
          ? indexOfSecondLetter = element
          : null;
    }
    // log("indexOfSecondLetter: $indexOfSecondLetter, acceptableIndicesForSecondText: $acceptableIndicesForSecondText, listOfListOfStrings: $listOfListOfStrings, secondLetter: $secondLetter, ");
    return indexOfSecondLetter;
  }

  generateAcceptableIndexForNextLetter(
      String firstLetterIndex, String secondLetterIndex) {
    int thirdLetterIndex = 0;
    int differenceBetweenBothIndices =
        int.parse(secondLetterIndex) - int.parse(firstLetterIndex);

    thirdLetterIndex =
        int.parse(secondLetterIndex) + differenceBetweenBothIndices;
    // switch (differenceBetweenFirstLetterIndexAndSecondLetterIndex) {
    //   case 1:
    //     thirdLetterIndex = int.parse(nextLetterIndex) + 1;
    //     break;
    //   case 10:
    //     thirdLetterIndex = int.parse(nextLetterIndex) + 10;
    //     break;
    //   case 11:
    //     thirdLetterIndex = int.parse(nextLetterIndex) + 11;
    //     break;
    //   default:
    // }
    // log("thirdLetterIndex: ${thirdLetterIndex.toString().padLeft(2, "0")}");
    return thirdLetterIndex.toString().padLeft(2, "0");
  }

  String findTheLetterPresentAtAnIndex(
      String index, List<List<String>> listOfListOfStrings) {
    int tensPlace = int.parse(index.split("").first);
    int onesPlace = int.parse(index.split("").last);

    return listOfListOfStrings.length - 1 >= tensPlace &&
            listOfListOfStrings[tensPlace].length - 1 >= onesPlace
        ? listOfListOfStrings[tensPlace][onesPlace]
        : "";
  }

  List<String> findTheIndexOfFirstLetter(
      String firstLetter, List<List<String>> listOfListOfStrings) {
    int onesPlace = -1;
    int tensPlace = -1;
    List<String> listOfIndicesForFirstLetter = [];

    for (var element in listOfListOfStrings) {
      if (element.indexOf(firstLetter) != (-1)) {
        tensPlace = listOfListOfStrings.indexOf(element);
        onesPlace = element.indexOf(firstLetter);
        listOfIndicesForFirstLetter.add("$tensPlace$onesPlace");
      }
    }
    // log("listOfIndicesForFirstLetter $listOfIndicesForFirstLetter");
    return listOfIndicesForFirstLetter;
  }

  isTextAcceptable() {
    String firstTextIndex = "00";
    List<String> acceptableIndicesFor2ndLetter = [
      "01",
      "10",
      "11",
    ]; //"10", "11"
  }

  generateAcceptableIndicesForNextLetters(
      String searchedText, String firstLetterIndex, String secondLetterIndex) {
    List<String> acceptableIndices = [];
    List<String> indexOflettersPresentAtAcceptableIndices = [];
    int totalIndicesToGenerate = searchedText.length;

    int difference = int.parse(secondLetterIndex) - int.parse(firstLetterIndex);

    for (int i = 3; i <= totalIndicesToGenerate; i++) {
      acceptableIndices.add(
          (int.parse(secondLetterIndex) + difference * (i - 2))
              .toString()
              .padLeft(2, "0"));
    }

    // log("acceptableIndices: $acceptableIndices");

    for (var element in acceptableIndices) {
      int indexOfElement = acceptableIndices.indexOf(element);
      searchedText.split("")[indexOfElement + 2] ==
              findTheLetterPresentAtAnIndex(element, listOfListOfStrings)
          ? indexOflettersPresentAtAcceptableIndices.add(element)
          : indexOflettersPresentAtAcceptableIndices.add("");
    }

    return indexOflettersPresentAtAcceptableIndices;
  }

  generateAcceptableIndicesFor2ndLetter(String firstLetterIndex) {
    List<String> acceptableIndices = [];
    List<int> numbersToAddToGenerateIndices = [1, 10, 11];
    for (var element in numbersToAddToGenerateIndices) {
      // log("int.parse(firstLetterIndex) + element: ${int.parse(firstLetterIndex) + element}, listOfListOfStrings.length: ${listOfListOfStrings.length}, listOfListOfStrings[0].length ${listOfListOfStrings[0].length}");
      // int.parse(firstLetterIndex) + element > listOfListOfStrings.length ||
      //         int.parse(firstLetterIndex) + element >
      //             listOfListOfStrings[0].length
      //     ? null
      //     :

      acceptableIndices.add(
          (int.parse(firstLetterIndex) + element).toString().padLeft(2, "0"));
    }

    // log(acceptableIndices.toString());
    return acceptableIndices;
  }

  checkSecondLetterIndex(String firstLetterIndex) {
    List<String> acceptableIndices =
        generateAcceptableIndicesFor2ndLetter(firstLetterIndex);
  }

  createListOfListOfStringsFromTextEditingController() {
    listOfListOfStrings.clear();
    for (var element in listOfListOfTextEditingControllers) {
      List<String> listOfString = [];
      for (var value in element) {
        listOfString.add(value.text);
      }
      listOfListOfStrings.add(listOfString);
    }
    // log(listOfListOfStrings.toString());
    return listOfListOfStrings;
  }

  // createListOfTexts(int rowNumber, List<String> listOfStrings) {
  //   int numberOfColumns = 4;
  //   List<Widget> listOfTexts = [];
  //   for (int i = 0; i < numberOfColumns; i++) {
  //     listOfTexts.add(Card(child: Text("${listOfStrings[i]}")));
  //   }
  //   // log(listOfTexts.toString());
  //   return SingleChildScrollView(child: Row(children: listOfTexts));
  // }

  // createListOfRows() {
  //   int numberOfRows = 5;
  //   List<List<String>> listOfListOfStrings = createListOfListOfStrings();
  //   List<Widget> listOfRows = [];
  //   for (int i = 0; i < numberOfRows; i++) {
  //     listOfRows.add(createListOfTexts(i, listOfListOfStrings[i]));
  //   }
  //   // log(listOfListOlistOfRowsfStrings.toString());
  //   return Column(children: listOfRows);
  // }

  disableTextField() {
    enableTextField.value = false;
    update();
  }

  updateUIOnChange() {
    update();
  }

  autoMoveToNextPage() {
    Future.delayed(const Duration(seconds: 5), () {
      Get.to(() => RowsAndColumnSelector());
    });
  }

  Row addTextFieldToRows(
      {required int numberOfTextFields, required Widget widgetToAdd}) {
    textFieldinRow.clear();
    for (int i = 0; i < numberOfTextFields; i++) {
      textFieldinRow.add(widgetToAdd);
    }

// for (int i = 0; i < numberOfTextFields; i++) {
//       listOfRows.add(textFieldinRow);
//     }

    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: textFieldinRow);
  }

  // List<Widget> addRowsToColumn(
  //     {required int numberOfTextFields, required int numberOfRows}) {
  //   listOfRows.clear();
  //   for (int i = 0; i < numberOfRows; i++) {
  //     listOfRows.add(addTextFieldToRows(
  //         numberOfTextFields: numberOfTextFields,
  //         widgetToAdd: CustomTextField()));
  //   }
  //   return listOfRows;
  // }
}
