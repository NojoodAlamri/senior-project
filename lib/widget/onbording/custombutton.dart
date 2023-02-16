import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/state_manager.dart';

import '../../OnBording/onBooarding_controller.dart';

class CustomButtononBording extends GetView<OnBoardingControllerImp> {
  const CustomButtononBording({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(

        padding: EdgeInsets.symmetric(horizontal: 50),

      onPressed: () {
        controller.next();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          "متابعة",
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
        ),
      ),
      textColor: Colors.white,
      color: Color(0xFF869aaf),


    );
  }
}
