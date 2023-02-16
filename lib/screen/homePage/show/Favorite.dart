import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../details/detailsForUser.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  final Stream<QuerySnapshot> _usersStreamPackage =
      FirebaseFirestore.instance.collection('Favorites').where("user_id", isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots();
        CollectionReference ref = FirebaseFirestore.instance.collection("Favorites");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: Text('المفضلة'),
        centerTitle: true,
        backgroundColor: Color(0xFF004079),
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
                return InkWell(
                  onTap: () {
                    Get.to(() => DetailsForUser(
                          ID_Doc:snapshot.data!.docs[i].id,
                          data: snapshot.data!.docs[i],
                        ));
                  },
                  child: Dismissible(
                      // background: Container(
                      //   alignment: Alignment.centerRight,

                      //   color: Theme.of(context).primaryColor,
                      //   child: Icon(
                      //   Icons.delete,
                      //   color: Color.fromARGB(255, 65, 1, 1),
                      //   )),
                      key: Key(snapshot.data!.docs[i]["name"]),
                      onDismissed: (direction) async {
                         await ref.doc(snapshot.data!.docs[i].id).delete().then((value) {
                           Get.snackbar("تمت العملية بنجاح  ", " ",
                           colorText: Colors.white,
                           backgroundColor: Colors.lightBlue,
                           icon: const Icon(Icons.add_alert),
                           snackPosition: SnackPosition.BOTTOM);
                });
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
                  ),
                );
              });
        },
      ),
    );
  }
}
