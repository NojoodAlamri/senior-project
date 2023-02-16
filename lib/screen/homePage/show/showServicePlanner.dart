import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_templeate/screen/vender/service/AddService.dart';
import 'package:file_templeate/screen/vender/service/serviceDetails.dart';
import 'package:file_templeate/widget/homeAppBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../widget/services/custom_button.dart';
import '../../vender/packageservices/detailsPackage.dart';
import '../details/detailsServiceForUser.dart';
//import 'AddPackage.dart';
//import 'ShowPackage.dart';
//import 'detailsPackage.dart';

class HomePageService extends StatefulWidget {
  const HomePageService({super.key});

  @override
  State<HomePageService> createState() => _HomePageServiceState();
}

class _HomePageServiceState extends State<HomePageService> {
  final Stream<QuerySnapshot> _usersStreamPackage =
      FirebaseFirestore.instance.collection('Service').where("Publishing",isEqualTo: "1").snapshots();
       String name = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         title: Container(
            padding: EdgeInsets.all(10),
            child: TextFormField(
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
              decoration: InputDecoration(
                hintText:" ابحث هنا",
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(
                        width: 3, color: Color(0xFF004079)
                    )
                ),
                filled: true,
                fillColor: Color(0xff838C96).withOpacity(0.5),
                isDense: true,
                contentPadding: EdgeInsets.all(10),

                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(
                        width: 3, color: Color(0xFF004079)
                    )

                ),
              ),
            ),
          ),
        backgroundColor: Color(0xFF004079),
        leading: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {
          },
          color: Colors.white,
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
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 7 / 8,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                crossAxisCount: 2,
              ),
              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int i) {
                   var data =
                    snapshot.data!.docs[i].data() as Map<String, dynamic>;
                 if (name.isEmpty) {
                  return InkWell(
                    onTap: () {
                      Get.to(() => DetailsServiceForUser(
                            ID_Doc: snapshot.data!.docs[i].id,
                            data: snapshot.data!.docs[i],
                          ));
                    },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Stack(
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              "${snapshot.data!.docs[i]["imageurl"]}",
                              height: 250,
                              width: 400,
                              fit: BoxFit.cover,
                            )),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),

                            child: Container(
                              color: Color(0xFF869aaf).withOpacity(0.8),
                              height: 65,
                              padding: EdgeInsets.all(15),
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                "${snapshot.data!.docs[i]["name"]}",
                                style: TextStyle(color: Colors.white, fontSize: 25),
                              ),

                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
              if (data['name']
                      .toString()
                      .toLowerCase()
                      .startsWith(name.toLowerCase())) {
                     return InkWell(
                    onTap: () {
                      Get.to(() => DetailsServiceForUser(
                            ID_Doc: snapshot.data!.docs[i].id,
                            data: snapshot.data!.docs[i],
                          ));
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Stack(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                "${snapshot.data!.docs[i]["imageurl"]}",
                                height: 250,
                                width: 400,
                                fit: BoxFit.cover,
                              )
                          ),

                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),
                              child: Container(
                                color: Color(0xFF869aaf).withOpacity(0.8),
                                height: 65,
                                padding: EdgeInsets.all(15),
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  "${snapshot.data!.docs[i]["name"]}",
                                  style:
                                      TextStyle(color: Colors.white, fontSize: 25),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                  }    return Container();
              
              
              
              
              
              
              
        });
        },
      ),
    );
  }
}
