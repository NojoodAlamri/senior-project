import 'package:file_templeate/Auth/signin.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../Auth/signup.dart';
import '../static/static.dart';


abstract class OnBoardingController extends GetxController {
  next();
  onPageChanged(int index);
}

class OnBoardingControllerImp extends OnBoardingController {
  int currentPage = 0;
  late PageController pageController;
  @override
  next() {
    currentPage++;

    if (currentPage > onBorederList.length - 1) {
         Get.off(()=>Signin());
    } else
      pageController.animateToPage(currentPage,
          duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
        
  
  }

  @override
  onPageChanged(int index) {
    currentPage = index;
    update();
  }

  @override
  void onInit() {
    pageController = PageController();
    super.onInit();
  }
}
