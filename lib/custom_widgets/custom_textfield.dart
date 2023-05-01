import 'package:akash_word_searcher/viewmodel/app_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({super.key, required this.textEditingController});

  AppViewModel model = Get.find();
  TextEditingController textEditingController; // = TextEditingController();
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppViewModel>(
      builder: (controller) {
        bool highLight = false;
        highLight = controller.checkIfTextEditingCOntrollerHasSameIndex(
            textEditingController,
            controller.listOfListOfTextEditingControllers);
        //     controller.searchedTextController.text.split("").forEach((value) {
        //       textEditingController.text == value ? highLight = true : null;
        //     });
        // controller.searchedTextController.text.isNotEmpty ?    model.selectTheNextText(
        //         controller.searchedTextController.text.split("").first) : null;
        return Container(
          margin: const EdgeInsets.all(4.0),
          width: 50.0,
          height: 40.0,
          child: TextFormField(
            focusNode: focusNode,
            textAlign: TextAlign.center,
            controller: textEditingController,
            // onChanged: (value) {
            enabled: model.enableTextField.value,
            onChanged: (value) {
              value.length == 1 ? focusNode.nextFocus() : null;
            },
            // },
            decoration: InputDecoration(
              filled: !model.enableTextField.value,
              fillColor: highLight ? Colors.yellow : Colors.grey,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
