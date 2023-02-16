import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';


import '../widget/onbording/custombutton.dart';
import '../widget/onbording/customslider.dart';
import '../widget/onbording/dotcontroller.dart';
import 'onBooarding_controller.dart';


class OnBording extends StatelessWidget {
  const OnBording({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OnBoardingControllerImp());
    return Scaffold(
      body: SafeArea(
          child: Container(
              margin: EdgeInsets.all(50),
              child: Column(
                children: [
                  SliderOnBoarding(),
                  Expanded(
                      child: Column(
                    children: const [

                      DotcontrolleronBoarding(),
                      SizedBox(
                        height: 30,
                      ),
                      CustomButtononBording()
                    ],
                  ))
                ],
              ))),
    );
  }
}
