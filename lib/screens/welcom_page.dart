import 'package:akash_word_searcher/viewmodel/app_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  AppViewModel model = Get.put(AppViewModel());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    model.autoMoveToNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome to search word"),
          ],
        ),
      ),
      bottomSheet: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50.0,
            height: 50.0,
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
