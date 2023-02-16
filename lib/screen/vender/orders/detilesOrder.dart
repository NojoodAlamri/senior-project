import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widget/services/custom_button.dart';

class detilesOrder extends StatefulWidget {
  final data;
  final ID_doc;
  const detilesOrder({super.key, this.data, this.ID_doc});

  @override
  State<detilesOrder> createState() => _detilesOrderState();
}

class _detilesOrderState extends State<detilesOrder> {
  CollectionReference ref = FirebaseFirestore.instance.collection("Orders");
  var options = ['معلقة', 'قيد الانجاز', 'تم الموافقة والحجز'];
  var _currentItemSelected = "";
  var updatval = "معلقة";

  @override
  void initState() {
    _currentItemSelected = widget.data['status'];
    updatval = widget.data['status'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF004079),
        title: Text("تفاصيل الطلب "),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.abc),
          onPressed: () {
          },
          color: Color(0xFF004079),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Container(
              height: 300,

              decoration: BoxDecoration(
                  border: Border.all(
                    color:  Color(0xFF869aaf),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(25)
              ),
              child: Padding(
                padding: EdgeInsets.all(20),

                child: ListView(
                  children: [
                    Row(

                      children: [
                        Container(
                          child: Text(
                            "الاسم: ",
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Center(
                            child: Container(
                          child: Text(
                            "${widget.data['name']}",
                            style: TextStyle(fontSize: 25),
                          ),
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          child: Text(
                            "التاريخ: ",
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Center(
                            child: Container(
                          child: Text(
                            "${widget.data['date']}",
                            style: TextStyle(fontSize: 25),
                          ),
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          child: Text(
                            "التفاصيل: ",
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Center(
                            child: Container(
                          child: Text(
                            "${widget.data['datails']}",
                            style: TextStyle(fontSize: 25),
                          ),
                        )),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          child: Text(
                            "الحالة: ",
                            style: TextStyle(fontSize: 25),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Center(
                            child: Container(
                          child: Text(
                            "$updatval",
                            style: TextStyle(fontSize: 25),
                          ),
                        )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Row(
              children: [
                Container(
                  child: Text(
                    " تغيير الحالة ",
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  height: 50.0,
                  width: 180,
                  child: DropdownButton<String>(
                    iconSize: 24,
                    elevation: 16,
                    dropdownColor: Color.fromARGB(255, 238, 242, 247),
                    isDense: false,
                    isExpanded: true,
                    iconEnabledColor: Color.fromARGB(255, 104, 103, 103),
                    focusColor: Color.fromARGB(255, 124, 122, 122),
                    items: options.map((String dropDownStringItem) {
                      return DropdownMenuItem<String>(
                        value: dropDownStringItem,
                        child: Text(
                          dropDownStringItem,
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      );
                    }).toList(),
                    underline: Container(
                      height: 2,
                      color: Color(0xFF869aaf),
                    ),
                    onChanged: (newValueSelected) {
                      setState(() {
                        _currentItemSelected = newValueSelected!;
                        updatval = newValueSelected;
                      });
                    },
                    value: _currentItemSelected,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          serviceButton(
            text: "تحديث  حالة الطلب ",
            onTap: () async {
              await updateOrder();
            },
          )
        ],
      ),
    );
  }

  updateOrder() async {
    await ref.doc(widget.ID_doc).update({
      "status": updatval,
    }).then((value) {
      Get.snackbar("تم التحديث", "", snackPosition: SnackPosition.BOTTOM);
    }).catchError((e) {
      print(e);
    });
  }
}
