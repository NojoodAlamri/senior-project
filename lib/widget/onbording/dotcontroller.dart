import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../OnBording/onBooarding_controller.dart';
import '../../static/static.dart';

class DotcontrolleronBoarding extends StatelessWidget {
  const DotcontrolleronBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnBoardingControllerImp>(
        builder: (Controller) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                    onBorederList.length,
                    (index) => AnimatedContainer(
                          margin: EdgeInsets.all(4),
                          duration: const Duration(milliseconds: 400),
                          width: Controller.currentPage == index ? 35 : 10,
                          height: 10,
                          decoration: BoxDecoration(
                              color: Colors.black38,
                              borderRadius: BorderRadius.circular(10)),
                        ))
              ],
            ));
  }
}
