import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_templeate/main.dart';
import 'package:file_templeate/screen/admin/showdetilesService.dart';
import 'package:file_templeate/screen/homePage/BottomNavigationBar.dart';
import 'package:file_templeate/screen/homePage/HomePage.dart';
import 'package:file_templeate/screen/homePage/show/showServicePlanner.dart';
import 'package:file_templeate/screen/vender/service/AddService.dart';
import 'package:file_templeate/screen/vender/service/serviceDetails.dart';
import 'package:file_templeate/widget/homeAppBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../Auth/signin.dart';
import '../../../widget/services/custom_button.dart';
import 'showDetilsPackage.dart';

class AdminRole extends StatefulWidget {
  const AdminRole({super.key});

  @override
  State<AdminRole> createState() => _AdminRoleState();
}

class _AdminRoleState extends State<AdminRole> {
  final Stream<QuerySnapshot> _usersStreamPackage = FirebaseFirestore.instance
      .collection('PackageServices')
      .where('Publishing', isEqualTo: "0")
      .snapshots();
  final Stream<QuerySnapshot> _usersStreamService = FirebaseFirestore.instance
      .collection('Service')
      .where('Publishing', isEqualTo: "0")
      .snapshots();

  @override
  void initState() {
    print("===================>");

    print("===================>");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("===========================");
    print(sharedpref.getString("role"));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF004079),
        elevation: 0,
        title: Text(
          'الطلبات المعلقة',
        ),

        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Get.to(() => Signin());
            },
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.abc),
          onPressed: () {
          },
          color: Color(0xFF004079),
        ),
      ),
      body: ListView(children: [
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Text(
        //     ' مجموعة الخدمات ',
        //   ),
        // ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: StreamBuilder<QuerySnapshot>(
            stream: _usersStreamPackage,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.to(() => PackageDetailsForAdmin(
                            data: snapshot.data!.docs[index],
                            ID_doc: snapshot.data!.docs[index].id));
                      },

                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Stack(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  "${snapshot.data!.docs[index]["imageurl"]}",
                                  height: 250,
                                  width: 250,
                                  fit: BoxFit.cover,
                                )),
                            Container(
                              height: 250,
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "${snapshot.data!.docs[index]["name"]}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFF869aaf)
                                    .withOpacity(0.8),
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
          ),
        ),
        // SizedBox(
        //   height: 10,
        // ),

        SizedBox(
          height: 10,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          child: StreamBuilder<QuerySnapshot>(
            stream: _usersStreamService,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.to(() => SeviceDetailsForAdmin(
                          data: snapshot.data!.docs[index],
                          ID_doc: snapshot.data!.docs[index].id));
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Stack(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                "${snapshot.data!.docs[index]["imageurl"]}",
                                height: 250,
                                width: 250,
                                fit: BoxFit.cover,
                              )),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 250,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                "${snapshot.data!.docs[index]["name"]}",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 20),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFF869aaf)
                                .withOpacity(0.8),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ]),
    );
  }
}
