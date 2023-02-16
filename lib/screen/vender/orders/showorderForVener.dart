import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_templeate/screen/vender/vendorHomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'detilesOrder.dart';

class ShowOrderForVender extends StatefulWidget {
  final ID_DOC;
  const ShowOrderForVender({super.key, this.ID_DOC});

  @override
  State<ShowOrderForVender> createState() => _ShowOrderForVenderState();
}

class _ShowOrderForVenderState extends State<ShowOrderForVender> {
  late final Stream<QuerySnapshot> _usersStreamPackage;

  var options = ['معلقة', 'قيد الانجاز', 'تم الموافقة والحجز'];
  var _currentItemSelected = "معلقة";
  var newpros = "معلقة";
  @override
  void initState() {
    fetchData(widget.ID_DOC);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF004079),
        elevation: 0,
        title: Text(
          'عرض الطلبات   ',
          style: GoogleFonts.getFont('Almarai'),
        ),
        // leading: IconButton(
         //  icon: Icon(Icons.arrow_back),
        //   onPressed: () {
        //     Navigator.pushReplacement(context,
        //         MaterialPageRoute(builder: (context) => const ShowPackage()));
        //   },

        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.abc),
          onPressed: () {
          },
          color: Color(0xFF004079),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStreamPackage,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int i) {
                return InkWell(
                  onTap: () {
                    Get.to(() => detilesOrder(
                        data: snapshot.data!.docs[i],
                        ID_doc: snapshot.data!.docs[i].id));
                  },
                  child: Card(
                      elevation: 10,
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(
                          "${snapshot.data!.docs[i]["name"]}",
                          style: TextStyle(
                              color: Color.fromARGB(255, 10, 10, 10),
                              fontSize: 25),
                        ),
                        trailing: Text(
                          "${snapshot.data!.docs[i]["status"]}",
                          style: TextStyle(
                              color: Color.fromARGB(255, 12, 0, 0),
                              fontSize: 25),
                        ),
                      )),
                );
              });
        },
      ),
    );
  }

  fetchData(String searchFild) async {
    _usersStreamPackage = FirebaseFirestore.instance.collection('Orders').where("service_Id", isEqualTo: searchFild).snapshots();
  }
}
