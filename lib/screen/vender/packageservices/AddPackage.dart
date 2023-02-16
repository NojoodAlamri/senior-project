import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../functions/function.dart';
import '../../../widget/homeAppBar.dart';
import '../../../widget/services/customTextFild.dart';
import '../../../widget/services/custom_button.dart';
import '../vendorHomePage.dart';

class AddPackage extends StatefulWidget {
  const AddPackage({super.key});

  @override
  State<AddPackage> createState() => _AddPackageState();
}

class _AddPackageState extends State<AddPackage> {
  CollectionReference ref =
      FirebaseFirestore.instance.collection("PackageServices");
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController salary = TextEditingController();
  bool isSwitched = true;
  var textValue = 'توجد امكانية للحجز ';
  File? myfile;
  var imagename;
  var url;
  final imagePicker = ImagePicker();
  late File imageFile;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF004079),
        elevation: 0,
        title: Text('اضافة باقة خدمات '),
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
              ),
              // color: Color.fromARGB(255, 182, 132, 114),
              padding: EdgeInsets.all(10),
              child: Form(
                  key: formstate,
                  child: Column(
                    children: [
                      CustomTextFild(
                        icon: Icon(Icons.drive_file_rename_outline),
                        hint: "اسم الخدمة ",
                        controller: name,
                        valu: (val) {
                          //return validate(val!, 25, 2);
                        },
                      ),
                      CustomTextFild(
                        icon: Icon(Icons.description),
                        hint: "وصف الخدمة ",
                        controller: desc,
                        valu: (val) {
                          //return validate(val!, 30, 2);
                        },
                      ),
                      CustomTextFild(
                        icon: Icon(Icons.price_check),
                        hint: " السعر  ",
                        controller: salary,
                        valu: (val) {
                          //return validate(val!, 15, 1);
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
                        height: 20,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 213, 204, 204),
                        ),
                        child: myfile == null
                            ? Text(
                                "  قم باضافة صورة ",
                              )
                            : Image.file(myfile!),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      serviceButton(
                        text: "اختيار صورة من الكاميرا   ",
                        onTap: () async {
                          await pickImageFormCamira();
                        },
                      ),
                      SizedBox(
                        height: 5,
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
                      // serviceButton(
                      //   text: "اختيار صورة   ",
                      //   onTap: () async {
                      //     await pickImage();
                      //   },
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      serviceButton(
                        text: "  اضافة الباقة   ",
                        onTap: () async {
                          await Add();
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

  Future pickImageFormCamira() async {
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

  Future uploadImage() async {
    var rendom = Random().nextInt(1000);
    imagename = "$rendom$imagename";
    var imageref = FirebaseStorage.instance.ref("images/$imagename");

    try {
      await imageref.putFile(myfile!);
      url = await imageref.getDownloadURL();
      print(url.toString());
    } on FirebaseException catch (e) {
      print(e);
    }
    return url;
  }

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

  Add() async {
    if (formstate.currentState!.validate()) {
      url = await uploadImage();
      ref.add({
        "name": name.text.trim(),
        "desc": desc.text.trim(),
        "salary": salary.text.trim(),
        "booking": isSwitched.toString(),
        "imageurl": url.toString(),
        "Publishing":"0",
        "user_id": FirebaseAuth.instance.currentUser!.uid.toString()
      }).then((value) {
        Get.to(() => ShowPackage());
      }).catchError((e) {
        print(e);
      });
    }
  }
}

// class showbuttomsheeet extends StatelessWidget {
//   const showbuttomsheeet({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       child: const Text('اختر صورة'),
//       onPressed: () {
//         Scaffold.of(context).showBottomSheet<void>(
//           (BuildContext context) {
//             return Container(
//               height: 170,
//               color: Color.fromARGB(80, 255, 255, 255),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                   Text(
//                     'اختر صورة',
//                     style: TextStyle(color: Colors.blue, fontSize: 25),
//                   ),
//                   InkWell(
//                       onTap: () async {
//                         var picked = await ImagePicker()
//                             .getImage(source: ImageSource.gallery);
//                       },
//                       child: Row(
//                         children: [
//                           Icon(
//                             Icons.photo_outlined,
//                             color: Colors.grey,
//                             size: 30,
//                           ),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Text(
//                             'من الاستديو',
//                             style: TextStyle(color: Colors.blue, fontSize: 20),
//                           ),
//                         ],
//                       )),
//                   InkWell(
//                       onTap: () async {
//                         var picked = await ImagePicker()
//                             .getImage(source: ImageSource.camera);
//                       },
//                       child: Row(
//                         children: [
//                           Icon(
//                             Icons.camera,
//                             size: 30,
//                             color: Colors.grey,
//                           ),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           Text(
//                             'من الكاميرا',
//                             style: TextStyle(color: Colors.blue, fontSize: 20),
//                           ),
//                         ],
//                       )),
//                   ElevatedButton(
//                     child: const Text('موافق'),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }
