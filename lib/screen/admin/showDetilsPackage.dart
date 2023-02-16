import 'dart:ffi';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_templeate/screen/homePage/show/showServicePlanner.dart';
import 'package:file_templeate/screen/vender/vendorHomePage.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../widget/notification.dart';
import '../../../Auth/signin.dart';
import '../homePage/BottomNavigationBar.dart';
import 'showAllPackageAndService.dart';

class PackageDetailsForAdmin extends StatefulWidget {
  final data;
  final ID_doc;
  PackageDetailsForAdmin({
    super.key,
    required this.data,
    this.ID_doc,
  });

  @override
  State<PackageDetailsForAdmin> createState() => _PackageDetailsForAdminState();
}

class _PackageDetailsForAdminState extends State<PackageDetailsForAdmin> {
  CollectionReference ref =
      FirebaseFirestore.instance.collection("PackageServices");
  late String name;
  late String desc;
  late String imageURl;
  late String price;

  @override
  void initState() {
    name = widget.data['name'].toString();
    desc = widget.data['desc'].toString();
    imageURl = widget.data['imageurl'].toString();
    price = widget.data['salary'].toString();
    print(name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final levelIndicator = Container(
      child: Container(
        child: LinearProgressIndicator(
            backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
            value: 10,
            valueColor: AlwaysStoppedAnimation(Colors.green)),
      ),
    );

    final coursePrice = Container(
      padding: const EdgeInsets.all(7.0),
      decoration: new BoxDecoration(
          border: new Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5.0)),
      child: new Text(
        "\$" + price.toString(),
        style: TextStyle(color: Colors.white),
      ),
    );

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 120.0),

        SizedBox(height: 10.0),
        // Text(
        // name,
        //   style: TextStyle(color: Colors.white, fontSize: 45.0),
        // ),
        SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 1, child: levelIndicator),
            // Expanded(
            //     flex: 6,
            //     child: Padding(
            //         padding: EdgeInsets.only(left: 10.0),
            //         child: Text(
            //         name.toString(),
            //           style: TextStyle(color: Colors.white),
            //         ))),
            Expanded(flex: 1, child: coursePrice)
          ],
        ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0),
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: new BoxDecoration(
              color: Color.fromARGB(255, 3, 3, 3).withOpacity(0.5),
              image: new DecorationImage(
                image: new NetworkImage("$imageURl"),
                fit: BoxFit.cover,
              ),
            )),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            //child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );

    final bottomContentText = Column(
      children: [
        Text(
          "اسم الباقة: ${name.toString()}",
          style: TextStyle(fontSize: 18.0),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "التفاصيل: ${desc.toString()}",
          style: TextStyle(fontSize: 18.0),
        ),
        Text(
          "السعر: ${price.toString()}",
          style: TextStyle(fontSize: 18.0),
        )
      ],
    );
    final readButton = Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        width: MediaQuery.of(context).size.width,
        child: MaterialButton(
          textColor: Colors.white,
          onPressed: () async {
            await updataService();
                      
          },
          color: Color(0xFF004079),
          child: Text("  الموافقة على النشر  ",
              style: GoogleFonts.getFont('Almarai')),
        ));
    final bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[bottomContentText, readButton],
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF004079),
        elevation: 0,
        title: Text('تفاصيل الباقة'),
        leading: IconButton(
          icon: Icon(Icons.abc),
          onPressed: () {
          },
          color: Color(0xFF004079),
        ),
        centerTitle: true,
        actions: [

        ],
      ),
      body: ListView(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }

  updataService() async {
    await ref.doc(widget.ID_doc).update({
      "Publishing": "1",
    }).then((value) {
      Get.snackbar("تمت العملية بنجاح  ", "تم الموفقة على النشر ",
          colorText: Colors.white,
          backgroundColor: Colors.lightBlue,
          icon: const Icon(Icons.add_alert),
          snackPosition: SnackPosition.BOTTOM);
      Get.to(() => AdminRole());
    }).catchError((e) {
      print(e);
    });
  }
}
