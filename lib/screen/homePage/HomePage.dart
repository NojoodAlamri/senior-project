import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_templeate/Auth/signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../vender/service/AddService.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    //fetchData();
    //fetchDataRealTime();
    // batchwrite();
    super.initState();
  }

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('PackageServices')
      .where("user_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          elevation: 0,
          title: Text(
            'الصفحة الرئيسية',
          ),
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back),
          //   onPressed: () {
          //
          //   },
          // ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Signin()));
                //Navigator.pop(context);
              },
            ),
          ],
        ),
        backgroundColor: Colors.black,
        body: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: _usersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading...");
                }

                return GridView.builder(
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int i) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 80, 80, 80),
                          border: Border.all(color: Colors.black, width: 4),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          "${snapshot.data!.docs[i]['name']}",
                        ),
                      );
                    });
              },
            ),
          ],
        ));
  }
}

// fetchData() async {
//   CollectionReference userref =
//       FirebaseFirestore.instance.collection("PackageServices");
//   QuerySnapshot snapshot = await userref.get();
//   List<QueryDocumentSnapshot> listdocs = snapshot.docs;
//   return listdocs;
// }

// show data future
// Widget build(BuildContext context) {
//   return Scaffold(
//       body: Container(
//           child: ListView(
//     children: [
//       FutureBuilder(
//           future: fetchData(),
//           builder: (BuildContext context, AsyncSnapshot snapshot) {
//             if (snapshot.hasData) {
//               return GridView.builder(
//                   shrinkWrap: true,
//                   gridDelegate:
//                       const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2,
//                   ),
//                   itemCount: snapshot.data.length,
//                   itemBuilder: (BuildContext context, int i) {
//                     return Container(
//                       padding: EdgeInsets.all(10),
//                       margin: EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.black, width: 4),
//                         borderRadius: BorderRadius.circular(8),
//                         boxShadow: [
//                           new BoxShadow(
//                             color: Color.fromARGB(255, 246, 250, 246),
//                             offset: new Offset(6.0, 6.0),
//                           ),
//                         ],
//                       ),
//                       child: Text(
//                         "${snapshot.data[i]['name']}",
//                       ),
//                     );
//                   });
//             }
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return CircularProgressIndicator();
//             }
//             if (snapshot.hasError) {
//               return Center(
//                 child: Text(
//                   '${snapshot.error} occurred',
//                   style: TextStyle(fontSize: 18),
//                 ),
//               );
//             }

//             return Text("  لا يوجد اي عقود ");
//           })
//     ],
//   )));
// }

//where("status",wherin:[x,y ,z] )
//where("status",wherenotin:[x,y ,z] )
//where("status",arraycontent:"") serch in filde thate is array
//where("type",isEqualTo:"vender").where("status",isEqualTo:true)  tow conditions
//userref.orderBy("phoneNumber",descending =true).get(); oderby phonenumber
// where("user_id"),isequaltu :firebaseAuth.instanse.curentuser.uid;

// fetch data
//      CollectionReference userref =
//       FirebaseFirestore.instance.collection("PackageServices");
//   QuerySnapshot snapshot = await userref.get();
//   List<QueryDocumentSnapshot> listdocs = snapshot.docs;
//   return listdocs;
// }

// batch same transction  ....all success or all fails
// batchwrite() async {
//   DocumentReference userref = FirebaseFirestore.instance
//       .collection("Users")
//       .doc("NjGVoJk31jwFp3J60REy");
//   DocumentReference userref2 = FirebaseFirestore.instance
//       .collection("Users")
//       .doc("SBdV46iFaMlVfmjxc4ag");
//   WriteBatch batch = FirebaseFirestore.instance.batch();
//   batch.delete(userref);
//   batch.update(userref2, {
//     "name": "Ahmad",
//   });
//   batch.commit();
// }

//        read data real time
//       fetchDataRealTime()async{
//       FirebaseFirestore.instance.collection("Users").snapshots().listen((event) {
//         event.docs.forEach((element) {
//          print("usernaem ${ element.data()['name']} ");
//         });
//       });
// }
