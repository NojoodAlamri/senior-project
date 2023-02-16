import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_templeate/Auth/signin.dart';
import 'package:file_templeate/main.dart';
import 'package:file_templeate/screen/sponsor/chat_screen.dart';
import 'package:file_templeate/screen/homePage/show/showServicePlanner.dart';
import 'package:file_templeate/screen/sponsor/HomePageSponsor.dart';
import 'package:file_templeate/screen/vender/vendorHomePage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../functions/function.dart';
import '../style/app_colors.dart';
import '../screen/homePage/HomePage.dart';
import '../widget/Auth/custom_button.dart';
import '../widget/Auth/custom_formfield.dart';
import '../widget/Auth/custom_header.dart';
import '../widget/Auth/custom_richtext.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _userName = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String get userName => _userName.text.trim();
  String get email => _emailController.text.trim();
  String get password => _passwordController.text.trim();
  final _auth = FirebaseAuth.instance;
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  late UserCredential credential;
  String typeuser = "planner";
  var options = ['planner', 'vender', 'sponser'];
  var _currentItemSelected = "planner";
  @override
  Widget build(BuildContext context) {
    bool visiable = true;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              //color: Colors.black87,
              color: Color(0xFF004079),

            ),
            CustomHeader(

                text: 'تسجيل حساب',

                onTap: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const Signin()));
                }),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.1,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.9,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: AppColors.whiteshade,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32))),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Form(
                        key: formstate,
                        child: Column(children: [
                          Container(
                            height: 100,
                            width: MediaQuery.of(context).size.width * 0.8,
                            margin: EdgeInsets.all(30),
                            child: Image.asset("images/logo5.png"),
                          ),

                          CustomFormField(
                            valu: (val) {
                              //  return validate(val!, 10, 4);
                            },
                            headingText: "اسم المستخدم",
                            hintText: "اسم المستخدم",
                            obsecureText: false,
                            suffixIcon: const SizedBox(),
                            maxLines: 1,
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.text,
                            controller: _userName,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomFormField(
                            valu: (val) {
                              //return validate(val!, 15, 10);
                            },
                            headingText: "البريد الالكتروني",
                            hintText: "البريد الالكتروني",
                            obsecureText: false,
                            suffixIcon: const SizedBox(),
                            maxLines: 1,
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.emailAddress,
                            controller: _emailController,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomFormField(
                            valu: (val) {
                              //return validate(val!, 15, 8);
                            },
                            maxLines: 1,
                            textInputAction: TextInputAction.done,
                            textInputType: TextInputType.text,
                            controller: _passwordController,
                            headingText: "كلمة المرور",
                            hintText: "لا تقل عن 6 حروف",
                            obsecureText: visiable,
                            suffixIcon: const SizedBox(),

                          ),
                        ])),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "نوع الحساب   ",
                          style: TextStyle(
                            fontSize: 17,
                            //fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 19, 0, 0),
                          ),
                        ),
                        DropdownButton<String>(
                          dropdownColor: Color.fromARGB(255, 208, 218, 234),
                          isDense: true,
                          isExpanded: false,
                          iconEnabledColor: Color.fromARGB(255, 20, 1, 1),
                          focusColor: Color.fromARGB(255, 17, 1, 1),
                          items: options.map((String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: Text(
                                dropDownStringItem,
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  //fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (newValueSelected) {
                            setState(() {
                              _currentItemSelected = newValueSelected!;
                              typeuser = newValueSelected;
                            });
                          },
                          value: _currentItemSelected,
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    AuthButton(
                      onTap: () async {
                        await signUp();
                      },
                      text: 'انشاء الحساب',
                    ),

                    Center(
                      child: CustomRichText(
                        discription: "             لديك حساب بالفعل؟  ",
                        text: "تسجيل الدخول",
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Signin()));
                        },
                      ),
                    ),
                    // CustomRichText(
                    //   discription: 'Browsing as a visitor ',
                    //   text: 'click here',
                    //   onTap: () async {
                    //     credential =
                    //         await FirebaseAuth.instance.signInAnonymously();
                    //     print(credential);
                    //     // Navigator.pushReplacement(
                    //     //     context,
                    //     //     MaterialPageRoute(
                    //     //         builder: (context) => const Signin()));
                    //   },
                    // ),
                    // CustomRichText(
                    //   discription: 'Already Have an account? ',
                    //   text: 'Log In here',
                    //   onTap: () {
                    //     Navigator.pushReplacement(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => const Signin()));
                    //   },
                    // )
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  signUp() async {
    CircularProgressIndicator();
    if (formstate.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(
              email: email,
              password: password,
            )
            .then((value) => {postDetailsToFirestore(email, typeuser)});
        print("==============================>");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
  }

  postDetailsToFirestore(String email, String typeuser) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var user = _auth.currentUser;
    CollectionReference ref = FirebaseFirestore.instance.collection('Users');
    ref.doc(user!.uid).set({
      'email': email,
      'role': typeuser,
      "status": "false",
      "username": userName
    });
    Get.to(() => Signin());
    ;
  }
}
