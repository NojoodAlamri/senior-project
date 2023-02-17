import 'package:file_templeate/Auth/signin.dart';
import 'package:file_templeate/screen/sponsor/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePageSponsor extends StatefulWidget {
  const HomePageSponsor({super.key});

  @override
  State<HomePageSponsor> createState() => _HomePageSponsorState();
}

class _HomePageSponsorState extends State<HomePageSponsor> {
  final Stream<QuerySnapshot> _usersStreamPackage = FirebaseFirestore.instance
      .collection('Users')
      .where("role", isEqualTo: "sponser")
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF004079),
        elevation: 0,
        title: Text(
          ' ممول الخدمة  ',
        ),
        leading: IconButton(
          icon: Icon(Icons.abc),
          color: Color(0xFF004079),
          onPressed: () {
          },
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () async{
              await FirebaseAuth.instance.signOut();
              Get.to(()=>Signin());

            },
          ),
        ],
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


              scrollDirection: Axis.vertical,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int i) {
                return InkWell(
                  onTap: () {
                    Get.to(() => ChatScreen(
                      //data: snapshot.data!.docs[i],
                      //ID_Doc:snapshot.data!.docs[i].id
                    ));
                  },
                  child: Container(

                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color:  Color(0xFF869aaf).withOpacity(0.2) ,
                        borderRadius:BorderRadius.circular(25),
                        // border: Border.all(
                        //     color:  Color(0xFF869aaf).withOpacity(0.2) ,
                        //     width: 3
                        // )
                    ),
                    child: Column(

                      children: [
                        ListTile(
                          title: Text(
                            textDirection: TextDirection.rtl,
                            "الاسم: ${snapshot.data!.docs[i]["username"]}",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                            ),
                          ),
                          leading: Icon(
                            Icons.person,
                            color: Color(0xFF004079),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            textDirection: TextDirection.rtl,
                            "الايميل: ${snapshot.data!.docs[i]["email"]}",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                            ),
                          ),
                          leading: Icon(
                            Icons.email,
                            color: Color(0xFF004079),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            textDirection: TextDirection.rtl,
                            "تواصل  ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          leading: Icon(
                            Icons.chat_outlined,
                            color: Color(0xFF004079),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
