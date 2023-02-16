import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_templeate/screen/admin/showAllPackageAndService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../functions/function.dart';
import '../../../widget/services/customTextFild.dart';
import '../../../widget/services/custom_button.dart';
import '../vendorHomePage.dart';
import '../service/serviceDetails.dart';

class AddOrders extends StatefulWidget {
  final ID_doc;
  const AddOrders({super.key, this.ID_doc});

  @override
  State<AddOrders> createState() => _AddOrdersState();
}

class _AddOrdersState extends State<AddOrders> {
  CollectionReference ref = FirebaseFirestore.instance.collection("Orders");
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController details = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Color(0xFF004079),
        elevation: 0,
        title: Text('إضافة الطلب '),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.abc),
          onPressed: () {
          },
            color: Color(0xFF004079)

        ),
      ),
      body: ListView(
        children: [
          Container(
            // decoration: BoxDecoration(
            //   color: Colors.white,
            //   border: Border.all(color: Colors.blue, width: 4),
            // ),
            // color: Color.fromARGB(255, 182, 132, 114),
            padding: EdgeInsets.all(10),
            child: Form(
                key: formstate,
                child: Column(
                  children: [
                    CustomTextFild(
                      icon: Icon(Icons.person),
                      hint: "الاسم ",
                      controller: name,
                      valu: (val) {
                        // return validate(val!, 25, 2);
                      },
                    ),
                    CustomTextFild(
                      icon: Icon(Icons.password),
                      hint: " التاريخ  ",
                      controller: date,
                      valu: (val) {
                        //return validate(val!, 30, 2);
                      },
                    ),
                    CustomTextFild(
                      icon: Icon(Icons.email),
                      hint: " تفاصيل الطلب   ",
                      controller: details,
                      valu: (val) {
                        //return validate(val!, 15, 1);
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    // serviceButton(
                    //   text: "اختيار صورة   ",
                    //   onTap: () async {
                    //     await pickImage();
                    //   },
                    // ),

                    serviceButton(
                      text: "  اضافة طلب    ",
                      onTap: () async {
                        print("===========>");
                        print(widget.ID_doc);
                        await Add();
                      },
                    ),
                  ],
                )),
          )
        ],
      ),
    );
  }

  Add() async {
    if (formstate.currentState!.validate()) {
      ref.add({
        "user_id": FirebaseAuth.instance.currentUser!.uid,
        "service_Id": widget.ID_doc,

        "name": name.text.trim(),
        "date": date.text.trim(),
        "datails": details.text.trim(),
        "status": "معلقة"
      }).then((value) {
        Get.snackbar("تمت العملية بنجاح  ", " ",
            colorText: Color.fromARGB(255, 5, 4, 4),
            backgroundColor: Color.fromARGB(255, 245, 246, 247),
            icon: const Icon(Icons.add_alert),
            snackPosition: SnackPosition.BOTTOM);
      }).catchError((e) {
        print(e);
      });
    }
  }
}
