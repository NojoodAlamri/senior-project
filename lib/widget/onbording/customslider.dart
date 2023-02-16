import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/state_manager.dart';

import '../../OnBording/onBooarding_controller.dart';
import '../../const/imageassets.dart';
import '../../static/static.dart';




class SliderOnBoarding extends GetView<OnBoardingControllerImp> {
  const SliderOnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: PageView.builder(
        controller: controller.pageController,
        onPageChanged: (Value){
      
         controller.onPageChanged(Value);
        },
          itemCount: onBorederList.length,
          itemBuilder: ((context, index) => Column(
                children: [
                  Text(onBorederList[index].Title!, style: StyleText.style),
                  SizedBox(
                    height: 50,
                  ),
                  Image.asset(
                    onBorederList[index].image!,
                    width:  300,
                    height: 300,
                    fit: BoxFit.fill,
                  ),
                  // SizedBox(
                  //   height: 50,
                  // ),
                  // Text(onBorederList[index].body!, style: StyleTextbody.style),
                  
                ],
              ))),
    );
  }
}
