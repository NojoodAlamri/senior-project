import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';

import '../../../functions/function.dart';
import '../../../widget/services/customTextFild.dart';
import '../../../widget/services/custom_button.dart';
import '../vendorHomePage.dart';

class EditService extends StatefulWidget {
  final ID_doc;
  final data;
  const EditService({super.key, this.ID_doc, this.data});

  @override
  State<EditService> createState() => _EditServiceState();
}

class _EditServiceState extends State<EditService> {
  CollectionReference ref = FirebaseFirestore.instance.collection("Service");
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController salary = TextEditingController();

  bool isSwitched = true;
  var textValue = 'توجد امكانية للحجز ';
  File? myfile;
  var imagename;
  var url;

  @override
  void initState() {
    name.text = widget.data["name"];
    desc.text = widget.data["desc"];
    salary.text = widget.data["salary"];
    print("===================>");
    print(desc.text);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("تعديل خدمة "),
        backgroundColor: Color(0xFF004079),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.abc),
          onPressed: () {
          },
          color: Color(0xFF004079),
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              // color: Color.fromARGB(255, 182, 132, 114),
              padding: EdgeInsets.all(20),
              child: Form(
                  key: formstate,
                  child: Column(
                    children: [
                      CustomTextFild(
                        icon: Icon(Icons.drive_file_rename_outline),
                        hint: "اسم الخدمة ",
                        controller: name,
                        valu: (val) {
                          return validate(val!, 25, 2);
                        },
                      ),
                      CustomTextFild(
                        icon: Icon(Icons.description),
                        hint: "وصف الخدمة ",
                        controller: desc,
                        valu: (val) {
                          return validate(val!, 30, 2);
                        },
                      ),
                      CustomTextFild(
                        icon: Icon(Icons.price_check),
                        hint: " السعر  ",
                        controller: salary,
                        valu: (val) {
                          return validate(val!, 15, 1);
                        },
                      ),
                      Row(children: [
                        Center(
                            child: Switch(
                          onChanged: toggleSwitch,
                          value: isSwitched,
                          activeColor: Colors.blue,
                        )),
                        Text(" امكانية الحجز والطلب حاليا  ")
                      ]),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 213, 204, 204),
                        ),
                        child: myfile == null
                            ? Text(
                                "  قم باضافة صورة ",
                                style: GoogleFonts.getFont('Almarai'),
                              )
                            : Image.file(myfile!),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      serviceButton(
                        text: "اختيار صورةمن الكاميرا ",
                        onTap: () async {
                          await pickImage();
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      serviceButton(
                        text: "اختيار صورة من الاستوديو   ",
                        onTap: () async {
                          await pickImageFormGallary();
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      serviceButton(
                        text: "  تحديث الخدمة   ",
                        onTap: () async {
                          await edit();
                        },
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  Future pickImage() async {
    try {
      XFile? xfile = await ImagePicker().pickImage(source: ImageSource.camera);
      if (xfile != null) {
        setState(() {
          myfile = File(xfile.path);
          imagename = basename(xfile.path);
          print(imagename);
        });
      }
    } on PlatformException catch (e) {
      print("================================");
      print(e);
    }
  }

  Future pickImageFormGallary() async {
    try {
      XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (xfile != null) {
        setState(() {
          myfile = File(xfile.path);
          imagename = basename(xfile.path);
          print(imagename);
        });
      }
    } on PlatformException catch (e) {
      print("================================");
      print(e);
    }
  }

  // Future uploadImage() async {
  //   var rendom = Random().nextInt(1000);
  //   imagename = "$rendom$imagename";
  //  var imageref = FirebaseStorage.instance.ref("images/$imagename");

  //   try {
  //     await imageref.putFile(myfile!);
  //     url = await imageref.getDownloadURL();
  //     print(url.toString());
  //   } on FirebaseException catch (e) {
  //     print(e);
  //   }
  //   return url;
  // }

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        textValue = 'توجد امكانية للحجز ';
      });
      print('$isSwitched توجد امكانية للحجز ');
    } else {
      setState(() {
        isSwitched = false;
        textValue = ' لا يوجد امكانية للحجز ';
      });
      print('$isSwitched لا يوجد امكانية حاليا ');
    }
  }

  edit() async {
    if (myfile == null) {
      await ref.doc(widget.ID_doc).update({
        "name": name.text.trim(),
        "desc": desc.text.trim(),
        "salary": salary.text.trim(),
        "booking": isSwitched.toString(),
      }).then((value) {
        Get.to(() => ShowPackage());
      }).catchError((e) {
        print(e);
      });
    } else {
      var imageref = FirebaseStorage.instance.ref("images/$imagename");
      await imageref.putFile(myfile!);
      url = await imageref.getDownloadURL();
      ref.doc(widget.ID_doc).update({
        "name": name.text.trim(),
        "desc": desc.text.trim(),
        "salary": salary.text.trim(),
        "imageurl": url,
        "booking": isSwitched.toString(),
      }).then((value) {
        Get.to(() => ShowPackage());
      }).catchError((e) {
        print(e);
      });
    }
  }
}
