import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_templeate/screen/homePage/show/showServicePlanner.dart';
import 'package:file_templeate/screen/vender/vendorHomePage.dart';
import 'package:file_templeate/screen/vender/orders/showorderForVener.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Auth/signin.dart';
import 'EditePackage.dart';

class PackageDetails extends StatefulWidget {
  final data;
  final ID_doc;
  PackageDetails({
    super.key,
    required this.data,
    this.ID_doc,
  });

  @override
  State<PackageDetails> createState() => _PackageDetailsState();
}

class _PackageDetailsState extends State<PackageDetails> {
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
        "\ريال" + price.toString(),
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
           // child: Icon(Icons.arrow_back, color: Colors.white),
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
        SizedBox(
          height: 10,
        ),
        Text(
          "السعر: ${price.toString()}",
          style: TextStyle(fontSize: 18.0),
        ),
        SizedBox(
          height: 10,
        ),
      ],

    );

    final readButton = Column(
      children: [
       Container(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            width: MediaQuery.of(context).size.width,
            child: MaterialButton(
              onPressed: () => {Get.to(() => ShowOrderForVender(ID_DOC: widget.ID_doc))},
              color: Color(0xFF004079),
              hoverColor: Colors.blue,
              child: Text(
                " اظهار الطلبات   ",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            )),
      ],
    );
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
        title: Text('تفاصيل الباقة '),
        centerTitle: true,
        backgroundColor: Color(0xFF004079),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.abc),
          onPressed: () {
          },
          color: Color(0xFF004079),
        ),
      ),
      body: ListView(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }
}
